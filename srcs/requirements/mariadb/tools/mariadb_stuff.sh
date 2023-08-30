#!/bin/sh

#Check if the database exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
        echo "Database already exists"
else

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

chown -R mysql /var/lib/mysql

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
echo "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

#mysql stop
kill $bg_pid

sleep 2
fi

exec "$@"