FROM alpine:3.19

ARG DB_NAME \
	DB_USER \
	DB_PAS

RUN apk update && apk upgrade && apk add --no-cache \
	php \
	php-fpm \
	php-mysqli\
	php-json \
	php-curl \
	php-dom \
	php-exif \
	php-fileinfo \
	php-mbstring \
	php-openssl \
	php-xml \
	php-zip \
	php-redis \
	wget \
	unzip

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	cp -rf wordpress/* . && \
	rm -rf wordpress latest.zip && \
	ls -lah

COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
	chmod -R 0777 ./wp-content/
RUN ls -l /usr/sbin/

CMD ["/usr/sbin/php-fpm82", "-F"]
