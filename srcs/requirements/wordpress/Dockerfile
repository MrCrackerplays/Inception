FROM alpine:3.17

RUN apk update && \
	apk add php php-fpm php-mysqli

WORKDIR /var/www/html/

#copy the sh script into the container and execute it
COPY tools/wordpress_stuff.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress_stuff.sh
ENTRYPOINT ["/usr/local/bin/wordpress_stuff.sh"]

EXPOSE 9000

# this is passed as an argument to the wordpress_stuff script, which at the bottom has exec "$@" which will run this command
CMD ["php-fpm81", "-F"]
