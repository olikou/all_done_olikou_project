#!/bin/bash

CURRENT_DIR=$(pwd)

if [[ $CURRENT_DIR = */src ]]; then
BASE_DIR="./05"
elif [[ $CURRENT_DIR = */05 ]]; then
BASE_DIR="../05"
fi

. $BASE_DIR/parameters.sh

echo "Total number of folders (including all nested ones) = $FOLDERS_TOTAL" 
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$FOLDERS_MAX" 
echo "Total number of files = $FILES_TOTAL"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $FILES_CONFIG"
echo "Text files = $FILES_TEXT"  
echo "Executable files = $FILES_EXEC"
echo "Log files (with the extension .log) = $FILES_LOG" 
echo "Archive files = $FILES_ARCH"  
echo "Symbolic links = $LINKS"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
count=1
for element in "${FILES_MAX[@]}"
do
    FILE_NAME="${element%.*}"
    FILE_TYPE="${element:${#FILE_NAME} + 1}"
    FILE_SIZE="$( du -h $element | awk '{print $1}' )"
    echo -e "$count - $element, $FILE_SIZE $FILE_TYPE"
    count=$(( "$count" + 1 ))
done

if [[ $FILES_EXEC -ne 0 ]]; then
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
count=1
for element in "${FILES_EXEC_MAX[@]}"
do
    FILE_NAME="${element%.*}"
    FILE_MD5="$( md5sum $element | awk '{print $1}' )"
    FILE_SIZE="$( du -h $element | awk '{print $1}' )"
    echo -e "$count - $element, $FILE_SIZE, $FILE_MD5"
    count=$(( "$count" + 1 ))
done
fi
