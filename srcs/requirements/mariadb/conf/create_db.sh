#!/bin/sh

# Check if MySQL database directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "CREATING THE FOLDER FOR MYSQL" 1>&2
    mkdir -p /var/lib/mysql/
    mkdir -p /var/lib/mysql/mysql/
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    # Create a temporary file for SQL commands
    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        exit 1  # Use 'exit' instead of 'return' since this is a script
    fi
fi

# Check if the WordPress database directory exists
if [ ! -d "/var/lib/mysql/wordpress" ]; then

    # Create the SQL file to set up the database and user
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