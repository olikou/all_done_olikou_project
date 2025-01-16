#!/bin/bash

FOLDERS_TOTAL="$( find $1* -type d 2> /dev/null | wc -l )"
FOLDERS_MAX="$( du -h $1 2> /dev/null | sort -nr | head -n 5 | awk '{print NR, "-", $2 ",", $1 }' )"

FILES_TOTAL="$( find $1* -type f 2> /dev/null | wc -l )"

FILES_MAX=( $( find $1* -type f -exec du -h {} + 2> /dev/null | sort -nr | head -n 10 | awk '{print $2}' ) )

FILES_CONFIG="$( ls -lR $1 2> /dev/null | grep .conf | wc -l )" 
FILES_TEXT="$( ls -lR $1 2> /dev/null | grep .txt | wc -l )"
FILES_LOG="$( ls -lR $1 2> /dev/null | grep .log | wc -l )"
LINKS="$( ls -lR $1 2> /dev/null | grep ^l | wc -l )"
FILES_ARCH="$( find $1* -name '*.a' -o -name '*.tar' -o -name '*.shar' -o -name '*.cpio' -o -name '*.gz' -o -name '*.zip' -o -name  '*.7z' -o -name  '*.rar' 2> /dev/null | wc -l )"

FILES_EXEC="$( find $1* -executable -type f 2> /dev/null | wc -l )"
FILES_EXEC_MAX=( $( find $1* -executable -type f -exec du -h {} + 2> /dev/null | sort -nr | head -n 10 | awk '{print $2}' ) )