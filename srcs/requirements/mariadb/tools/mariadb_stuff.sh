#!/bin/sh

#Check if the database exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
        echo "Database already exists"
else

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

chown -R mysql /var/lib/mysql

#we start early and stop it because exec seems to stop the rest of the script (it takes over the process?)
#mysql start
nohup /usr/bin/mariadbd-safe --user=root --datadir=/var/lib/mysql > /dev/null &
bg_pid=$!

sleep 5

mysql_secure_installation <<_EOF_

Y
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
_EOF_

sleep 5

#Create database and user for wordpress
#echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"
#echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

echo "miele miele miele miel"

#mysql stop
kill $bg_pid

sleep 2
fi

exec "$@"