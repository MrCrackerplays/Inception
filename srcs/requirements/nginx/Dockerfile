FROM alpine:3.15

RUN apk update && \
	apk add openrc nginx openssl

WORKDIR /tmp/

COPY conf/ ${WORKDIR}

RUN mkdir -p /etc/nginx/ssl/ \
	&& openssl req -newkey rsa:4096 -x509 -sha512 -days 365 -nodes \
	-out /etc/nginx/ssl/certificate.pem \
	-keyout /etc/nginx/ssl/privatekey.pem \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=localhost"

RUN mkdir /etc/nginx/sites-enabled && \
	mkdir /etc/nginx/sites-available && \
	mv nginx.conf /etc/nginx/sites-available/nginx.conf && \
	ln -fs /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
