#!/bin/sh

if [ -f /usr/local/bin/wp-cli ]; then
	echo "wp-cli already installed"
else
	echo installing wp-cli
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp-cli
fi

# installing wordpress via the cli instead of wget as I couldn't figure out how to set up the title n stuff otherwise
if [ -f ./wp-config.php ]; then
	echo "wordpress already installed"
else
	echo installing wordpress
	wp-cli core download --allow-root
	rm -rf wp-config.php
	cp /usr/local/bin/wp-config.php .
	wp-cli core install --allow-root --url=${DOMAIN_NAME} --title="pdruart's magic palace" --admin_user=${ADMIN_NAME} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} --skip-email
	# regular user
	wp-cli user create --allow-root ${USER_NAME} ${USER_EMAIL} --role=author --user_pass=${USER_PASSWORD}
fi

exec "$@"