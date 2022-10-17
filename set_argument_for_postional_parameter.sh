#!/bin/bash
tput setf 2
set `date`
echo "today is $1"
echo "month is $2"
echo "date is $3"
echo "time H;M;D $4"
echo "timezone is $5"
echo "year is $6"
set -x
