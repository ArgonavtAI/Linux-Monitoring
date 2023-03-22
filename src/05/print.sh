#!/bin/bash

dirFolder=`sudo find $1 -type d | wc -l`
topFolder=`sudo du -Sh $1 | sort -rh | head -5 | cat -n | awk '{print $1" - "$3", "$2}'`
dirFiles=`sudo find $1 -type f | wc -l`
confFiles=`sudo find $1 -type f -name "*.conf" | wc -l`
exeFiles=`sudo find $1 -type f -executable -exec du -h {} + | wc | awk '{ print $1 }'`
txtFiles=`sudo find $1 -type f -name "*.txt" | wc -l`
logFiles=`sudo find $1 -type f -name "*.log" | wc -l`
archFiles=`sudo find $1 -regex '.*\(tar\|zip\|gz\|rar\)' | wc -l`
linkFiles=`sudo find $1 -type l | wc -l`
topFiles=`sudo find $1 -type f -exec du -Sh {} + | sort -rh | head -10 | cat -n | awk '{print $1" - "$3", "$2}'`
binFiles=`sudo find $1 -type f -exec du -h {} + | sort -hr | head -10 | cat -n | awk '{print $1" - "$3", "$2}'`


function print {
echo -e "Total number of folders (including all nested ones) = $dirFolder"
echo -e "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$topFolder"
echo "Total number of files = $dirFiles"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $confFiles"
echo "Text files = $txtFiles"
echo "Executable files = $exeFiles"
echo "Log files (with the extension .log) = $logFiles"
echo "Archive files = $archFiles"
echo "Symbolic links = $linkFiles"
echo "TOP 10 files of maximum size arranged in descending order (path, size):"
echo "$topFiles"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size)"
echo "$binFiles"
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "Script execution time (in seconds) = $DIFF"
}
