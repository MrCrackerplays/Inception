FROM alpine:3.17

RUN apk update && apk upgrade && \
	apk add openrc nginx openssl

COPY conf/nginx.conf /etc/nginx/http.d/nginx.conf

RUN mkdir -p /etc/nginx/ssl/ \
	&& openssl req -newkey rsa:4096 -x509 -sha512 -days 365 -nodes \
	-out /etc/nginx/ssl/certificate.pem \
	-keyout /etc/nginx/ssl/privatekey.pem \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=pdruart.42.fr" \
	&& chmod -R 770 /etc/nginx/ssl/

RUN rc-update add nginx default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
