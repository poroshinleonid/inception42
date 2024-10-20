FROM alpine:3.19.2

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_PASS

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

COPY ./requirements/mariadb/conf/run_mysql.sh ./run_mysql.sh
RUN chmod +x ./run_mysql.sh
ENTRYPOINT ["./run_mysql.sh"]
