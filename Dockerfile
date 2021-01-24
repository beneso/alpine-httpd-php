FROM alpine
MAINTAINER Ondrej Adam Benes <obenes0@centrum.cz>

# https://wiki.alpinelinux.org/wiki/Setting_Up_Apache_with_PHP
RUN cat > /etc/apk/repositories << EOF
http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main
http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community
EOF ; \
  apk update ; \
	export phpverx=$(alpinever=$(cat /etc/alpine-release|cut -d '.' -f1);[ $alpinever -ge 9 ] && echo  7|| echo 5) 
RUN apk add --no-cache apache2 php${phpverx}-apache2 composer 

ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
