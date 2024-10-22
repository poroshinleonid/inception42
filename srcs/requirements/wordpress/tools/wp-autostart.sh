#!/bin/sh
cd /var/www;

if [ -f "wordpress.php" ]; then
    echo "wordpress.php exists, proceeding..."
else
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
fi

if wp core is-installed --path="$PWD"; then
    echo "WordPress is already installed."
else
    wp core install --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADM \
        --admin_password=$WP_ADM_PASS \
        --admin_email=$WP_ADM_MAIL \
        --allow-root && \
    wp user create $WP_USR $WP_USR_MAIL \
    --role=subscriber --user_pass=$WP_USR_PASS;
    wp theme install astra --activate --allow-root;
    wp menu create "Main Menu"
    wp menu item add-custom "Main Menu" "Login" "/wp-login.php"
    wp menu location list
    wp menu location assign "Main Menu" primary
fi




mkdir /run/php;
WP_DIR=/var/www/
find $WP_DIR -type d -exec chmod 755 {} \;
find $WP_DIR -type f -exec chmod 644 {} \;


/usr/sbin/php-fpm82 -F
