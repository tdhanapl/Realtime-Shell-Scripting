Finding the length of a string
Get the length of a variable's value with the following command:
length=${#var}
Shell Something Out
[ 18 ]
Consider this example:
$ var=12345678901234567890$
echo ${#var}
20
The length parameter is the number of characters in the string.