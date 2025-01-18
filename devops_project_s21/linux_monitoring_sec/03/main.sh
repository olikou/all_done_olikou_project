#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
    BASE_DIR="./03"
    DATA_DIR="./02"
elif [[ $CURRENT_DIR = */03 ]]; then
    BASE_DIR="."
    DATA_DIR="../02"
fi

source $BASE_DIR/validator.sh

case $1 in
1) is_have_parameter "$1" "$2" "relative or absolute path to .log file" ;;
2) is_have_parameter "$1" "$2" "timestamp in format \"YYYY-MM-DD HH:MM  MM\"" ;;
3) is_have_parameter "$1" "$2" "mask in format a-zA-Z_DDMMYY" ;;
*) echo "Invalid parameter." ;;
esac