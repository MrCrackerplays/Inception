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

exec "$@"