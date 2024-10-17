#!/bin/sh
# cat << EOF > /var/www/wp-config.php
# <?php
# define( 'DB_NAME', '${DB_NAME}' );
# define( 'DB_USER', '${DB_USER}' );
# define( 'DB_PASSWORD', '${DB_PASS}' );
# define( 'DB_HOST', 'mariadb' );
# define( 'DB_CHARSET', 'utf8' );
# define( 'DB_COLLATE', '' );
# define( 'FS_METHOD','direct' );
# \$table_prefix = 'wp_';
# define( 'WP_DEBUG', false );
# if ( ! defined( 'ABSPATH' ) ) {
# define( 'ABSPATH', __DIR__ . '/' );}
# require_once ABSPATH . 'wp-settings.php';
# EOF

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



# mv /var/www/wp-config-sample.php /var/www/wp-config.php
# sed -i -r "s/database/$DB_NAME/1"   wp-config.php
# sed -i -r "s/database_user/$DB_USER/1"  wp-config.php
# sed -i -r "s/passwod/$DB_PASS/1"    wp-config.php
# sed -i -r "s/localhost/mariadb/1"    wp-config.php





#!/bin/sh

# Variables
# WP_DIR=/var/www
# DB_NAME="${DB_NAME}"     # Database name from the environment variable
# DB_USER="${DB_USER}"     # Database user from the environment variable
# DB_PASS="${DB_PASS}"     # Database password from the environment variable
# DB_HOST="mariadb"        # Hostname of the database server


# # Step 4: Create wp-config.php
# echo "Creating wp-config.php..."
# cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php

# # Step 5: Update wp-config.php with database details
# echo "Updating wp-config.php..."
# sed -i "s/database_name_here/${DB_NAME}/" $WP_DIR/wp-config.php
# sed -i "s/username_here/${DB_USER}/" $WP_DIR/wp-config.php
# sed -i "s/password_here/${DB_PASS}/" $WP_DIR/wp-config.php
# sed -i "s/localhost/${DB_HOST}/" $WP_DIR/wp-config.php

# # Step 6: Set Permissions
# echo "Setting permissions..."
# chown -R www-data:www-data $WP_DIR
# find $WP_DIR -type d -exec chmod 755 {} \;
# find $WP_DIR -type f -exec chmod 644 {} \;

# echo "WordPress installation completed!"


# # The commands are for installing and using the WP-CLI tool.

# # downloads the WP-CLI PHAR (PHP Archive) file from the GitHub repository. The -O flag tells curl to save the file with the same name as it has on the server.
# curl -O "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"

# # makes the WP-CLI PHAR file executable.
# chmod +x wp-cli.phar 

# # moves the WP-CLI PHAR file to the /usr/local/bin directory, which is in the system's PATH, and renames it to wp. This allows you to run the wp command from any directory
# mv wp-cli.phar /usr/local/bin/wp

# wp cli update
# # downloads the latest version of WordPress to the current directory. The --allow-root flag allows the command to be run as the root user, which is necessary if you are logged in as the root user or if you are using WP-CLI with a system-level installation of WordPress.
# wp core download --allow-root

# mv /var/www/wp-config-sample.php /var/www/wp-config.php

# # change the those lines in wp-config.php file to connect with database

# #line 23
# sed -i -r "s/database/$DB_NAME/1"   wp-config.php
# #line 26
# sed -i -r "s/database_user/$DB_USER/1"  wp-config.php
# #line 29
# sed -i -r "s/passwod/$DB_PASS/1"    wp-config.php

# #line 32
# sed -i -r "s/localhost/mariadb/1"    wp-config.php

# # installs WordPress and sets up the basic configuration for the site. The --url option specifies the URL of the site, --title sets the site's title, --admin_user and --admin_password set the username and password for the site's administrator account, and --admin_email sets the email address for the administrator. The --skip-email flag prevents WP-CLI from sending an email to the administrator with the login details.
# wp core install --url=lporoshi.42.fr/ --title=$lporoshi_inception --admin_user=$WP_ADM --admin_password=$WP_ROOT_PASS --skip-email --allow-root

# # creates a new user account with the specified username, email address, and password. The --role option sets the user's role to author, which gives the user the ability to publish and manage their own posts.
# wp user create $WP_USR $ --skip-email --role=author --user_pass=$WP_USR_PASS --allow-root

# # installs the Astra theme and activates it for the site. The --activate flag tells WP-CLI to make the theme the active theme for the site.
# wp theme install astra --activate --allow-root

# # creates the /run/php directory, which is used by PHP-FPM to store Unix domain sockets.
# mkdir /run/php
