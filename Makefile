NAME = inception

all: up

up: build
	@printf "Starting ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building ${NAME}...\n"
	@mkdir -p /home/${USER}/data/
	@mkdir -p /home/${USER}/data/wordpress/
	@mkdir -p /home/${USER}/data/mariadb/
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml down

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
	@rm -rf /home/${USER}/data/*
	@rmdir /home/${USER}/data/

dir:
	@mkdir -p /home/${USER}/data

.PHONY	: all build down re clean fclean

#.env variables: DB_NAME DB_USER DB_PASS DB_ROOT
#RUN sed -i "s|bind-address = 127.0.0.1|bind-address = 0.0.0.0|g" \
	/etc/mysql/mariadb.conf.d/50-server.cnf
