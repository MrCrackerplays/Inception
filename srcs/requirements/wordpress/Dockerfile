FROM alpine:3.17

RUN apk update && apk upgrade && \
	apk add openrc php php-fpm php-mysqli php-phar curl mysql mysql-client php-iconv

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php

WORKDIR /var/www/html/

RUN rm -f /etc/php81/php-fpm.d/www.conf
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

#82 seems to just be required for www-data for php-fpm? if I understand it correctly
RUN adduser -u 82 -D -S -G www-data www-data
RUN chmod 777 -R /var/www/html
RUN chown -R www-data:www-data /var/www/html

#copy the sh script into the container and execute it
COPY tools/wordpress_stuff.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress_stuff.sh
ENTRYPOINT ["/usr/local/bin/wordpress_stuff.sh"]

EXPOSE 9000

# this is passed as an argument to the wordpress_stuff script, which at the bottom has exec "$@" which will run this command
CMD ["php-fpm81", "-F"]
