#!/bin/bash

function clean_by_logfile {
    while read line; do
        file="$( echo "$line" | awk -F " " '{print $2}' )"
        file_name="$( echo "$file" | awk -F "/" '{print $(NF)}' )"
        dir=${file//${file_name}/ }
        if [[ $dir =~ / ]]; then
            if [[ -d $dir ]] && rm -rf $dir 2>/dev/null; then 
                echo "Folders and files have been deleted."
            fi
        fi
    done < $1
}

function clean_by_timestamp {
    if ! [[ -d $DATA_DIR/logs/ ]]; then
        echo "No data for this operation."
        exit 1
    fi

    time_end="$( date -d "$2 $3 minutes" +'%H:%M' )"
    time_label=$2
    while [[ "$time_label" != "$time_end" ]]; do
        grep $time_label $DATA_DIR/logs/*.log | awk -F " " '{print $2}' >> $BASE_DIR/files_for_delete.log
        time_label="$( date -d "$time_label 1 minutes" +'%H:%M')"
    done
    while read line; do
        if rm -rf $line 2>/dev/null; then 
            echo "File $line have been deleted."
        fi

        file_name="$( echo "$line" | awk -F "/" '{print $(NF)}' )"
        dir=${line//${file_name}/ }

        if [[ -z "$(ls $dir 2>/dev/null)" ]]; then
            if [[ -d $dir ]] && rmdir $dir 2>/dev/null; then 
                echo "Empty folder $dir have been deleted."
            fi
        fi

        rm -rf  $BASE_DIR/files_for_delete.log

    done < $BASE_DIR/files_for_delete.log
}

function clean_by_mask {
    if ! [[ -d $DATA_DIR/logs/ ]]; then
        echo "No data for this operation."
        exit 1
    fi

    grep $1 $DATA_DIR/logs/*.log | awk -F " " '{print $2}' >> $BASE_DIR/files_for_delete.log
    while read line; do
        if rm -rf $line 2>/dev/null; then 
            echo "File $line have been deleted."
        fi

        file_name="$( echo "$line" | awk -F "/" '{print $(NF)}' )"
        dir=${line//${file_name}/ }

        if [[ -z "$(ls $dir 2>/dev/null)" ]]; then
            if [[ -d $dir ]] && rmdir $dir 2>/dev/null; then 
                echo "Empty folder $dir have been deleted."
            fi
        fi

        rm -rf  $BASE_DIR/files_for_delete.log

    done < $BASE_DIR/files_for_delete.log
}