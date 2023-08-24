#!/bin/sh

# installing wordpress via the cli instead of wget as I couldn't figure out how to set up the title n stuff otherwise
if [ -f ./wp-config.php ]; then
	echo "wordpress already installed"
else
	echo installing wordpress
	/usr/local/bin/wp-cli core download --allow-root --path="/var/www/html"
	# rm -rf wp-config.php
	# cp /usr/local/bin/wp-config.php .
	/usr/local/bin/wp-cli db create --allow-root
	/usr/local/bin/wp-cli config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
	/usr/local/bin/wp-cli core install --allow-root --path="/var/www/html" --url=${DOMAIN_NAME} --title="pdruart's magic palace" --admin_user=${ADMIN_NAME} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL}
	# regular user
	/usr/local/bin/wp-cli user create ${USER_NAME} ${USER_EMAIL} --role=editor --user_pass=${USER_PASSWORD} --allow-root
	#permissions
	chmod 600 wp-config.php
fi

exec "$@"