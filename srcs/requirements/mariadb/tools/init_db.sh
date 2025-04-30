# ~/inception/srcs/requirements/mariadb/tools/init_db.sh
#!/bin/bash

# Start MariaDB temporarily
mysqld_safe &
MYSQL_PID=$!

# Wait for MariaDB to start
until mysqladmin ping -h localhost --silent; do
    sleep 1
done

# Execute SQL commands
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Shut down MariaDB
mysqladmin shutdown

# Wait for shutdown
wait $MYSQL_PID

echo "Database initialization complete."

# The main mysqld process will be started by the CMD in the Dockerfile