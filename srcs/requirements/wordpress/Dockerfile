# ~/inception/srcs/requirements/wordpress/Dockerfile
FROM debian:bullseye

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
    && rm -rf /home/fvastena/Desktop/inceptiontest/var/lib/apt/lists/*

# Download and extract WordPress
RUN apt-get update && \
    apt-get install -y php-cli php-fpm php-mysql wget curl unzip netcat && \
    rm -rf /home/fvastena/Desktop/inceptiontest/var/lib/apt/lists/*

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /home/fvastena/Desktop/inceptiontest/usr/local/bin/wp

# Copy WordPress configuration script
COPY ./tools/wp-config.sh /home/fvastena/Desktop/inceptiontest/usr/local/bin/

# Make the script executable
RUN chmod +x /home/fvastena/Desktop/inceptiontest/usr/local/bin/wp-config.sh

# Copy php-fpm configuration (optional, default might be sufficient)
# COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf # Adjust version

# Set the working directory
WORKDIR /home/fvastena/Desktop/inceptiontest/var/www/wordpress

# Run the configuration script before starting php-fpm
ENTRYPOINT ["/home/fvastena/Desktop/inceptiontest/usr/local/bin/wp-config.sh"]

# Command to run php-fpm
CMD ["php-fpm7.4", "-F"]

# Expose the default php-fpm port
EXPOSE 9000