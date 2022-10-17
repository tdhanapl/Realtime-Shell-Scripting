#!/bin/bash

echo -n "Are you a student? [yes or no]: "
read response
case $response in

        "Y" | "y" | "YES" | "Yes" | "yes")
                echo -n "Yes, I am a student."
                ;;

        "N" | "n" | "No" | "NO" | "no" | "nO")
                echo -n "No, I am not a student.";
                
                ;;
        *) echo -n "Invalid input"
            ;;
esac