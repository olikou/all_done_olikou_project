#!/bin/bash

function error {
    declare -a errors=(
        [1]=''$2' parameters must be entered.'
        [2]=''$3' parameter "'$2'" is not valid.'
        [3]='Directory "'$2'" '$3'.'
        [4]='Not enough disk space.'
        [5]='Name of path is too large.'
        [6]='Name of file is too large.'
        [7]='File "'$2'" '$3'.'
    )
    echo "Error: ${errors[$1]}"
    if is_logs_dir_exist; then
        echo -e "$date_of_file_created - Error: ${errors[$1]}" \
        >> $BASE_DIR/logs/$date_of_file_created.log 
    fi
    exit 1
} 