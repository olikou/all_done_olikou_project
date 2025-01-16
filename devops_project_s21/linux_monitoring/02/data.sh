#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./02"
elif [[ $CURRENT_DIR = */03 || $CURRENT_DIR = */04 ]]; then
BASE_DIR="../02"
else
BASE_DIR="."
fi

. $BASE_DIR/parameters.sh

echo "HOSTNAME = $HOST_NAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS" 
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL Gb"
echo "RAM_USED = $RAM_USED Gb"
echo "RAM_FREE = $RAM_FREE Gb"
echo "SPACE_ROOT = $SPACE_ROOT MB"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED MB"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB"
