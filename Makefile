HAS_HOSTS := $(shell grep -c "pdruart.42.fr" /etc/hosts)

all: down up

up: setup
	sudo docker compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate

down: setup
	sudo docker compose -f srcs/docker-compose.yml down

docker-setup:
	sh srcs/requirements/nginx/tools/dockersetup.sh
	touch docker-setup

setup: docker-setup
ifeq ($(HAS_HOSTS),)
	sudo sh -c 'sudo echo "127.0.0.1 pdruart.42.fr" >> /etc/hosts'
endif
	sudo mkdir -p /home/patrick/data/mariadb
	sudo mkdir -p /home/patrick/data/wordpress
	touch setup

clean: down
	rm -f setup docker-setup

push:
	git push origin master
	git push github master:main

.PHONY: all up down push clean
