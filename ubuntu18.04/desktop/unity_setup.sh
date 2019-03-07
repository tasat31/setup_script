#!/bin/bash

# https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-to-ubuntu-1604-windows/

if [ $# -ne 1 ]; then
  echo "Please specify your USERID."
  exit 1
else
  USERDIR=$1
fi

# https://www.linode.com/docs/applications/remote-desktop/remote-desktop-using-apache-guacamole-on-docker/
# https://www.hiroom2.com/2015/06/13/xrdp%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95/
sudo apt install -y --no-install-recommends ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc

echo ""
echo "***** editing ... /home/$USERDIR/.xsession *****"
echo gnome-session > /home/$USERDIR/.xsession

echo ""
echo "***** sudo cp /home/$USERDIR/.xsession /etc/skel *****"
sudo cp /home/$USERDIR/.xsession /etc/skel

sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale

echo "***** restarting xrdp server *****"
sudo service xrdp restart
echo "Done"
