#!/bin/bash
if (( $# != 0 ));
    then
    echo "Error"
else
file=$(date +"%d_%m_%Y_%H_%M_%S".status)
touch $file
    echo "HOSTNAME =  $(hostname)" | tee -a $file
    echo "TIMEZONE =" `cat /etc/timezone` UTC `date +"%:::z"` | tee -a $file
    echo "USER =" $(whoami) | tee -a $file
    echo "OS =" $(cat /etc/issue | cut -d " " -f 1-3) | tee -a $file
    echo "DATE =" $(date -R | cut -d " " -f 2-5) | tee -a $file
    echo "UPTIME =" $(uptime -p) | tee -a $file
    echo "UPTIME_SEC =" $(cat /proc/uptime | cut -d " " -f 1) | tee -a $file
    echo "IP =" $(hostname -I) | tee -a $file
    echo "MASK =" $(ifconfig | grep -m1 "netmask" | awk '{print $4}') | tee -a $file
    echo "GATEWAY   = $(ip r | grep default | awk '{print $3}')" | tee -a $file
    echo "RAM_TOTAL =" $(free -m | grep Mem | awk '{printf("%.3f Gb\n",$2 / 1024)}') | tee -a $file
    echo "RAM_USED  = $(free -m | grep Mem | awk '{printf("%.3f Gb\n",$3 / 1024)}')" | tee -a $file  
    echo "RAM_FREE  = $(free -m | grep Mem | awk '{printf("%.3f Gb\n",$4 / 1024)}')" | tee -a $file 
    echo "SPACE_ROOT= $(df -hk | grep "\/$" | awk '{printf("%.2f Mb\n",$2 / 1024)}')" | tee -a $file
    echo "SPACE_ROOT_USED =" $(df /root/ | head -2 | tail +2 | awk '{printf("%.2f Mb\n", $3/1024)}') | tee -a $file
    echo "SPACE_ROOT_FREE =" $(df /root/ | head -2 | tail +2 | awk '{printf("%.2f Mb\n", $4/1024)}') | tee -a $file

chmod +x save.sh
./save.sh
fi