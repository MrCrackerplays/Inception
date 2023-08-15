#!/bin/sh

if [ -f ./wp-config.php ]; then
	echo "wp-config.php already downloaded"
else
	echo creating new wp-config.php for $DOMAIN_NAME
	wget http://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm latest.tar.gz
	mv wordpress/* .
	rm -rf wordpress

	# s/STUFF/NEWSTUFF/g replace all occurences of STUFF with NEWSTUFF
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
	sed -i "s/localhost/$DOMAIN_NAME/g" wp-config.php
fi

