#########Redirection from a file to a command###############
We can read data from a file as TUEJO with the less-than symbol (>):
$ cmd < file
######Redirecting from a text block enclosed within a script#####
Text can be redirected from a script into a file. To add a warning to the top of an
automatically generated file, use the following code:
#!/bin/bash
cat<<EOF>log.txt
This is a generated file. Do not edit. Changes will be overwritten.
EOF
The lines that appear between cat <<EOF> log.txt and the next EOF line will appear as the stdin data. The contents of log.txt are shown here:
$ cat log.txt

