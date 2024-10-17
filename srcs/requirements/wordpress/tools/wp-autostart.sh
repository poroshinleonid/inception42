#!/bin/sh
cd /var/www;

# rm -f /var/www/wp-config.php

# wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --dbcharset='utf8' --dbcollate='' --extra-php <<PHP
# define( 'WP_DEBUG', false);
# if ( ~ defined( 'ABSPATH' ) ) {
# define ( 'ABSPATH', __DIR__ . '/' );}
# require_once ABSPATH . 'wp-settings.php'
# PHP
echo "GENERATING CONFIG..."
cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'FS_METHOD','direct' );
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
require_once ABSPATH . 'wp-settings.php';
EOF


echo "INSTALLING WORDPRESS"
wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADM --admin_password=$WP_ADM_PASS --admin_email=$WP_ADM_MAIL --allow-root;

echo "CREATING WORDPRESS USER"
wp user create $WP_USR $WP_USR_MAIL --role=author --user_pass=$WP_USR_PASS --allow-root;


# echo "INSTALLING WP THEME"
# wp theme install generatepress --activate --allow-root;
mkdir /run/php;

WP_DIR=/var/www/
chown -R www-data:www-data $WP_DIR
find $WP_DIR -type d -exec chmod 755 {} \;
find $WP_DIR -type f -exec chmod 644 {} \;


/usr/sbin/php-fpm82 -F
