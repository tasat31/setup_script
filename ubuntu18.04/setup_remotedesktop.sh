#!/bin/bash

# https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/

sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

sudo apt -y install xrdp

sudo apt -y install xfce4 xfce4-goodies
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc
#sudo apt install tightvncserver
echo xfce4-session > /home/$USER/.xsession

sudo cp /home/$USER/.xsession /etc/skel

sudo sed -i '0,/-1/s//ask-1/' /etc/xrdp/xrdp.ini

sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale

sudo service xrdp restart
