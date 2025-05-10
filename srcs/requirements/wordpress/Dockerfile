# srcs/requirements/wordpress/Dockerfile

# Utiliser une version stable de Debian ou Alpine
FROM debian:bookworm

# Installer les dépendances PHP et autres extensions nécessaires à WordPress
RUN apt-get update && apt-get install -y \
    php-fpm=8.2 \
    php-mysql=8.2 \
    php-cli=8.2 \
    php-curl=8.2 \
    php-gd=8.2 \
    php-intl=8.2 \
    php-mbstring=8.2 \
    php-soap=8.2 \
    php-xml=8.2 \
    php-xmlrpc=8.2 \
    php-zip=8.2 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Télécharger et installer WordPress
WORKDIR /var/www/html/
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mv wordpress/* . \
    && rm -rf wordpress latest.tar.gz

# Copier le fichier de configuration php-fpm (pour s'assurer qu'il écoute correctement)
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/

# Copier le script de démarrage et configuration de WordPress
COPY ./tools/start_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_wp.sh

# Exposer le port de PHP-FPM (interne au réseau Docker)
EXPOSE 9000

# Définir le point d'entrée
CMD ["/usr/local/bin/start_wp.sh"]