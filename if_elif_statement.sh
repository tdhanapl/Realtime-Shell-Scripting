#!/bin/bash
var=$1
if [ "$var" = "foo" ]; 
then
        echo "bar"
elif [ "$var" = "bar" ]; 
then
echo "foo"
else
echo "try gain"
fi 