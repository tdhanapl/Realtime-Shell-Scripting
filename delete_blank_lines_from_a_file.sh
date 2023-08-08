#####Delete Blank Lines from a File#########

1 grep -v '^$' filename > newfile: grep's -v flag prints only lines that don't match the pattern. The pattern ^$ matches empty lines.
2 tr -s '\n' < filename > newfile: The tr command can squeeze multiple newline characters into one, effectively deleting blank lines.
3 vim -c "g/^$/d" -c "wq" filename: Even vim can join the party! g/^$/d deletes empty lines, and wq saves the changes and exits.
4 sed '/^$/d' filename: Good old sed! It deletes empty lines. Use -i for in-place changes.
5 awk 'NF' filename > newfile: awk is here too! NF stands for "number of fields". If a line is blank, NF will be zero.
6 perl -ni -e 'print if /\S/' filename: This Perl one-liner only prints lines with non-whitespace characters.
7 python -c "import sys; print(''.join(line for line in sys.stdin if line.strip()), end='')" < filename: A handy Python one-liner that only keeps lines containing non-whitespace characters.