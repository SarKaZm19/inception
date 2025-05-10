FROM debian:bullseye
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y curl php php-fpm php-mysql mariadb-client && \
	curl -sS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp &&\
	mkdir -p run/php
COPY ./conf/www.conf /etc/php/7.2/fpm/pool.d/
# WORKDIR /var/www/wordpress
COPY ./tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]