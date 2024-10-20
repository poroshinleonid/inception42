FROM alpine:3.19.2

COPY ./requirements/nginx/conf/nginx.conf .

RUN apk update && \
	apk upgrade && \
	apk add --no-cache nginx && \
	apk add --no-cache openssl && \
	mkdir -p /etc/nginx/ssl/ && \
	mkdir -p /var/run/nginx && \
	mkdir -p /etc/nginx/http.d/ && \
  mkdir -p /var/www/html && \
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key -subj \
	"/C=DE/ST=BW/L=Heilbronn/O=42/OU=42/CN=lporoshi.42.fr/UID=lporoshi" && \
  chmod 755 /var/www/html

COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf


EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
