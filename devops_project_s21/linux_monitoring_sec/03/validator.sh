#!/bin/bash

source $BASE_DIR/cleaning.sh

function is_have_parameter {
    logfile="^$DATA_DIR/logs/*.+\.log$"
    timestamp="([0-9]{4})(-[0-9]{2}){2} ([0-9]{2}):([0-9]{2}) ([0-9]{2})"
    mask="[a-zA-Z]_([0-9]{6})"
    if [[ -z $2 ]]; then
        if read -p "Enter next parameter ($3): " parameter && ! [[ -z $parameter ]]; then
            if [[ $1 = 1 ]] && [[ -f $parameter ]] && [[ $parameter =~ $logfile ]]; then 
                clean_by_logfile $parameter
            elif [[ $1 = 2 ]] && [[ $parameter =~ $timestamp ]]; then
                clean_by_timestamp $parameter
            elif [[ $1 = 3 ]] && [[ $parameter =~ $mask ]]; then 
                clean_by_mask $parameter
            else
                echo 'Parametr "'$parameter'" is not valid.'
            fi
        else
            echo "Invalid parameter."
        fi
    elif [[ $1 = 1 ]] && [[ -f $2 ]] && [[ $2 =~ $logfile ]]; then 
        clean_by_logfile $2
    elif [[ $1 = 2 ]] && [[ $2 =~ $timestamp ]]; then 
        clean_by_timestamp $2
    elif [[ $1 = 3 ]] && [[ $2 =~ $mask ]]; then 
        clean_by_mask $2
    else
        echo 'Parametr "'$2'" is not valid.'
    fi
}