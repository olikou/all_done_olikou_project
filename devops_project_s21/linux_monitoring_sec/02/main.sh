#!/bin/bash

START="$( date +%s%N )"

# $1 - список букв английского алфавита, используемый в названии папок (не более 7 знаков).
# $2 - список букв английского алфавита, используемый в имени файла и расширении
#      (не более 7 знаков для имени, не более 3 знаков для расширения).
# $3 - размер файла (в Мегабайтах, но не более 100).

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
    BASE_DIR="./02"
    COMMON_DIR="./01"
elif [[ $CURRENT_DIR = */02 ]]; then
    BASE_DIR="."
    COMMON_DIR="../01"
fi

source $COMMON_DIR/validator.sh
source $COMMON_DIR/errors.sh

if [[ $# -ne 3 ]]; then
    error 1 "Three"
elif ! is_correct_word "$1"; then
    error 2 $1 "First"
elif ! is_correct_file_name "$2"; then
    error 2 $2 "Second"
elif ! is_correct_file_size "$3" "Mb"; then
    error 2 $3 "Third"
else
    if source $BASE_DIR/creater.sh; then
        creater $@
    fi
fi

END="$( date +%s%N )"
DIFF="$( echo "scale=3; ($END-$START)/1000000000" | bc | awk '{printf "%.3f", $0}')"

message="Script start $(date -d @$(($START/1000000000)) +'%d.%m.%Y at %H:%M:%S')\n"
message+="Script end $(date -d @$(($END/1000000000)) +'%d.%m.%Y at %H:%M:%S')\n"
message+="Script execution $DIFF min."

echo -e $message
if is_logs_dir_exist; then
    echo -e $message >> $BASE_DIR/logs/$date_of_file_created.log
fi