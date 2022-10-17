#############echo command in script of Shell Substitution############
The following escape sequences which can be used in echo command −
SYNOPSIS
       echo [SHORT-OPTION]... [STRING]...
       echo LONG-OPTION
DESCRIPTION
Echo the STRING(s) to standard output.
       -n     do not output the trailing newline
       -e     enable interpretation of backslash escapes
       -E     disable interpretation of backslash escapes (default)
   
#If -e is in effect, the following sequences are recognized:
Sr.No.	Escape 		& Description
1		\\ 			backslash
2		\a 			alert 	(BEL)
3		\b			backspace
4		\c			suppress trailing newline (or) produce no further output
5		\f			form feed
6		\n			new line
7		\r			carriage return
8		\t			horizontal tab
9		\v			vertical tab
10		\e     		escape
11		\0NNN  		byte with octal value NNN (1 to 3 digits)
12            \xHH   		byte with hexadecimal value HH (1 to 2 digits)
13            \s                   matches for space

NOTE:  your  shell  may  have its own version of echo, which usually supersedes the version described here.  Please refer to your shells
       documentation for details about the options it supports.

##We used echo -e to produce the input sequence. The -e option signals to echo to interpret escape sequences. 
If the input is large we can use an input file and the redirection operator to supply input:
$ echo -e "notes\ndocx\n" > input.data
$ cat input.data
notes
docx	   