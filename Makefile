WORDPRESS_DIR = ~/data/wordpress
MARIA_DB_DIR = ~/data/mariadb

all: up

up: build
	@docker compose -f ./srcs/docker-compose.yml up -d

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean: down
	@$(RM) -r $(WORDPRESS_DIR)/* $(MARIA_DB_DIR)/*
	@docker image rmi $(shell docker image ls -q) 2> /dev/null || true
	@docker container rm $(shell docker container ls -aq) 2> /dev/null || true

re: clean up

mkdir:
	@if [ ! -d $(WORDPRESS_DIR) ]; then mkdir -p $(WORDPRESS_DIR); fi
	@if [ ! -d $(MARIA_DB_DIR) ]; then mkdir -p $(MARIA_DB_DIR); fi

build: mkdir
	@docker compose -f ./srcs/docker-compose.yml build $(if $(RE), --no-cache)

wordpress:
	@docker exec -it wordpress shell

nginx:
	@docker exec -it nginx sh

maria_db:
	@docker exec -it mariadb sh

adminer:
	@docker exec -it adminer sh

node:
	@docker exec -it node sh
