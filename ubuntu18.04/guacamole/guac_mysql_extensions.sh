#!/bin/bash

wget 'http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.0.0/binary/guacamole-auth-jdbc-1.0.0.tar.gz' -O guacamole-auth-jdbc-1.0.0.tar.gz

tar -xzf guacamole-auth-jdbc-1.0.0.tar.gz

cd guacamole-auth-jdbc-1.0.0

echo "DROP DATABASE IF EXISTS guacamole_db;" | sudo mysql -u root
echo "CREATE DATABASE guacamole_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;" | sudo mysql -u root
echo "CREATE USER 'guacamole_user'@'localhost' IDENTIFIED BY 'some_password';" | sudo mysql -u root guacamole_db
echo "GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'localhost';" | sudo mysql -u root guacamole_db
echo "FLUSH PRIVILEGES;" | sudo mysql -u root guacamole_db

cat mysql/schema/001-create-schema.sql     | sudo mysql -u root guacamole_db
cat mysql/schema/002-create-admin-user.sql | sudo mysql -u root guacamole_db
#cat mysql/schema/upgrade/upgrade-pre-1.0.0.sql | mysql -u root -p guacamole_db

# 1. Create the GUACAMOLE_HOME/extensions directory, if it does not already exist.
sudo mkdir /etc/guacamole/extensions
sudo cp mysql/guacamole-auth-jdbc-mysql-1.0.0.jar /etc/guacamole/extensions/

cd ..

echo "# MySQL properties"             | sudo tee    /etc/guacamole/guacamole.properties
echo "mysql-hostname: localhost"      | sudo tee -a /etc/guacamole/guacamole.properties
echo "mysql-port: 3306"               | sudo tee -a /etc/guacamole/guacamole.properties
echo "mysql-database: guacamole_db"   | sudo tee -a /etc/guacamole/guacamole.properties
echo "mysql-username: guacamole_user" | sudo tee -a /etc/guacamole/guacamole.properties
echo "mysql-password: some_password"  | sudo tee -a /etc/guacamole/guacamole.properties

rm guacamole-auth-jdbc-1.0.0.tar.gz
rm -rf guacamole-auth-jdbc-1.0.0

sudo apt install libmysql-java
sudo mkdir /etc/guacamole/lib
sudo cp /usr/share/java/mysql-connector-java-5.1.45.jar /etc/guacamole/lib

sudo /etc/init.d/tomcat8 restart

sudo /etc/init.d/guacd restart
