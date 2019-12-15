#!/bin/bash

# ngspice
sudo apt install ngspice

# https://snapcraft.io/qucs-spice
sudo apt-get install qt5-default
sudo snap install qucs-spice

# Change locale for qucs-spice
# TODO: Qt localization
sudo localectl set-locale LANG=en_US.utf8 LANGUAGE="en_US:en"

# OpenFDTD
# Linux version, also Windows version is available 
pushd ~
wget http://www.e-em.co.jp/OpenFDTD/OpenFDTD.zip
unzip OpenFDTD.zip
rm OpenFDTD/*.exe OpenFDTD/*.dll
pushd OpenFDTD/src
cp Makefile_gcc Makefile
make
popd
popd

# OpenModelica
for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | sudo tee /etc/apt/sources.list.d/openmodelica.list

wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | sudo apt-key add -
apt-key fingerprint

sudo apt update
sudo apt install openmodelica
sudo apt install omlib-.* # Installs optional Modelica libraries (most have not been tested with OpenModelica)
