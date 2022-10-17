#!/bin/bash
tput setf 2
set `date`
echo "count $#"
echo "$1 $2 $3 $4"
shift
echo "$1 $2 $3 $4"
shift 
echo "$1 $2 $3 $4"
