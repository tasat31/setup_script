#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################

# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04

sudo apt update

sudo apt install nginx

sudo apt install mysql-server

sudo mysql_secure_installation

sudo apt install libmysqlclient-dev

# https://thishosting.rocks/install-php-on-ubuntu/

# !! Attempt to Apache server !!
#sudo apt install php php-mysql

echo "*** recommend Nginx configuration ***"
echo "sudo ufw allow 'Nginx HTTP'"
echo "sudo ufw status"
echo
echo "*** MySQL setup for your applications ***"
echo "mysql -u root -p"

# ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
