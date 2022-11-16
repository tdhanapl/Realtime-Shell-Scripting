#!/bin/bash
list_files=$(find /var/log -type f -mtime +15 -exec ls -lrth {} \;)
archive_files=$(find /var/log -type f -mtime +15 -exec tar -cvf archive_repo.tar  {} \;)
echo "$list_files"
echo "$archive_files"