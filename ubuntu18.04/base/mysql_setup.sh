#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################

sudo apt update

sudo apt -y install mysql-server

sudo mysql_secure_installation

sudo apt -y install libmysqlclient-dev


echo
echo
echo "*** MySQL setup for your applications ***"
echo "mysql -u root -p"
