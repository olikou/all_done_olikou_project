#!/bin/bash

date="$( date +%d%m%y )"
date_of_file_created="$( date +%F_%H-%M )"
space="$( df -hm / | awk 'NR==2{print $4}' )"

function is_empty {
    [[ -z $1 ]]
}

function is_correct_path {
    [[ $1 =~ ([\\/]?([^*|\\/:\"<>]*))+$ ]]
}

function is_folder_exist {
    [[ -d $1 ]]
}

function is_correct_number {
    is_empty && [[ $1 =~ ^[[:digit:]]+$ ]]
}

function is_correct_word {
    [[ $1 =~ ^[[:alpha:]]{1,7}$ ]]
}

function is_correct_file_name {
    [[ $1 =~ ^([[:alpha:]]{1,7})[.]([[:alpha:]]{1,3})$ ]]
}

function is_correct_file_size {
    file_size="$( echo "$1" | awk -F "$2" '{print $1}' )"
    [[ $1 =~ ^([[:digit:]]{1,3})$2$ ]] && (( $file_size >= 0 )) && (( $file_size <= 100 ))
}

function is_logs_dir_exist {
    if ! mkdir -p $BASE_DIR/logs/; then
        mkdir -p $BASE_DIR/logs/
        touch $BASE_DIR/logs/$date_of_file_created.log
    fi
}
