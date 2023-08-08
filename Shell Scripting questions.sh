#Task1:  
our task is to use for loops to display only odd natural numbers from 1 to 99.

Answer:
#!/bin/bash

for (( i=1; i<=99; i+=2))
 do
 echo $i
done
 
###Task2:
You are given a file with four space separated columns containing the scores of students in three subjects. The first column contains a single character (), the student identifier. The next three columns have three numbers each. The numbers are between  and , both inclusive. These numbers denote the scores of the students in English, Mathematics, and Science, respectively.
Your task is to identify those lines that do not contain all three scores for students.
##Input Format
There will be no more than  rows of data.
Each line will be in the following format:
[Identifier][English Score][Math Score][Science Score]

##Output Format

For each student, if one or more of the three scores is missing, display:
Not all scores are available for [Identifier]
Sample Input

A 25 27 50
B 35 75
C 75 78 
D 99 88 76


##solutions:
#!/bin/bash

while read -r line; do
    scores=($line)
    identifier=${scores[0]}
    english=${scores[1]}
    math=${scores[2]}
    science=${scores[3]}

    if [[ -z $english || -z $math || -z $science ]]; then
        echo "Not all scores are available for $identifier"
    fi
done


###Task3:
You are given a file with four space separated columns containing the scores of students in three subjects. The first column contains a single character (), the student identifier. The next three columns have three numbers each. The numbers are between  and , both inclusive. These numbers denote the scores of the students in English, Mathematics, and Science, respectively.
Your task is to identify whether each of the students has passed or failed.
A student is considered to have passed if (s)he has a score  or more in each of the three subjects.

##Input Format
There will be no more than  rows of data.
Each line will be in the following format:
[Identifier][English Score][Math Score][Science Score]

##Output Format
Depending on the scores, display the following for each student:
[Identifier] : [Pass] 
or

[Identifier] : [Fail]  
Sample Input

A 25 27 50
B 35 37 75
C 75 78 80
D 99 88 76
Sample Output

A : Fail
B : Fail
C : Pass
D : Pass
Explanation
Only student C and student D have scored   in all three subjects.

Submissions: 272
Max Score: 10
Difficulty: Medium
Rate This Challenge:

    
##Solutions:

#!/bin/bash

while read -r line; do
    scores=($line)
    identifier=${scores[0]}
    english=${scores[1]}
    math=${scores[2]}
    science=${scores[3]}

    if [[ -z $english || -z $math || -z $science ]]; then
        echo "Not all scores are available for $identifier"
    fi
done

