# ~/inception/srcs/requirements/mariadb/tools/init_db.sh
#!/bin/bash

# Start MariaDB temporarily
mysqld_safe --datadir=/var/lib/mysql &


# Attendre que MariaDB soit opérationnel
until mysqladmin ping -h localhost --silent; do
    echo 'En attente de MariaDB...'
    sleep 1
done

echo 'MariaDB démarré. Initialisation...'

# Lire les mots de passe depuis les secrets
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# Exécuter les commandes SQL d'initialisation
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo 'Initialisation de la base de données terminée.'

# Arrêter MariaDB
mysqladmin shutdown

# Redémarrer MariaDB en foreground pour que le conteneur reste actif
echo 'Redémarrage de MariaDB...'
exec mysqld --datadir=/var/lib/mysql