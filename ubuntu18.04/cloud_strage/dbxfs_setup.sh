#!/bin/bash

sudo apt -y install python3-pip

# https://www.ostechnix.com/dbxfs-mount-dropbox-folder-locally-as-virtual-file-system-in-linux/

sudo apt -y install libfuse2
sudo pip3 install dbxfs

mkdir ~/mydropbox
dbxfs ~/mydropbox

# 
echo "***** edit your config file *****"
dbxfs --print-default-config-file
