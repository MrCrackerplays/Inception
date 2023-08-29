FROM alpine:3.17

RUN apk update && apk upgrade && \
	apk add openrc mariadb mariadb-client mariadb-common mariadb-server-utils

EXPOSE 3306

#remove the default configuration files
RUN rm -f /etc/mysql/my.cnf /etc/my.cnf ~/my.cnf

#copy the configuration file into the container at multiple locations to be sure
#COPY conf/my.cnf /etc/mysql/my.cnf
COPY conf/my.cnf /etc/my.cnf
#COPY conf/my.cnf ~/my.cnf

#create the directory for the database and give the right permissions
RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod 777 /var/lib/mysql

#copy the sh script into the container and execute it
COPY tools/mariadb_stuff.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_stuff.sh
ENTRYPOINT ["/usr/local/bin/mariadb_stuff.sh"]

#/usr/bin/mariadbd-safe --user=root --datadir=/var/lib/mysql
CMD ["/usr/bin/mariadbd-safe", "--user=root", "--datadir=/var/lib/mysql"]
#CMD ["tail", "-f", "/dev/null"]
