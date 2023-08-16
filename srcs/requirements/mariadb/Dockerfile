FROM alpine:3.17

RUN apk update && \
	apk add mariadb mariadb-client

EXPOSE 3306

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

#copy the mysql file into the container
COPY conf/wordpress.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sql

#copy the sh script into the container and execute it
COPY tools/mariadb_stuff.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_stuff.sh
ENTRYPOINT ["/usr/local/bin/mariadb_stuff.sh"]

CMD ["tail", "-f", "/dev/null"]
