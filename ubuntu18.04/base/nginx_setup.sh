#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################

# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04

sudo apt update

sudo apt -y install nginx

echo "*** recommend Nginx configuration ***"
echo "sudo ufw allow 'Nginx HTTP'"
echo "sudo ufw status"
