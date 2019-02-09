#!/bin/bash

# https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/

sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

echo "Enter Login password ubuntu: sudo passwd ubuntu"
sudo passwd ubuntu

sudo apt install xrdp xfce4 xfce4-goodies tightvncserver
echo xfce4-session > /home/ubuntu/.xsession

sudo cp /home/ubuntu/.xsession /etc/skel

sudo sed -i '0,/-1/s//ask-1/' /etc/xrdp/xrdp.ini

sudo service xrdp restart
