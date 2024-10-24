FROM alpine:3.19.2


ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG WP_ADM
ARG WP_ADM_PASS
ARG WP_ADM_MAIL
ARG WP_USR
ARG WP_USR_PASS
ARG WP_USR_MAIL
ARG WP_URL
ARG WP_TITLE

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

COPY ./requirements/wordpress/tools/wp-configure.sh /var/www/wp-configure.sh
RUN sh wp-configure.sh && rm wp-configure.sh

WORKDIR /

COPY ./requirements/wordpress/tools/wp-autostart.sh ./wp-autostart.sh
RUN chmod +x ./wp-autostart.sh

ENTRYPOINT ["./wp-autostart.sh"]
