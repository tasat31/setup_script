#!/bin/bash
# https://rclone.org/
# https://www.ostechnix.com/how-to-mount-google-drive-locally-as-virtual-file-system-in-linux/

sudo apt -y install rclone

rclone config

# after rclone config
# ex. GoogleDrive

# mkdir ~/mygoogledrive
# rclone mount mygoogledrive: ~/mygoogledrive &
