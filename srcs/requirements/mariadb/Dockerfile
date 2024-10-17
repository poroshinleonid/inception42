FROM alpine:3.19

ENV DB_NAME_FILE=/run/secrets/db_name
ENV DB_USER_FILE=/run/secrets/db_user
ENV DB_PASS_FILE=/run/secrets/db_pass
ENV DB_ROOT_PASS_FILE=/run/secrets/db_root_pass

RUN DB_NAME=$(cat $DB_NAME_FILE) && \
    DB_USER=$(cat $DB_USER_FILE) && \
    DB_PASS=$(cat $DB_PASS_FILE) && \
    DB_ROOT_PASS=$(cat $DB_ROOT_PASS_FILE)

RUN apk update && apk add --no-cache mariadb mariadb-client



RUN mkdir -p /var/run/mysqld; \
    mkdir -p /etc/my.cnf.d/; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'datadir = /var/lib/mysql'; \
      echo 'socket  = /run/mysqld/mysqld.sock'; \
      echo 'skip-host-cache'; \
      echo 'bind-address=*'; \
      echo 'port = 3306'; \
      echo 'user=mysql'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf;


RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

# COPY ./requirements/mariadb/conf/create_db.sh .
# RUN "/bin/sh" "create_db.sh" && rm "create_db.sh"
# USER mysql
# ENTRYPOINT ["/usr/bin/mysqld_safe", "--skip-log-error"]

COPY ./requirements/mariadb/conf/create_db.sh ./create_db.sh
RUN chmod +x ./create_db.sh


ENTRYPOINT ["./create_db.sh"]