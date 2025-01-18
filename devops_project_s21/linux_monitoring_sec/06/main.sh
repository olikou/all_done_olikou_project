#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
    BASE_DIR="./06"
    DATA_DIR="./04"
elif [[ $CURRENT_DIR = */06 ]]; then
    BASE_DIR="."
    DATA_DIR="../04"
fi

#bash $DATA_DIR/main.sh
goaccess $( echo $DATA_DIR/nginx_combined_1.log ) -o $BASE_DIR/report.html --log-format=COMBINED
