#!/bin/bash

# Setup R and RStudio with other related packages

./tools/R_setup.sh

# For RStudio publishing
./tools/latex_setup.sh
./tools/libreoffice_setup.sh

./base/mysql_setup.sh

./development/nodejs_setup.sh
./development/python37_setup.sh

# For RStudio publishing
mkdir /tmp/statsv
pushd /tmp/statsv

# https://rstudio.com/products/rstudio/download-server/debian-ubuntu/
# Install RStudio http://...:8787
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.5019-amd64.deb
sudo gdebi rstudio-server-1.2.5019-amd64.deb

rm rstudio-server-1.2.5019-amd64.deb

popd

# https://www.scipy.org/install.html
sudo pip3 install numpy scipy matplotlib ipython jupyter pandas sympy nose
#sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose

# https://jupyterhub.readthedocs.io/en/stable/quickstart.html#prerequisites

sudo pip3 install jupyterhub
sudo npm install -g configurable-http-proxy
sudo pip3 install notebook  # needed if running the notebook servers locally

# sudo pip3 install jupyterlab


jupyterhub -h
configurable-http-proxy -h

# To allow multiple users to sign in
# sudo jupyterhub
# http://...:8000
jupyterhub
