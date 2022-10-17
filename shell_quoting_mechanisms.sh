#!/bin/bash

##Double quotes take away the special meaning of all characters except the following −
# $ for parameter substitution
# \ Backquotes for command substitution
# \s matches for spaces
# \$ to enable literal dollar signs
# \` to enable literal backquotes
# \" to enable embedded double quotes
# \\ to enable embedded backslashes
# All other \ characters are literal (not special)

echo It\'s Shell Programming
echo  "Shell Programming \$200"
echo  "hell Programming \"200\""
echo "Shell Programming \\200\\"
