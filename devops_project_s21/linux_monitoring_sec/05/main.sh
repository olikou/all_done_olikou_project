#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
    BASE_DIR="./05"
    DATA_DIR="./04"
elif [[ $CURRENT_DIR = */05 ]]; then
    BASE_DIR="."
    DATA_DIR="../04"
fi

if ! [[ $# -eq 1 ]]; then
    echo "One parameter must be entered."
    exit 1
fi

logs="$( echo $DATA_DIR/nginx_combined_*.log )"

case $1 in
    1) cat $logs | awk -F' ' '{print $0}' | sort -k 10 ;;
    2) cat $logs | awk -F' ' '{print $1}' | sort -u ;;
    3) cat $logs | awk -F' ' '{print $10,$0}' | sort -k 10 | egrep '(^4)|(^5)' | cut -f2- -d' ' ;;
    4) cat $logs | awk -F' ' '($10 ~ /4**/ || $10 ~ /5**/) {print $1,$10}' | sort -u -k 1,1 ;;
    *) echo "Invalid parameter." ;;
esac