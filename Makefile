all: up

up: build
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

clear:
	docker system prune

build:
	docker compose -f ./srcs/docker-compose.yml build

build/re:
	docker compose -f ./srcs/docker-compose.yml build --no-cache

