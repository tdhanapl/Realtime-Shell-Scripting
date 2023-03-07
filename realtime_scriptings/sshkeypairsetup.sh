#!/bin/bash

echo "Home Directory : $HOME"
user=`echo $HOME | awk -F"/" '{print $NF}'`
echo $user
nodes=("fedkubemaster" "fedkubenode")
#nodes=("fedser35") nodes means hostname of remote server

copypublickey()
{
        echo "Copy the public ssh key for user : $user to remote nodes to manage"
        for node in ${nodes[@]}; do
        	ssh-copy-id -i $HOME/.ssh/id_rsa.pub $user@$node
	done
}

if [[ -f $HOME/.ssh/id_rsa ]] && [[ -f $HOME/.ssh/id_rsa.pub ]]; then
	echo "SSH key pair avaiable for user : $user"
	copypublickey
else
	echo "Generate SSH keypair for user : $user"
	ssh-keygen -t rsa -q -N '' -f $HOME/.ssh/id_rsa
	copypublickey
fi
