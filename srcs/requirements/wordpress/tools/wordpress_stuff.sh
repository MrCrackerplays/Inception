#!/bin/sh

if [ -f ./download-complete ]; then
	echo "wordpress already downloaded"
else
	echo downloading and extracting wordpress for $DOMAIN_NAME
	wget http://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm latest.tar.gz
	mv wordpress/* .
	rm -rf wordpress
	touch download-complete

	# this should never actually replace anything as the premade wp-config.php is filled in
	# but just in case moving latest's contents ever overwrites that file I'll leave this here
	# s/STUFF/NEWSTUFF/g replace all occurences of STUFF with NEWSTUFF
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
	sed -i "s/localhost/$DOMAIN_NAME/g" wp-config.php
fi

if [ -f /usr/local/bin/wp-cli ]; then
	echo "wp-cli already installed"
else
	echo installing wp-cli
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp-cli
fi

# adding the admin user
if [ -f ./admin-created ]; then
	echo "admin user already created"
else
	echo creating admin user
	wp-cli user create ${ADMIN_NAME} ${ADMIN_EMAIL} --role=administrator --user_pass=${ADMIN_PASSWORD}
	touch admin-created
fi

# adding the regular user
if [ -f ./user-created ]; then
	echo "user already created"
else
	echo creating regular user
	wp-cli user create ${USER_NAME} ${USER_EMAIL} --role=author --user_pass=${USER_PASSWORD}
	touch user-created
fi

exec "$@"