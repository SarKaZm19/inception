# ~/inception/srcs/requirements/mariadb/tools/init_db.sh
#!/bin/bash

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping -h localhost --silent; do
    echo 'En attente de MariaDB...'
    sleep 1
done

echo 'MariaDB démarré. Initialisation...'

mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo 'Initialisation de la base de données terminée.'

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo 'Redémarrage de MariaDB...'
exec mysqld --datadir=/var/lib/mysql