#!/bin/sh

# installing wordpress via the cli instead of wget as I couldn't figure out how to set up the title n stuff otherwise
if [ -f ./wp-config.php ]; then
	echo "wordpress already installed"
else
	echo installing wordpress
	wp core download --allow-root --path="/var/www/html"
	# rm -rf wp-config.php
	# cp /usr/local/bin/wp-config.php .
	wp db create --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
	wp core install --allow-root --path="/var/www/html" --url=${DOMAIN_NAME} --title="the magic palace of pdruart" --admin_user=${ADMIN_NAME} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL}
	# regular user
	wp user create ${USER_NAME} ${USER_EMAIL} --role=editor --user_pass=${USER_PASSWORD} --allow-root
	#permissions
	chmod 600 wp-config.php
fi

exec "$@"
