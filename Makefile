all: up

WORDPRESS_DIR = ~/data/wordpress
MARIA_DB_DIR = ~/data/mariadb

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

# services
# wordpress
wp:
	@docker exec -it wordpress bash

wp/build:
	@docker compose -f ./srcs/docker-compose.yml build wordpress $(if $(RE), --no-cache)

wp/up:
	@docker compose -f ./srcs/docker-compose.yml up -d wordpress

wp/log:
	@docker logs wordpress

# mariadb
db:
	@docker exec -it mariadb bash

db/build:
	@docker compose -f ./srcs/docker-compose.yml build mariadb $(if $(RE), --no-cache)

db/up:
	@docker compose -f ./srcs/docker-compose.yml up -d mariadb

db/log:
	@docker logs mariadb

# nginx
ng:
	@docker exec -it nginx bash

ng/build:
	@docker compose -f ./srcs/docker-compose.yml build nginx $(if $(RE), --no-cache)

ng/up:
	@docker compose -f ./srcs/docker-compose.yml up -d nginx

ng/log:
	@docker logs nginx
