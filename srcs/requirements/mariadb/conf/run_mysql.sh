#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "CREATING THE FOLDER FOR MYSQL" 1>&2
    mkdir -p /var/lib/mysql/
    mkdir -p /var/lib/mysql/mysql/
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        exit 1 
    fi
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
    rm -f /tmp/create_db.sql
fi

/usr/bin/mysqld_safe --skip-log-error
