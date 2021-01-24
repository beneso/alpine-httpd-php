FROM alpine
MAINTAINER Ondrej Adam Benes <obenes0@centrum.cz>

# https://wiki.alpinelinux.org/wiki/Setting_Up_Apache_with_PHP
# Plus some packages required for composer-run installation of Nette PHP framework
RUN echo http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main >> /etc/apk/repositories ; \
    echo http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community >> /etc/apk/repositories ; \
    apk update ; \
    apk add --no-cache apache2 php7-apache2 composer php7-tokenizer php7-session php7-pdo ;\

# For Nette PHP framework to display application without the /www, we need two things:
# 1. Load rewrite_module
# 2. Make sure AllowOverride allows .htaccess *for the DocumentRoot only*
#   ad 2.: in alpine's httpd.conf, the first occurence of AllowOverride is 
#          AllowOverride none (note the small 'n'). This one, though,
#          does not concern the DocumentRoot, but /.
#          The first occurence of AllowOverride None (note the capital 'n')
#          does concern the DocumentRoot, and that is to be modified to
#          AllowOverride All

# https://www.linuxtopia.org/online_books/linux_tool_guides/the_sed_faq/sedfaq4_004.html
    sed -i 's/^#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf ; \
    sed -i -e '1{x;s/^/first/;x;}1,/AllowOverride None/{x;/first/s///;x;s/AllowOverride None/AllowOverride All/;}'  /etc/apache2/httpd.conf

EXPOSE 80

ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
