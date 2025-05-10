#!/bin/bash

# Attendre que le conteneur WordPress soit accessible (pour s'assurer que PHP-FPM écoute)
echo "En attente du conteneur WordPress..."
until nc -z wordpress 9000; do
    sleep 1
done
echo "Conteneur WordPress accessible sur le port 9000."


# Lire le nom de domaine depuis la variable d'environnement
DOMAIN_NAME="${DOMAIN_NAME}"

# Générer le certificat SSL auto-signé si les fichiers n'existent pas
if [ ! -f /etc/nginx/ssl/inception.crt ] || [ ! -f /etc/nginx/ssl/inception.key ]; then
    echo "Génération des certificats SSL auto-signés..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=Inception/CN=${DOMAIN_NAME}"
    echo "Certificats SSL générés."
fi

echo "Démarrage de Nginx..."
# Démarrer Nginx en foreground
exec nginx -g "daemon off;"