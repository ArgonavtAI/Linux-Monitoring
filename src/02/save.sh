#!/bin/bash

echo "Do you want to write data in file? (Y/n)"
read answer
case "$answer" in
"Y" | "y" ) echo "Success!";;
*) rm -f *status;;
esac