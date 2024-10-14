NAME = inception

all: up

up:
	@printf "Starting ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building ${NAME}...\n"
	@docker-compose -f./docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping ${NAME}...\n"
	@docker-compose -f ./docker-compose.yml --env-file srcs/.env down

re: fclean all

clean: down
	@printf "Cleaning ${NAME}...\n"
	@docker system prune --a

fclean:
	@printf "Fcleaning ${NAME}...\n"
	@docker stop $$(docker ps -qa) || true
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	rm -rf /home/${USER}/data/*

.PHONY	: all build down re clean fclean

#.env variables: DB_NAME DB_USER DB_PASS DB_ROOT
