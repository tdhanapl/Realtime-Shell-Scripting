######Printing a colored output######
A script can use escape sequences to produce colored text on the terminal.
#Colors for text are represented by color codes, including, reset = 0, black = 30, red = 31, green= 32, yellow = 33, blue = 34, magenta = 35, cyan = 36, and white = 37.
#To print colored text, enter the following command:
$ echo -e "\e[1;32m This is red text \e[0m"
			or
$ echo -e "\e[1;32m This is red text \e[32m"			
Here, \e[1;32m is the escape string to set the color to red and \e[0m resets the color back.
#Replace 32 with the required color code.
#For a colored background, reset = 0, black = 40, red = 41, green = 42, yellow = 43, blue = 44, magenta = 45, cyan = 46, and white=47, are the commonly used color codes.
#To print a colored background, enter the following command:
$ echo -e "\e[1;42m Green Background \e[0m"
			or
$ echo -e "\e[1;42m Green Background \e[42m"


