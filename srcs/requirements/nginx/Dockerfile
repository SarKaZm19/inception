# srcs/requirements/nginx/Dockerfile

# Utiliser une version stable de Debian ou Alpine
FROM debian:bookworm

# Installer Nginx, OpenSSL (pour générer les certificats) et netcat (pour attendre WordPress)
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Copier la configuration Nginx
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

# Créer le répertoire pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/fvastena.key -out /etc/nginx/ssl/fvastena.crt -subj "/CN=fvastena"

# Définir le point d'entrée
CMD ["/usr/local/bin/start_nginx.sh"]