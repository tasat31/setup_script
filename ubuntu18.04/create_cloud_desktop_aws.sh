#!/bin/sh

./base/gccmake_setup.sh
./base/xrdp_setup.sh

./base/xfce4_setup.sh ubuntu
./guacamole/guac_setup.sh ubuntu

sudo passwd ubuntu