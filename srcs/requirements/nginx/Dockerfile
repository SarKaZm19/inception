# srcs/requirements/nginx/Dockerfile

# Utiliser une version stable de Debian ou Alpine
FROM debian:bookworm

# Installer Nginx, OpenSSL (pour générer les certificats) et netcat (pour attendre WordPress)
RUN apt-get update && apt-get install -y nginx openssl netcat \
    && rm -rf /var/lib/apt/lists/*

# Copier la configuration Nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf # Ou dans sites-available/ et créer un lien symbolique

# Créer le répertoire pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Copier le script de génération de certificats et de démarrage
COPY ./tools/start_nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_nginx.sh

# Exposer le port Nginx (celui mappé à l'hôte)
EXPOSE 443

# Définir le point d'entrée
CMD ["/usr/local/bin/start_nginx.sh"]