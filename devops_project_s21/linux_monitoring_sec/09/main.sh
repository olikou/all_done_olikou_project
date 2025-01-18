#!/bin/bash

while [ 1 ] ; do
    sleep 3
        CPU1=`cat /proc/loadavg | awk '{print $1}'`
        CPU5=`cat /proc/loadavg | awk '{print $2}'`
        CPU15=`cat /proc/loadavg | awk '{print $3}'`
        MEM=`free | grep "Mem" | awk '{print $3}'`
        DISK=`df / | grep "sda" | awk '{print $3}'`
        sed -i "s/s21_node_cpu.*1_min.*\s[^a-zA-Z].*/s21_node_cpu{name=\"1_min\"} $CPU1/g" /var/www/html/metrics/index.html
        sed -i "s/s21_node_cpu.*[^1]5_min.*\s[^a-zA-Z].*/s21_node_cpu{name=\"5_min\"} $CPU5/g" /var/www/html/metrics/index.html
        sed -i "s/s21_node_cpu.*15_min.*\s[^a-zA-Z].*/s21_node_cpu{name=\"15_min\"} $CPU15/g" /var/www/html/metrics/index.html
        sed -i "s/s21_node_mem\s[^a-zA-Z].*/s21_node_mem $MEM/g" /var/www/html/metrics/index.html
        sed -i "s/s21_node_disk\s[^a-zA-Z].*/s21_node_disk $DISK/g" /var/www/html/metrics/index.html
done
