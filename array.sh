#!/bin/bash
##Array Example
Month=(2 4 6 8 10)
echo ${Month[4]}
echo ${Month[@]}
echo ${#Month[@]}
##!/bin/bash
#Define an array using a list of values in a single line:
 array_var=(test1 test2 test3 test4)
  #Values will be stored in consecutive locations starting
   ##Alternately, define an array as a set of index-value pairs:
    array_var[0]="test1"
     array_var[1]="test2"
      array_var[2]="test3"
       array_var[3]="test4"
        array_var[4]="test5"
	 array_var[5]="test6"
	 #2. Print the contents of an array at a given index using the following commands:
	  echo ${array_var[0]}
