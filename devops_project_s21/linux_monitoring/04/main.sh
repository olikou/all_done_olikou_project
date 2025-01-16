#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./04"
DATA_DIR="./03"
else
BASE_DIR="."
DATA_DIR="../03"
fi

. $BASE_DIR/config.sh

if [[ $# -ne 0 ]]; then
    echo "The script is run withowt parameters"
else
    . $DATA_DIR/main.sh $columnn1_background $columnn1_font_color $columnn2_background $columnn2_font_color

    echo
    echo "Column 1 backgound  =  ${output_columnn1_background?} ${colors[${columnn1_background?}]}"
    echo "Column 1 font color =  ${output_columnn1_font_color?} ${colors[${columnn1_font_color?}]}"
    echo "Column 2 backgound  =  ${output_columnn2_background?} ${colors[${columnn2_background?}]}"
    echo "Column 2 font color =  ${output_columnn2_font_color?} ${colors[${columnn2_font_color?}]}"
fi
