#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./02"
else
BASE_DIR="."
fi

if [[ $# -ne 1 ]]; then
    . $BASE_DIR/data.sh
    data_record
else
    echo "Without parameters, please"
fi

