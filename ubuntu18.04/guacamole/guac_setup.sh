#!/bin/bash

#########################
#  target : Ubuntu18.04 #
#########################

if [ $# -ne 1 ]; then
  echo "Please specify your USERID."
  exit 1
else
  USER=$1
fi

# Pre-requisite
echo "install required package..."
sudo apt -y install libssh2-1-dev libtelnet-dev libpango1.0-dev libossp-uuid-dev libcairo2-dev libpng-dev libjpeg-turbo8-dev libvncserver-dev libfreerdp-dev libvorbis-dev libssl-dev libpulse-dev libwebp-dev libavcodec-dev libavutil-dev libswscale-dev

# JDK
echo "install JDK"
sudo apt -y install openjdk-8-jdk

# Tomcat

echo "install Tomcat"
sudo apt -y install tomcat8 tomcat8-admin tomcat8-docs ghostscript


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
echo "guacd-hostname: localhost"                      | sudo tee    /etc/guacamole/guacamole.properties
echo "guacd-port: 4822"                               | sudo tee -a /etc/guacamole/guacamole.properties
echo "user-mapping: /etc/guacamole/user-mapping.xml"  | sudo tee -a /etc/guacamole/guacamole.properties
echo "auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider" | sudo tee -a /etc/guacamole/guacamole.properties
echo "basic-user-mapping: /etc/guacamole/user-mapping.xml" | sudo tee -a /etc/guacamole/guacamole.properties

sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole

# sudo vi /etc/guacamole/user-mapping.xml
echo "<user-mapping>"                                                         | sudo tee    /etc/guacamole/user-mapping.xml
echo "        <authorize"                                                     | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                username=\"tasat31\""                                   | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                password=\"fbb97712034a90222580dec5eb815c21\""          | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                encoding=\"md5\">"                                      | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                <connection name=\"Ubuntu18.04_terminal\">"             | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <protocol>ssh</protocol>"                       | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <param name=\"hostname\">127.0.0.1</param>"     | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <param name=\"port\">22</param>"                | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                </connection>"                                          | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                <connection name=\"Ubuntu18.04_desktop\">"              | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <protocol>rdp</protocol>"                       | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <param name=\"hostname\">127.0.0.1</param>"     | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <param name=\"port\">3389</param>"              | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <param name=\"enable-drive\">true</param>"      | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                        <param name=\"drive-path\">/home/$USER</param>" | sudo tee -a /etc/guacamole/user-mapping.xml
echo "                </connection>"                                          | sudo tee -a /etc/guacamole/user-mapping.xml
echo "        </authorize>"                                                   | sudo tee -a /etc/guacamole/user-mapping.xml
echo "</user-mapping>"                                                        | sudo tee -a /etc/guacamole/user-mapping.xml

sudo chmod 600 /etc/guacamole/user-mapping.xml
sudo chown tomcat8:tomcat8 /etc/guacamole/user-mapping.xml

sudo /etc/init.d/tomcat8 restart

sudo /etc/init.d/guacd start

sudo ln -s /etc/init.d/guacd /etc/rc0.d/K01guacd
sudo ln -s /etc/init.d/guacd /etc/rc1.d/K01guacd
sudo ln -s /etc/init.d/guacd /etc/rc2.d/S01guacd
sudo ln -s /etc/init.d/guacd /etc/rc3.d/S01guacd
sudo ln -s /etc/init.d/guacd /etc/rc4.d/S01guacd
sudo ln -s /etc/init.d/guacd /etc/rc5.d/S01guacd
sudo ln -s /etc/init.d/guacd /etc/rc6.d/K01guacd

rm -rf guacamole-server-1.0.0
rm -f guacamole-server-1.0.0.tar.gz
rm -f guacamole.war


echo ""
echo ""
echo ""
echo "*** Configuring the files below, and restrat guacd(if needed) ***"
echo "- /etc/guacamole/guacamole.properties"
echo "- /etc/guacamole/user-mapping.xml"
