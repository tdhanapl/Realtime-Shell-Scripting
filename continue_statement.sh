#!/bin/bash
tput setf 2
opt=y
while [ $opt = y -o $opt = y ]
do
#echo -e "please enter the number: \c"
#read -r num
read -p "please enter the number:" num
if [ $num -le 50 ]; then
sq=`expr $num \* $num`
echo "square of provided number $num: $sq"
else
echo "number not in the given ranage"
fi
#echo -e  "do yo want to contine [y/n]: \c"
#read -r wish
read -p "do you want to continue [y/n]: " wish
if [ $wish = y -o $wish = y ]; then
continue
else 
echo "thank you for exiting.."
exit
fi 
done
