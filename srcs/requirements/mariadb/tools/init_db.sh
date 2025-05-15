#!/bin/bash

# Création des répertoires requis s'ils n'existent pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialisation de la base de données si elle n'existe pas
    echo "Initialisation de la base de données MariaDB..."
    mkdir -p /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "La base de données MariaDB existe déjà."
fi

# Démarrer MySQL en arrière-plan
echo "Démarrage du service MariaDB..."
service mariadb start

# Attendre que MySQL soit prêt
echo "Attente que MariaDB soit prêt..."
until mysqladmin ping -h localhost --silent; do
    sleep 1
done

# Créer la base de données et l'utilisateur uniquement s'ils n'existent pas
echo "Configuration de la base de données..."
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Arrêter MySQL pour pouvoir le relancer en premier plan
echo "Redémarrage de MariaDB en mode premier plan..."
service mariadb stop

# Démarrer MySQL en premier plan
exec mysqld_safe