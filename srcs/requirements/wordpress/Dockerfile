FROM alpine:3.19

ENV DB_NAME_FILE=/run/secrets/db_name
ENV DB_USER_FILE=/run/secrets/db_user
ENV DB_PASS_FILE=/run/secrets/db_pass
ENV WP_ADM_FILE=/run/secrets/wp_adm
ENV WP_ADM_PASS_FILE=/run/secrets/wp_adm_pass
ENV WP_ADM_MAIL_FILE=/run/secrets/wp_adm_mail
ENV WP_USR_FILE=/run/secrets/wp_usr
ENV WP_USR_PASS_FILE=/run/secrets/wp_usr_pass
ENV WP_USR_MAIL_FILE=/run/secrets/wp_usr_mail

RUN DB_NAME=$(cat $DB_NAME_FILE) && \
	DB_USER=$(cat $DB_USER_FILE) && \
	DB_PASS=$(cat $DB_PASS_FILE) && \
	WP_ADM=$(cat $WP_ADM_FILE) && \
	WP_ADM_PASS=$(cat $WP_ADM_PASS_FILE) && \
	WP_ADM_MAIL=$(cat $WP_ADM_MAIL_FILE) && \
	WP_USR=$(cat $WP_USR_FILE) && \
	WP_USR_PASS=$(cat $WP_USR_PASS_FILE) && \
	WP_USR_MAIL=$(cat $WP_USR_MAIL_FILE)

RUN if [ ! -d "/home/${USER}/data" ]; then \
        mkdir ~/data; \
        mkdir ~/data/mariadb; \
        mkdir ~/data/wordpress; fi

RUN apk update && apk upgrade && apk add --no-cache \
	php \
	php-fpm \
	php-mysqli\
	php-json \
	php-curl \
  php-phar \
	php-dom \
  php-session \
  php-iconv \
  php-exif \
	php-fileinfo \
	php-mbstring \
	php-openssl \
	php-xml \
	php-zip \
	php-redis \
	wget \
  	curl \
	mysql-client \
	unzip && \
	sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
	/etc/php82/php-fpm.d/www.conf && \
	sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
	/etc/php82/php-fpm.d/www.conf && \
	sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
	/etc/php82/php-fpm.d/www.conf && \
	rm -f /var/cache/apk/*
WORKDIR /var/www

RUN wget https://wordpress.org/wordpress-6.6.2.zip && \
	unzip wordpress-6.6.2.zip && \
	cp -rf wordpress/* . && \
	rm -rf wordpress wordpress-6.6.2.zip && \
  chmod -R 0777 ./wp-content/

# COPY ./requirements/wordpress/conf/wp-config.php /var/www/wp-config.php

COPY ./requirements/wordpress/tools/wp-configure.sh /var/www/wp-configure.sh
RUN sh wp-configure.sh && rm wp-configure.sh

# COPY ./requirements/wordpress/conf/wp-config-create.sh .
# RUN sh wp-config-create.sh && rm wp-config-create.sh && \
# 	chmod -R 0777 ./wp-content/
# RUN ls -l /usr/sbin/

ENTRYPOINT ["/usr/sbin/php-fpm82", "-F"]
