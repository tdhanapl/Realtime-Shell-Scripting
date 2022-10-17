########special variables#######
########Arguments##############
# $*(postional parameter) stores all the command line arguments by joining them together.
# $# specifies the total number (count) of arguments passed to the script.
# $1-$9 stores the names of the first 9 arguments or can be used as the arguments positions.
# $@ stores the list of arguments as an array or treated as sperate arguments.
# $? specifies the exit status of the last command or the most recent execution process.
# $$ specifies the process ID of the current script..
# $! shows ID of the last background job.
# $0 spec

#!/bin/bash
tput setf 2
echo "File Name: $0"
echo "First Parameter : $1"
echo "Second Parameter : $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"
echo "process id for this $$"