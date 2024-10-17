NAME = inception

all: up

vol:
	-@docker volume rm db-volume
	-@docker volume rm wp-volume

up:
	@printf "Starting ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building ${NAME}...\n"
	@mkdir -p /home/${USER}/data/
	@mkdir -p /home/${USER}/data/wordpress/
	@mkdir -p /home/${USER}/data/mariadb/
	@docker-compose --progress=plain -f ./srcs/docker-compose.yml --env-file srcs/.env build  --no-cache

down:
	@printf "Stopping ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml down

re: fclean all

clean: down
	@printf "Cleaning ${NAME}...\n"
	@docker system prune --a

fclean:
	@printf "Fcleaning ${NAME}...\n"
	-@docker stop $$(docker ps -qa) || true
	-@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	-@docker volume rm db-volume
	-@docker volume rm wp-volume
	-@rm -rf /home/${USER}/data/*
	-@rmdir /home/${USER}/data/

dir:
	@mkdir -p /home/${USER}/data

.PHONY	: all build down re clean fclean


# secrets:
#   db_name:
#     file: ./secrets/db_name.txt
#   db_user:
#     file: ./secrets/db_user.txt
#   db_pass:
#     file: ./secrets/db_pass.txt
#   db_root_pass:
#     file: ./secrets/db_root_pass.txt
#   wp_adm:
#     file: ./secrets/wp_adm.txt
#   wp_adm_pass:
#     file: ./secrets/wp_adm_pass.txt
#   wp_adm_mail:
#     file: ./secrets/wp_adm_pass.txt
#   wp_usr:
#     file: ./secrets/wp_usr.txt
#   wp_usr_pass:
#     file: ./secrets/wp_usr_pass.txt
#   wp_usr_mail:
#     file: ./secrets/wp_usr_pass.txt
#   wp_url:
#     file: ./secrets/wp_url.txt
#   wp_title:
#     file: ./secrets/wp_title.txt
