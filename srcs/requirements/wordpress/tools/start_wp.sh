#!/bin/bash

# Attendre que la base de données soit prête (ping le conteneur mariadb sur son port interne)
echo "En attente de la base de données..."
until nc -z mariadb 3306; do
    sleep 1
done
echo "Base de données accessible."

# Lire le mot de passe admin WP depuis le secret (si utilisé)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

# Configurer wp-config.php si le fichier n'existe pas (première exécution)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Configuration de wp-config.php..."
    mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # Remplacer les placeholders dans wp-config.php avec les variables d'environnement
    sed -i "s/database_name_here/${MYSQL_DATABASE}/g" /var/www/html/wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/g" /var/www/html/wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/g" /var/www/html/wp-config.php
    sed -i "s/localhost/mariadb/g" /var/www/html/wp-config.php # Le nom du service mariadb est le hostname dans le réseau docker

    # Ajouter les clés de sécurité WordPress (générer des clés aléatoires pour plus de sécurité)
    SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
    echo "$SALT" >> /var/www/html/wp-config.php

    # Installer WordPress en utilisant wp-cli
    # Assurez-vous que wp-cli est installé dans le Dockerfile ou le conteneur
    echo "Installation de WordPress..."
    wp core install --url="https://${DOMAIN_NAME}" \
                    --title="${WP_TITLE}" \
                    --admin_user="${WP_ADMIN_USER}" \
                    --admin_password="${WP_ADMIN_PASSWORD}" \
                    --admin_email="${WP_ADMIN_EMAIL}" \
                    --allow-root # Nécessaire si vous exécutez en root dans le conteneur
    echo "WordPress installé."

    # Créer un utilisateur non-admin supplémentaire si nécessaire (le sujet demande deux utilisateurs dont un admin)
    # wp user create utilisateur_lambda votre_email_lambda@example.com --role=author --allow-root
fi

echo "Démarrage de PHP-FPM..."
# Démarrer PHP-FPM en foreground
exec /usr/sbin/php-fpm8.2 -F # Le nom de l'exécutable php-fpm peut varier