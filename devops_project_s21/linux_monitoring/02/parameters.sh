#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./02"
elif [[ $CURRENT_DIR = */03 || $CURRENT_DIR = */04 ]]; then
BASE_DIR="../02"
else
BASE_DIR="."
fi

. $BASE_DIR/functions.sh

HOST_NAME="$( hostname )"
TIMEZONE="$( timedatectl | grep "Time zone" | awk '{print $3}' ) $(date -u | awk '{print $7}' ) $(date +'%Z')"
OS="$( uname -rs )"
DATE="$( date +'%d %B %Y %T' )"
UPTIME="$( uptime -p | cut -d " " -f2- )"
UPTIME_SEC="$( awk '{print $1}' /proc/uptime )"
IP="$( hostname -I | awk '{print $1}' )"
MASK="$( /sbin/ifconfig | grep "$IP" | awk '{print $4}' )"
GATEWAY="$( ip -4 route show default| awk '{print $3}' )"
RAM_TOTAL="$(converter $( grep MemTotal /proc/meminfo | awk '{print $2}' ) 3 1048576)"
RAM_FREE="$(converter $( grep MemFree /proc/meminfo | awk '{print $2}' ) 3 1048576)"
RAM_USED="$(converter $( vmstat -s | grep "used memory" | awk '{print $1}' ) 3 1048576)"
SPACE_ROOT="$(converter $( get_space | awk '{print $2}' ) 2 1024)"
SPACE_ROOT_USED="$(converter $( get_space | awk '{print $3}' ) 2 1024)"
SPACE_ROOT_FREE="$(converter $( get_space | awk '{print $4}' ) 2 1024)"

FILE_NAME="$( date +'%d_%m_%y_%H_%M_%S' ).status"
