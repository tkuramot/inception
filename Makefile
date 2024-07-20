WORDPRESS_DIR = ~/data/wordpress
MARIA_DB_DIR = ~/data/mariadb
NODE_DIR = ~/data/node
CERT_DIR = ./srcs/requirements/nginx/ssl
CERT_FILE_KEY = $(CERT_DIR)/$(DOMAIN).key
CERT_FILE_CSR = $(CERT_DIR)/$(DOMAIN).csr
CERT_FILE_CRT = $(CERT_DIR)/$(DOMAIN).crt
DOMAIN =
DOMAIN_BLOG =
DOMAIN_GALLERY =

include ./srcs/.env

all: build up

up:
	if [ ! -d $(WORDPRESS_DIR) ]; then mkdir -p $(WORDPRESS_DIR); fi
	if [ ! -d $(MARIA_DB_DIR) ]; then mkdir -p $(MARIA_DB_DIR); fi
	if [ ! -d $(NODE_DIR) ]; then mkdir -p $(NODE_DIR); fi
	docker compose -f ./srcs/docker-compose.yml up -d

cert:
	if [ ! -d $(CERT_DIR) ]; then mkdir -p $(CERT_DIR); fi
	openssl genrsa 2048 > $(CERT_FILE_KEY)
	openssl req -new -key $(CERT_FILE_KEY) -out $(CERT_FILE_CSR) -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=42Cursus/CN=$(DOMAIN)"
	openssl x509 -days 3650 -req -signkey $(CERT_FILE_KEY) -in $(CERT_FILE_CSR) -out $(CERT_FILE_CRT)

build:
	make cert DOMAIN=$(DOMAIN_BLOG)
	make cert DOMAIN=$(DOMAIN_GALLERY)
	docker compose -f ./srcs/docker-compose.yml build $(if $(RE), --no-cache,)

stop:
	docker compose -f ./srcs/docker-compose.yml stop

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	$(RM) -r $(WORDPRESS_DIR) $(MARIA_DB_DIR) $(CERT_DIR)/*
	docker rm -f `docker ps -a -q` || true
	docker image prune -af
	docker volume rm $(shell docker volume ls -q) || true
	docker network prune -f
	docker system prune -af

re: clean up

open:
	open https://$(DOMAIN_GALLERY)
	open https://$(DOMAIN_BLOG)

wordpress:
	docker exec -it wordpress sh

nginx:
	docker exec -it nginx sh

mariadb:
	docker exec -it mariadb sh

adminer:
	docker exec -it adminer sh

node:
	docker exec -it node sh
