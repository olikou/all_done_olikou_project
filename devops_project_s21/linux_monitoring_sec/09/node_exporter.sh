#!/bin/bash

if [ "$USER" == "root" ] ; then
    sudo apt install nginx-full
    cp -f misc/nginx.conf /etc/nginx/nginx.conf
    cp -r -f misc/metrics /var/www/html/
    cp -f misc/index.nginx-debian.html /var/www/html/
    nginx -s reload

    cp -f misc/prometheus.yml /etc/prometheus/prometheus.yml
    systemctl daemon-reload
    systemctl restart prometheus

    echo -e "\033[35mMetrics is available by localhost:80/metrics.html\033[0m"
else
    echo -e "\033[31mget root and restart the script\033[0m"
fi
