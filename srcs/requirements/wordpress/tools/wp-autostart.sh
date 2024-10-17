#!/bin/sh
cd /var/www;
wp core install --url=lporoshi.42.fr/ --title=lporoshi_inception --admin_user=$WP_ADM --admin_password=$WP_ADM_PASS --admin_email=$WP_ADM_MAIL --allow-root;
wp user create $WP_USR $WP_USR_MAIL --role=author --user_pass=$WP_USR_PASS --allow-root;
wp theme install astra --activate --allow-root;
mkdir /run/php;

/usr/sbin/php-fpm82 -F