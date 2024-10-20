NAME = inception

all: build up

$(NAME): all

up:
	@printf "Starting ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building ${NAME}...\n"
	@mkdir -p /home/${USER}/data/
	@mkdir -p /home/${USER}/data/wordpress/
	@mkdir -p /home/${USER}/data/mariadb/
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env --progress=plain build --no-cache

down:
	@printf "Stopping ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml down

re: fclean all

clean: down
	@printf "Cleaning ${NAME}...\n"
	@docker system prune --all

fclean: clean
	@printf "Fcleaning ${NAME}...\n"
	-@docker stop $$(docker ps -qa) || true
	-@docker system prune --all --force --volumes
	-@docker network prune --force
	-@docker volume prune --force
	-@docker volume rm db-volume
	-@docker volume rm wp-volume
	-@sudo rm -rf /home/${USER}/data/
dir:
	@mkdir -p /home/${USER}/data

.PHONY	: all build down re clean fclean