#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################

# Pre-requisite
echo "install required package..."
sudo apt install libssh2-1-dev libtelnet-dev libpango1.0-dev libossp-uuid-dev libcairo2-dev libpng-dev libjpeg-turbo8-dev libvncserver-dev libfreerdp-dev libvorbis-dev libssl-dev libpulse-dev libwebp-dev libavcodec-dev libavutil-dev libswscale-dev

# JDK
echo "install JDK"
sudo apt install openjdk-8-jdk

# Tomcat

echo "install Tomcat"
sudo apt install tomcat8 tomcat8-admin tomcat8-docs ghostscript


# guacamole-server-1.0.0

wget 'http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.0.0/source/guacamole-server-1.0.0.tar.gz' -O guacamole-server-1.0.0.tar.gz

tar -xzf guacamole-server-1.0.0.tar.gz
cd guacamole-server-1.0.0/

./configure --with-init-dir=/etc/init.d

make

sudo make install
cd ..

sudo ldconfig

wget 'http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.0.0/binary/guacamole-1.0.0.war' -O guacamole.war

sudo cp guacamole.war /var/lib/tomcat8/webapps

# etc config
sudo mkdir /etc/guacamole
sudo mkdir /usr/share/tomcat8/.guacamole

# sudo vi /etc/guacamole/guacamole.properties
sudo echo "guacd-hostname: localhost" >  /etc/guacamole/guacamole.properties
sudo echo "guacd-port: 4822"          >> /etc/guacamole/guacamole.properties
sudo echo "user-mapping: /etc/guacamole/user-mapping.xml"  >> /etc/guacamole/guacamole.properties
sudo echo "auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider" >> /etc/guacamole/guacamole.properties
sudo echo "basic-user-mapping: /etc/guacamole/user-mapping.xml" >> /etc/guacamole/guacamole.properties

sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole

# sudo vi /etc/guacamole/user-mapping.xml
sudo echo "<user-mapping>" > /etc/guacamole/user-mapping.xml
sudo echo "        <authorize" >> /etc/guacamole/user-mapping.xml
sudo echo "                username=\"tasat31\"" >> /etc/guacamole/user-mapping.xml
sudo echo "                password=\"fbb97712034a90222580dec5eb815c21\"" >> /etc/guacamole/user-mapping.xml
sudo echo "                encoding=\"md5\">" >> /etc/guacamole/user-mapping.xml
sudo echo "                <connection name=\"Ubuntu18.04_terminal\">" >> /etc/guacamole/user-mapping.xml
sudo echo "                        <protocol>ssh</protocol>" >> /etc/guacamole/user-mapping.xml
sudo echo "                        <param name=\"hostname\">127.0.0.1</param>" >> /etc/guacamole/user-mapping.xml
sudo echo "                        <param name=\"port\">22</param>" >> /etc/guacamole/user-mapping.xml
sudo echo "                </connection>" >> /etc/guacamole/user-mapping.xml
sudo echo "                <connection name=\"Ubuntu18.04_desktop\">" >> /etc/guacamole/user-mapping.xml
sudo echo "                        <protocol>rdp</protocol>" >> /etc/guacamole/user-mapping.xml
sudo echo "                        <param name=\"hostname\">127.0.0.1</param>" >> /etc/guacamole/user-mapping.xml
sudo echo "                        <param name=\"port\">3389</param>" >> /etc/guacamole/user-mapping.xml
sudo echo "                </connection>" >> /etc/guacamole/user-mapping.xml
sudo echo "        </authorize>" >> /etc/guacamole/user-mapping.xml
sudo echo "</user-mapping>" >> /etc/guacamole/user-mapping.xml

sudo chmod 600 /etc/guacamole/user-mapping.xml
sudo chown tomcat8:tomcat8 /etc/guacamole/user-mapping.xml

sudo /etc/init.d/tomcat8 restart

sudo /etc/init.d/guacd start

rm -rf guacamole-server-1.0.0
rm -f guacamole-server-1.0.0.tar.gz
rm -f guacamole.war
