###############String manipulation using parameter expansion####
#Use the ^ symbol to convert the first character in a string to uppercase.
MSG="aBcDeFg"
echo ${MSG^}
ABcDeFg

##Use the ^^ symbols to convert the all lowercase characters in a string to uppercase.
MSG="aBcDeFg"
echo ${MSG^^}
ABCDEFG

##Use the , symbol to convert the first character in a string to lowercase.
MSG="TuVwXyZ"
echo ${MSG,}
tuVwXyZ
##Use the ,, symbols to convert all characters in a string to lowercase.
MSG="TuVwXyZ"
echo ${MSG,,}
tuvwxyz

##Word replacement
MSG="Say hi to Chris and Sidney"
echo ${MSG//Chris/Billy}
Say hi to Billy and Sidney

##Character replacement using regular expressions
MSG="I need 10"
echo ${MSG//[a-zA-Z]/X}
X XXXX 10
Replace all alphabetic characters with the character X but leave the numerals alone.

## symbol to get the substring after the characters The starting from the left side of the string # The
MSG="The Rolling Stones"
echo ${MSG#The}
Rolling Stones

##Use the % symbol to get the substring before the characters Rolling Stones starting the right side of the string % Rolling Stones
MSG="The Rolling Stones"
echo ${MSG%Rolling Stones}
#returns The