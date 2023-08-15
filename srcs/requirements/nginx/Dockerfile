FROM alpine:3.17

RUN apk update && \
	apk add openrc nginx openssl

ARG wrkdir=/tmp/

WORKDIR ${wrkdir}

COPY conf/ ${wrkdir}

RUN mkdir -p /etc/nginx/ssl/ \
	&& openssl req -newkey rsa:4096 -x509 -sha512 -days 365 -nodes \
	-out /etc/nginx/ssl/certificate.pem \
	-keyout /etc/nginx/ssl/privatekey.pem \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=localhost" \
	&& chmod -R 770 /etc/nginx/ssl/

RUN mv -f nginx.conf /etc/nginx/http.d/nginx.conf

EXPOSE 443

RUN chmod -R 777 $(wrkdir)

CMD ["nginx", "-g", "daemon off;"]
