#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./03"
else
BASE_DIR="."
fi

. $BASE_DIR/functions.sh

if [[ $# -ne 4 ]]; then
    echo "Four parameters must be entered"
elif parameters_check "$@"; then
    if [[ $1 -eq $2 || $3 -eq $4 ]]; then
        echo "Fonts and background color are the same."
        echo "Restart the script with different parameters."
    else
        if get_data; then
            set_color "$@"
        fi
    fi
fi