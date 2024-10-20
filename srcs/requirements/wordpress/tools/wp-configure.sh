#!/bin/sh

WP_DIR=/var/www/
chown -R www-data:www-data $WP_DIR
find $WP_DIR -type d -exec chmod 755 {} \;
find $WP_DIR -type f -exec chmod 644 {} \;

curl -O "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp
wp cli update

wget https://wordpress.org/wordpress-6.6.2.zip && \
	unzip wordpress-6.6.2.zip && \
	cp -rf wordpress/* . && \
	rm -rf wordpress wordpress-6.6.2.zip && \
  chmod -R 0777 ./wp-content/

wp core download --allow-root --force
