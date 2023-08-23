
all: down up

up: setup
	sudo docker compose -f srcs/docker-compose.yml up --build -d --remove-orphans --force-recreate

down: setup
	sudo docker compose -f srcs/docker-compose.yml down

docker-setup:
	sh srcs/requirements/nginx/tools/dockersetup.sh
	touch docker-setup

setup: docker-setup
	$(if $(shell grep "pdruart.42.fr" /etc/hosts),echo "already in hosts",sudo sh -c 'sudo echo "127.0.0.1 pdruart.42.fr" >> /etc/hosts')
	sudo mkdir -p /home/pdruart/data/mariadb
	sudo mkdir -p /home/pdruart/data/wordpress
	touch setup

clean: down
	rm -f setup docker-setup

fclean: clean
	sudo docker volume rm srcs_db-volume
	sudo docker volume rm srcs_wp-volume
	sudo rm -rf /home/pdruart/data/mariadb
	sudo rm -rf /home/pdruart/data/wordpress

re: fclean up

push:
	git push origin master
	git push github master:main

.PHONY: all up down push clean fclean re
