# ~/inception/srcs/requirements/wordpress/Dockerfile
ARG DEBIAN_VERSION=bookworm # Or alpine version
FROM debian:${DEBIAN_VERSION}

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages: php, php-fpm, php-mysql, wget, etc.
RUN apt-get update && \
    apt-get install -y \
    php-fpm \
    php-mysql \
    php-cli \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz -P /tmp/ && \
    tar -xzf /tmp/latest.tar.gz -C /var/www/ && \
    rm /tmp/latest.tar.gz

# Copy WordPress configuration script
COPY ./tools/wp-config.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/wp-config.sh

# Copy php-fpm configuration (optional, default might be sufficient)
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf # Adjust version

# Set the working directory
WORKDIR /var/www/wordpress

# Run the configuration script before starting php-fpm
ENTRYPOINT ["/usr/local/bin/wp-config.sh"]

# Command to run php-fpm
CMD ["php-fpm7.4", "-F"] # Adjust version if needed

# Expose the default php-fpm port
EXPOSE 9000