#!/bin/bash
# A script to clear lsof deleted files from all sessions

# List open files that are linked to deleted files
output=$(lsof +L1)

# Iterate over the lines of the output
while read -r line; do
  # Extract the file descriptor (FD), process ID (PID), and file name
  fd=$(echo "$line" | awk '{print $4}'| tr -d 'r|u|w' | grep -v FD)
  pid=$(echo "$line" | awk '{print $2}')
  file=$(echo "$line" | awk '{print $9}')

  # Close the FD if it is linked to a deleted file
  if [ ! -e "$file" ]; then
    sudo /bin/bash -c "echo -n > /proc/$pid/fd/$fd"
  fi
done <<< "$output"