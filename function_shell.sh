#!/bin/sh
#tput setf 2

#A function is defined as follows:
ipaddress () {
	   echo " hostname -i will display ipaddress of server"
	   hostname -i
   }
		or
#Alternatively, it can be defined as:
function ipaddress () {
	   echo " hostname -i will display ipaddress of server"
	   hostname -i
   }
# it can even be defined as follows (for simple functions):
ipaddress
