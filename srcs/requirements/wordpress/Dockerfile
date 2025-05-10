# srcs/requirements/wordpress/Dockerfile

# Utiliser une version stable de Debian ou Alpine
FROM debian:bookworm

# Installer les dépendances PHP et autres extensions nécessaires à WordPress
RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-cli \
    php8.2-curl \
    php8.2-gd \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-soap \
    php8.2-xml \
    php8.2-xmlrpc \
    php8.2-zip \
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