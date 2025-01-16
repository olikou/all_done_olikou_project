#!/bin/bash

START="$( date +%s%N)"
CURRENT_DIR="$(pwd)"

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./05"
else
BASE_DIR="."
fi

if [[ -z $1 ]]; then
    echo "Parameter not specified"
elif [[ $# -gt 1 ]]; then
    echo "Parameter should be only one"
elif [[ $1 =~ ([\\/]?([^*|\\/:\"<>]*))*/+$ ]]; then
    if [[ -d $1 ]]; then
        . $BASE_DIR/data.sh
        END="$( date +%s%N)"
        DIFF="$( echo "scale=3; ( $END - $START )/1000000000" | bc | awk '{printf "%.3f", $0}' )"
        echo "Script execution time (in seconds) = $DIFF"
    else
        echo "Directory no found"
    fi
else
    echo "Parameter not valid"
fi