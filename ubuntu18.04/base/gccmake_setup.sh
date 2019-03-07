#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################
sudo apt update
# make, gcc
sudo apt -y install make gcc

# git
sudo apt -y install git

echo ""
echo ""
echo ""
echo "*** make installed ***"
make --version

echo ""
echo ""
echo ""
echo "*** gcc installed ***"
gcc --version

