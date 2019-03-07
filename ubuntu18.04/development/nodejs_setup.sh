#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04
sudo apt update

sudo apt -y install nodejs
sudo apt -y install npm

sudo npm update -g npm
sudo npm install -g n

echo ""
echo ""
echo ""
echo "sudo n [latest version]"
echo "https://stackoverflow.com/questions/8191459/how-do-i-update-node-js"
