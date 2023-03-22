#!/bin/bash

source ./colors.conf 

check='^[1-6]$'
param_1=$column1_background
param_2=$column1_font_color
param_3=$column2_background
param_4=$column2_font_color

HOSTNAME=$(hostname)
TIMEZONE="$(cat /etc/timezone) $(date -u "+%Z %z")"
USER=$(whoami)
OS=$(cat /etc/issue | cut -d " " -f 1-3)
DATE=$(date -R | cut -d " " -f 2-5)
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | cut -d " " -f 1)
IP=$(hostname -I)
MASK=$(ifconfig | grep -m1 "netmask" | awk '{print $4}')
GATEWAY=$(ip r | grep default | awk '{print $3}')
RAM_TOTAL=$(free -m | grep Mem | awk '{printf("%.3f Gb\n",$2 / 1024)}')
RAM_USED=$(free -m | grep Mem | awk '{printf("%.3f Gb\n",$3 / 1024)}')
RAM_FREE=$(free -m | grep Mem | awk '{printf("%.3f Gb\n",$4 / 1024)}')
SPACE_ROOT=$(df -hk | grep "\/$" | awk '{printf("%.2f Mb\n",$2 / 1024)}')
SPACE_ROOT_USED=$(df /root/ | head -2 | tail +2 | awk '{printf("%.2f Mb\n", $3/1024)}')
SPACE_ROOT_FREE=$(df /root/ | head -2 | tail +2 | awk '{printf("%.2f Mb\n", $4/1024)}')


function check_args() {
if [ $# -ne 0 ] ; then
echo "Please run the script with 0 digit parameters!"
exit 1
fi
}

temp=0
function check_validations() {
    if ! [[ $column1_background =~ $check ]] || ! [[ $column1_font_color =~ $check ]] ||
       ! [[ $column2_background =~ $check ]] || ! [[ $column2_font_color =~ $check  ]];
   then
        def_colors
        temp=1
    else
        colors
    fi

}

function def_colors() {
  param_1=6
  param_2=4
  param_3=6
  param_4=2 
}

function set_colors() {
  $param_1=$column1_background
  $param_2=$column1_font_color
  $param_3=$column2_background
  $param_4=$column2_font_color

}

function check_fon_bg() {
if [[ $param_1 == $param_2 ]] || [[ $param_3 == $param_4 ]];
then
    echo "The font or background color are the same"
    def_colors
fi
}

function output {
  echo -e ${key_bg_color}${key_font_color}"HOSTNAME"${default_color} = ${value_bg_color}${value_font_color}${HOSTNAME}${default_color}
  echo -e ${key_bg_color}${key_font_color}"TIMEZONE"${default_color} = ${value_bg_color}${value_font_color}${TIMEZONE}${default_color}
  echo -e ${key_bg_color}${key_font_color}"USER"${default_color} = ${value_bg_color}${value_font_color}${USER}${default_color}
  echo -e ${key_bg_color}${key_font_color}"OS"${default_color} = ${value_bg_color}${value_font_color}${OS}${default_color}
  echo -e ${key_bg_color}${key_font_color}"DATE"${default_color} = ${value_bg_color}${value_font_color}${DATE}${default_color}
  echo -e ${key_bg_color}${key_font_color}"UPTIME"${default_color} = ${value_bg_color}${value_font_color}${UPTIME}${default_color}
  echo -e ${key_bg_color}${key_font_color}"UPTIME_SEC"${default_color} = ${value_bg_color}${value_font_color}${UPTIME_SEC}${default_color}
  echo -e ${key_bg_color}${key_font_color}"IP"${default_color} = ${value_bg_color}${value_font_color}${IP}${default_color}
  echo -e ${key_bg_color}${key_font_color}"MASK"${default_color} = ${value_bg_color}${value_font_color}${MASK}${default_color}
  echo -e ${key_bg_color}${key_font_color}"GATEWAY"${default_color} = ${value_bg_color}${value_font_color}${GATEWAY}${default_color}
  echo -e ${key_bg_color}${key_font_color}"RAM_TOTAL"${default_color} = ${value_bg_color}${value_font_color}${RAM_TOTAL}${default_color}
  echo -e ${key_bg_color}${key_font_color}"RAM_USED"${default_color} = ${value_bg_color}${value_font_color}${RAM_USED}${default_color}
  echo -e ${key_bg_color}${key_font_color}"RAM_FREE"${default_color} = ${value_bg_color}${value_font_color}${RAM_FREE}${default_color}
  echo -e ${key_bg_color}${key_font_color}"SPACE_ROOT"${default_color} = ${value_bg_color}${value_font_color}${SPACE_ROOT}${default_color}
  echo -e ${key_bg_color}${key_font_color}"SPACE_ROOT_USED"${default_color} = ${value_bg_color}${value_font_color}${SPACE_ROOT_USED}${default_color}
  echo -e ${key_bg_color}${key_font_color}"SPACE_ROOT_FREE"${default_color} = ${value_bg_color}${value_font_color}${SPACE_ROOT_FREE}${default_color}
}

function color_num {
 res=0
  case "$1" in
  1) res=7 ;;
  2) res=1 ;;
  3) res=2 ;;
  4) res=4 ;;
  5) res=5 ;;
  6) res=0 ;;
  esac
return $res
}

function colors() {
  color_num $param_1
  key_bg_color="\033[4$?m"
  color_num $param_2
  key_font_color="\033[3$?m"
  color_num $param_3
  value_bg_color="\033[4$?m"
  color_num $param_4
  value_font_color="\033[3$?m"
  default_color="\033[0m" 
}

function text_output {
  case "$1" in
  1) echo "1 (white)" ;;
  2) echo "2 (red)" ;;
  3) echo "3 (green)" ;;
  4) echo "4 (blue)" ;;
  5) echo "5 (purple)" ;;
  6) echo "6 (black)" ;;
  esac
}

function print_information {
  echo -e "\nColumn 1 background = $(if [[ $1 -eq 1 ]] ; then echo "default" ; else echo $column1_bg; fi) $(text_output $param_1)"
  echo "Column 1 font color = $(if [[ $1 -eq 1 ]] ; then echo "default" ; else echo $column1_font; fi) $(text_output $param_2)"
  echo "Column 2 background = $(if [[ $1 -eq 1 ]] ; then echo "default" ; else echo $column2_bg; fi) $(text_output $param_3)"
  echo "Column 2 font color = $(if [[ $1 -eq 1 ]] ; then echo "default" ; else echo $column2_font; fi) $(text_output $param_4)"
}

function classic_color() {
  check_validations
  colors
  output
  print_information $temp
}

