#!/bin/bash

# $1 - абсолютный путь. 
# $2 - количество вложенных папок. 
# $3 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
# $4 - количество файлов в каждой созданной папке. 
# $5 - список букв английского алфавита, используемый в имени файла и расширении
#      (не более 7 знаков для имени, не более 3 знаков для расширения). 
# $6 - размер файлов (в килобайтах, но не более 100).

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./01"
elif [[ $CURRENT_DIR = */01 ]]; then
BASE_DIR="."
fi

source $BASE_DIR/validator.sh
source $BASE_DIR/errors.sh

if [[ $# -ne 6 ]]; then
    error 1 "Six"
elif ! is_correct_path "$1" || ! is_folder_exist "$1"; then
    error 3 $1 "not found"
elif ! is_correct_number "$2"; then
    error 2 $2 "Second"
elif ! is_correct_word "$3"; then
    error 2 $3 "Third"
elif ! is_correct_number "$4"; then
    error 2 $4 "Fourth"
elif ! is_correct_file_name "$5"; then
    error 2 $5 "Fifs"
elif ! is_correct_file_size "$6" "kb"; then
    error 2 $6 "Sixth"
else
    if source $BASE_DIR/creater.sh; then
        creater $@
    fi
fi
