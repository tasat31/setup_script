#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################


# google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Opera
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"

sudo apt update

## google chrome install
sudo apt install google-chrome-stable
## Opera install
sudo apt install opera-stable

# Midori install
# https://www.midori-browser.org/download/
# sudo snap install midori

# tightvnc viewer
if [ -d $HOME/tvnjviewer ]; then
else
   mkdir $HOME/tvnjviewer
fi

wget 'https://www.tightvnc.com/download/2.8.3/tvnjviewer-2.8.3-bin-gnugpl.zip' -O $HOME/tvnjviewer/tvnjviewer-2.8.3-bin-gnugpl.zip

unzip $HOME/tvnjviewer/tvnjviewer-2.8.3-bin-gnugpl.zip -d $HOME/tvnjviewer/
