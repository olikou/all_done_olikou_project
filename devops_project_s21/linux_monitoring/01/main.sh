./C#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "One parameter must be entered"
elif [[ $1 =~ ^-?([0-9]*[.])?[0-9]+$ ]]; then
    echo  "Parameter not valid, it's a number"
elif [[ $1 =~ ^-?([0-9]*[,])?[0-9]+$ ]]; then
    echo  "WTF? I think it's a number too"
elif [[ $1 ]]; then
    printf "%s\n" "$1"
else
    echo "Something went wrong"
fi
