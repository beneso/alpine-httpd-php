FROM alpine
MAINTAINER Ondrej Adam Benes <obenes0@centrum.cz>

# https://wiki.alpinelinux.org/wiki/Setting_Up_Apache_with_PHP
RUN echo http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main >> /etc/apk/repositories ; \
    echo http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community >> /etc/apk/repositories ; \
  	apk update ; \
		apk add --no-cache apache2 php7-apache2 composer 

EXPOSE 80

ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
