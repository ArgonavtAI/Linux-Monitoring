#!/bin/bash
source ./print.sh

START=$(date +%s)
if [ $# -ne 1 ]; then
	echo "Error: invalid arguments"
else
	if ! [[ $1 == */ ]]; then
		echo "Error: invalid syntax"
	else
		print
	fi
fi

