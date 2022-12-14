
all: down up

up: setup
	sudo docker compose -f srcs/docker-compose.yml up --build -d

down: setup
	sudo docker compose -f srcs/docker-compose.yml down

docker-setup:
	sh srcs/requirements/nginx/tools/dockersetup.sh
	touch docker-setup

setup: docker-setup
	touch setup

clean: down
	rm -f setup docker-setup

push:
	git push origin master
	git push github master:main

.PHONY: all up down push clean
