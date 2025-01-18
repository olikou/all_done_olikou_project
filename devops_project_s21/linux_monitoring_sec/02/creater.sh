#!/bin/bash

function creater {
    dir_finder=$( find / -type d | head -10 | shuf | head -1 )

    dir_first_leter=${1: 0: 1}
    dir_last_leter=${1: ${#1}-1: 1}
    dir_count=$(shuf -i 1-100 -n 1)

    file_name="$(echo $2 | cut -d'.' -f 1)"
    file_ext="$(echo $2 | cut -d'.' -f 2)"
    file_first_leter=${file_name: 0: 1}
    file_last_leter=${file_name: ${#file_name}-1: 1}
    file_counts=$(shuf -i 1-100 -n 1) 

    if [[ $dir_finder =~ (^/bin)|(^/sbin) ]]; then
        continue
    fi

    for ((i = 1; i <= $dir_count; i++)); do
        first_render+=$dir_first_leter
        last_render+=$dir_last_leter

        if (( ${#1} < 3 )); then
            dir_name=$first_render$first_render$1$last_render$last_render"_"$date
        else
            dir_name=$first_render$3$last_render"_"$date
        fi

        if [[ $dir_finder = */ ]]; then
            path=$dir_finder$dir_name
        else
            path=$dir_finder/$dir_name
        fi

        for (( j=0; j < $file_counts; j++ )); do
            file_first_render+=$file_first_leter
            file_last_render+=$file_last_leter

            if [[ ${#file_name} < 3 ]]; then
                file=$file_first_render$file_first_render$file_name$file_last_render$file_last_render"_"$date
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
            elif ! dd if=/dev/zero of=$absolute_path bs=1048576 count=$file_size 2>/dev/null; then
                error 7 $absolute_path "was not created"
            else
                message="File $absolute_path was created $( date +%F' '%T ) with size of $3."
                echo $message
                if is_logs_dir_exist; then
                    echo -e $message >> $BASE_DIR/logs/$date_of_file_created.log
                fi 
            fi

        done

    done
}
