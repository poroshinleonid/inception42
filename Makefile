name = simple_hginx_html

all: up

up:
	@printf "Starting configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d

build:
	@printf "Building ${name}...\n"
	@docker-compose -f./docker-compose.yml up -d --build

down:
	@printf "Stopping ${name}...\n"
	@docker-compose -f ./docker-compose.yml down

re:
	@printf "Rebuilding and running ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d --build
clean:
	@printf "Cleaning ${name}...\n"
	@docker system prune --a

fclean:
	@printf "Fcleaning ${name}...\n"
	@docker stop $$(docker ps -qa) || true
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	rm -rf /home/${USER}/data/*
user:
	@echo ${USER}
