#!/bin/bash

# Install requirements
sudo apt install -y build-essential
sudo apt install -y checkinstall
sudo apt install -y libreadline-gplv2-dev
sudo apt install -y libncursesw5-dev
sudo apt install -y libssl-dev
sudo apt install -y libsqlite3-dev
sudo apt install -y tk-dev
sudo apt install -y libgdbm-dev
sudo apt install -y libc6-dev
sudo apt install -y libbz2-dev
sudo apt install -y zlib1g-dev
sudo apt install -y openssl
sudo apt install -y libffi-dev
sudo apt install -y python3-dev
sudo apt install -y python3-setuptools
sudo apt install -y wget
# Prepare to build
mkdir /tmp/Python37
cd /tmp/Python37
# Pull down Python 3.7, build, and install
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
tar xvf Python-3.7.0.tar.xz
cd /tmp/Python37/Python-3.7.0
./configure --enable-optimizations
sudo make altinstall

# Install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3.7 get-pip.py

sudo pip install virtualenv

sudo rm get-pip.py
sudo rm -rf /tmp/Python37

echo ""
echo ""
echo ""
echo "*** Python3.7, pip, virtualenv installed ***"
echo "*** make symbolic link as required ***"
