#!/bin/bash

function converter {
    printf "%s\n" "$( echo "scale=3; $1/$3" | bc | awk '{printf "%.'$2'f", $0}' )"
}

function get_space {
    printf "%s\n" "$( df / | grep dev )"
}

function data_record {
    echo ""
    read -p "Writing the data to a file? (Y/N): " answer 
    if [[ $answer = [Yy] ]]; then
        $BASE_DIR/data.sh > $BASE_DIR/$FILE_NAME 
        printf "Data written to file %s\n" "$BASE_DIR/$FILE_NAME"
    else
        echo "Data not recorded"
    fi
}
