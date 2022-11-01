FROM alpine:3.15

RUN sudo apt-get update && \
	sudo apt-get upgrade -y && \
	sudo apt-get install -y \
	nginx \
	openssl

WORKDIR /tmp/

COPY conf/ ${WORKDIR}

RUN sudo mkdir -p /etc/nginx/ssl/ \
	&& sudo openssl req -newkey rsa:4096 -x509 -sha512 -days 365 -nodes \
	-out /etc/nginx/ssl/certificate.pem \
	-keyout /etc/nginx/ssl/privatekey.pem \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=Codam/CN=localhost"

RUN pwd && ls -la