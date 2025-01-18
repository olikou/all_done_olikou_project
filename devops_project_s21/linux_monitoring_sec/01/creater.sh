#!/bin/bash

function creater {
    dir_first_leter=${3: 0: 1}
    dir_last_leter=${3: ${#3}-1: 1}

    file_name="$(echo $5 | cut -d'.' -f 1)"
    file_ext="$(echo $5 | cut -d'.' -f 2)"
    file_first_leter=${file_name: 0: 1}
    file_last_leter=${file_name: ${#file_name}-1: 1}

    for (( i=0; i < $2; i++ )); do
        first_render+=$dir_first_leter
        last_render+=$dir_last_leter

        if [[ ${#3} = 1 ]]; then
            dir_name=$first_render$first_render$3$last_render"_"$date
        else
            dir_name=$first_render$3$last_render"_"$date
        fi

        if [[ $1 = */ ]]; then
            path=$1$dir_name
        else
            path=$1/$dir_name
        fi

        for (( j=0; j < $4; j++ )); do
            file_first_render+=$file_first_leter
            file_last_render+=$file_last_leter

            if [[ ${#file_name} = 1 ]]; then
                file=$file_first_render$file_first_render$file_name$file_last_render"_"$date
            else
                file=$file_first_render$file_name$file_last_render"_"$date
            fi

            file_full_name="$file.$file_ext"
            absolute_path="$path/$file.$file_ext"

            if (( $space < 1024 )); then
                error 4
            elif (( ${#absolute_path} > 4095 )); then
                error 5 
            elif (( ${#file_full_name} > 255 )); then
                error 6
            elif ! mkdir -p $path; then
                error 3 $path "was not created"
            elif [[ -f $absolute_path ]]; then
                error 7 $absolute_path "already exist"
            # elif ! fallocate -l ${file_size}K $absolute_path 2>/dev/null; then
            elif ! dd if=/dev/zero of=$absolute_path bs=1024 count=$file_size 2>/dev/null; then
                error 7 $absolute_path "was not created"
            else
                message="File $absolute_path was created $( date +%F' '%T ) with size of $6."
                echo $message
                if is_logs_dir_exist; then
                    echo -e $message >> $BASE_DIR/logs/$date_of_file_created.log
                fi 
            fi
        done
    done
}
 