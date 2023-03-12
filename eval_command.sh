#!/bin/bash
##eval command is evaluating twice
command="cat /etc/passwd"
echo "$command"
eval $command

