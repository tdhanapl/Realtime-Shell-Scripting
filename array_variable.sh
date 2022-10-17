##Arrays can be defined using different techniques:
1. Define an array using a list of values in a single line:
 array_var=(test1 test2 test3 test4)
 #Values will be stored in consecutive locations starting
 from index 0.
Alternately, define an array as a set of index-value pairs:
 array_var[0]="test1"
 array_var[1]="test2"
 array_var[2]="test3"
 array_var[3]="test4"
 array_var[4]="test5"
 array_var[5]="test6"

2. Print the contents of an array at a given index using the following commands:
$ echo ${array_var[0]}
 test1
 index=5
 echo ${array_var[$index]}
 test6
3. Print all of the values in an array as a list, using the following commands:
$ echo ${array_var[*]}
 test1 test2 test3 test4 test5 test6
 Alternately, you can use the following command:
$ echo ${array_var[@]}
 test1 test2 test3 test4 test5 test6
4. Print the length of an array (the number of elements in an array):
$ echo ${#array_var[*]}6