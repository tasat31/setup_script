#!/bin/bash

# https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/

if [ $# -ne 1 ]; then
  echo "Please specify your USERID."
  exit 1
else
  USERDIR=$1
fi

sudo apt -y install xfce4 xfce4-goodies
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc

echo ""
echo "***** editing ... /home/$USERDIR/.xsession *****"
echo xfce4-session > /home/$USERDIR/.xsession

echo ""
echo "***** sudo cp /home/$USERDIR/.xsession /etc/skel *****"
sudo cp /home/$USERDIR/.xsession /etc/skel

sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale

echo "***** restarting xrdp server *****"
sudo service xrdp restart
echo "Done"
