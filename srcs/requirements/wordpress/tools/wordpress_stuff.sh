#!/bin/sh

sleep 25

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
fi


# # installing wordpress via the cli instead of wget as I couldn't figure out how to set up the title n stuff otherwise
 if [ -f ./wp-config.php ]; then
        echo "wordpress already installed"
 else
        echo installing wordpress
        echo "pre config create"
        wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root --skip-check
        echo "post"
        sleep 1
        echo "pre db create"
        wp db create --allow-root
        echo "post"
        sleep 1
        echo "pre core install"
        wp core install --allow-root --path="/var/www/html" --url=${DOMAIN_NAME} --title="the magic palace of pdruart" --admin_user=${ADMIN_NAME} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL}
        echo "post"
        sleep 1
        # regular user
        echo "pre user install"
        wp user create ${USER_NAME} ${USER_EMAIL} --role=editor --user_pass=${USER_PASSWORD} --allow-root
        echo "post"
        sleep 1
        #permissions
        echo "perms"
        chmod 644 wp-config.php
        echo "post"
fi

exec "$@"