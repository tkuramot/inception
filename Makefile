WORDPRESS_DIR = ~/data/wordpress
MARIA_DB_DIR = ~/data/mariadb
CERT_DIR = ./srcs/requirements/nginx/ssl
CERT_FILE_KEY = $(CERT_DIR)/private.key
CERT_FILE_CSR = $(CERT_DIR)/server.csr
CERT_FILE_CRT = $(CERT_DIR)/server.crt
DOMAIN_NAME =

include ./srcs/.env

all: up

up: build
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	$(RM) -r $(WORDPRESS_DIR)/* $(MARIA_DB_DIR)/* $(CERT_DIR)/*
	docker image rmi $(shell docker image ls -q) 2> /dev/null || true
	docker container rm $(shell docker container ls -aq) 2> /dev/null || true

re: clean up

cert:
	openssl genrsa 2048 > $(CERT_FILE_KEY)
	openssl req -new -key $(CERT_FILE_KEY) -out $(CERT_FILE_CSR) -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=42Cursus/CN=$(DOMAIN_NAME)"
	openssl x509 -days 3650 -req -signkey $(CERT_FILE_KEY) -in $(CERT_FILE_CSR) -out $(CERT_FILE_CRT)

mkdir:
	if [ ! -d $(WORDPRESS_DIR) ]; then mkdir -p $(WORDPRESS_DIR); fi
	if [ ! -d $(MARIA_DB_DIR) ]; then mkdir -p $(MARIA_DB_DIR); fi

build: mkdir
	docker compose -f ./srcs/docker-compose.yml build $(if $(RE), --no-cache)

wordpress:
	docker exec -it wordpress shell

nginx:
	docker exec -it nginx sh

maria_db:
	docker exec -it mariadb sh

adminer:
	docker exec -it adminer sh

node:
	docker exec -it node sh
