#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./03"
DATA_DIR="./02"
else
BASE_DIR="."
DATA_DIR="../02"
fi

normal='\033[0m'

declare -a color
color[1]='\033[37m' # white
color[2]='\033[31m' # red
color[3]='\033[32m' # green
color[4]='\033[34m' # blue
color[5]='\033[35m' # purple
color[6]='\033[30m' # black

declare -a bgcolor
bgcolor[1]='\033[47m' # white
bgcolor[2]='\033[41m' # red
bgcolor[3]='\033[42m' # green
bgcolor[4]='\033[44m' # blue
bgcolor[5]='\033[45m' # purple
bgcolor[6]='\033[40m' # black

function is_correct_number {
    [[ $1 =~ ^[[:digit:]]+$ ]] && (( $1 > 0 )) && (( $1 < 7 ))
}

function get_data {
    $DATA_DIR/data.sh > $BASE_DIR/data.sh
}

function parameters_check {
    count=1
    for parameter in "$@"
    do
    if ! is_correct_number "$parameter"; then
        printf "Parameter \"%s\" not valid\n" "$parameter"
        exit 0
    fi
    count=$(( "$count" + 1 ))
    done
}

function set_color {
    while IFS= read -r line
    do
        column=( $( echo "$line" | awk 'BEGIN{RS="="}{print}' ) )
        echo -e "${bgcolor[$1]}${color[$2]} ${column[0]} $normal = ${bgcolor[$3]}${color[$4]} ${column[@]:1} $normal"
    done < $BASE_DIR/data.sh

    rm -rf $BASE_DIR/data.sh
}
