#!/bin/bash
tput setf 2
##eval command is evaluating twice
command="cat /etc/passwd"
echo "$command"
eval $command

