# ~/inception/srcs/requirements/wordpress/tools/wp-config.sh
#!/bin/bash

# Read passwords from secrets files
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_PASSWORD=$(cat /run/secrets/wp_password)
MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)

# Wait for MariaDB to be ready
echo "Waiting for MariaDB..."
while ! nc -z mariadb 3306; do
  sleep 1
done
echo "MariaDB is ready."

# Navigate to the WordPress directory
cd /var/www/wordpress

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

