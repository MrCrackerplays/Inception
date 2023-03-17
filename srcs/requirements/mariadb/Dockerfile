FROM alpine:3.16

RUN apk update && \
	apk add mariadb mariadb-client

WORKDIR /tmp/mariadb/

# COPY conf/ ${WORKDIR}

#set up the database using RUN mariadb -u root and redirecting a file's contents into it

EXPOSE 3306

CMD mysqld
