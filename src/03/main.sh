#!/bin/bash

source ./color.sh

check_args $@
check_validations $@
check_fon_bg $param_1 $param_2 $param_3 $param_4

colors $param_1 $param_2 $param_3 $param_4
