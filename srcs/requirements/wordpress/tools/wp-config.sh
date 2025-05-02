#!/bin/bash

sleep 10;

# Using environment variables defined in .env (WP_ADMIN_PASSWORD, WP_USER_PASSWORD, MYSQL_PASSWORD)
# If you need to verify they are set, you can add checks here:
: "${WP_ADMIN_PASSWORD:?WP_ADMIN_PASSWORD is not set}"
: "${WP_USER_PASSWORD:?WP_USER_PASSWORD is not set}"
: "${MYSQL_PASSWORD:?MYSQL_PASSWORD is not set}"

# Navigate to the WordPress directory
cd /home/fvastena/Desktop/inceptiontest/var/www/wordpress

# Create wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
    # Generate wp-config.php using environment variables and secrets
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb:3306 \
        --allow-root

    # Install WordPress
    wp core install \
        --url=${DOMAIN_NAME} \
        --title="My Inception Website" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email="admin@${DOMAIN_NAME}" \
        --skip-email \
        --allow-root

    # Create a second user
    wp user create ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWORD} --allow-root
fi

# Execute the command passed to the script (php-fpm)
exec "$@"

