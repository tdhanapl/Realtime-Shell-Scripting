#!/bin/bash

user=$1
pass="admin@1234"           # Need some improvement in setting the encrypted password

# Add a user with an accout expiry after 90 days
useradd -d "/home/$user" -m -s "/bin/bash" -f 30 -e $(date +%F -d "+90 days") $user

# Set a default password for user
echo -e "${pass}\n${pass}" | sudo passwd $user

# Force user to reset the password on first login
passwd --expire $user

# Check if the user added successfully
if id "$user" >/dev/null 2>&1; then
        echo "$user - added successfully"
else
        echo "$user - failed to create user"
fi 