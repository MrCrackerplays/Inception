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

	rm -rf wp-config.php
	cp /usr/local/bin/wp-config.php .
	# this should never actually replace anything as the premade wp-config.php is filled in
	# but just in case moving latest's contents ever overwrites that file I'll leave this here
	# s/STUFF/NEWSTUFF/g replace all occurences of STUFF with NEWSTUFF
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
	sed -i "s/localhost/$DOMAIN_NAME/g" wp-config.php
fi


# # installing wordpress via the cli instead of wget as I couldn't figure out how to set up the title n stuff otherwise
# if [ -f ./wp-config.php ]; then
# 	echo "wordpress already installed"
# else
# 	echo installing wordpress
# 	wp core download --allow-root --path="/var/www/html"
# 	# rm -rf wp-config.php
# 	# cp /usr/local/bin/wp-config.php .
# 	wp db create --allow-root
# 	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
# 	wp core install --allow-root --path="/var/www/html" --url=${DOMAIN_NAME} --title="the magic palace of pdruart" --admin_user=${ADMIN_NAME} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL}
# 	# regular user
# 	wp user create ${USER_NAME} ${USER_EMAIL} --role=editor --user_pass=${USER_PASSWORD} --allow-root
# 	#permissions
# 	chmod 600 wp-config.php
# fi

exec "$@"
