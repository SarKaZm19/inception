# ~/inception/srcs/requirements/mariadb/Dockerfile
ARG DEBIAN_VERSION=bullseye # Or alpine version
FROM debian:${DEBIAN_VERSION}

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install MariaDB server and client
RUN apt-get update && apt-get install -y mariadb-server mariadb-client && rm -rf /home/fvastena/Desktop/inceptiontest/var/lib/apt/lists/*

# Copy initialization script
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

# Expose the default MariaDB port
EXPOSE 3306

# Command to run MariaDB server
CMD ["mysqld"]
