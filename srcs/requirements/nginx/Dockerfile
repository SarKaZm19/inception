# ~/inception/srcs/requirements/nginx/Dockerfile
ARG DEBIAN_VERSION=bullseye
FROM debian:${DEBIAN_VERSION}

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install NGINX and OpenSSL
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /home/fvastena/Desktop/inceptiontest/var/lib/apt/lists/*

# Generate SSL certificate and key
# This is a self-signed certificate for testing. For production, use a CA.
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /home/fvastena/Desktop/inceptiontest/etc/ssl/private/nginx.key \
    -out /home/fvastena/Desktop/inceptiontest/etc/ssl/certs/nginx.crt \
    -subj "/C=BE/ST=Brussels/L=Brussels/O=42/OU=Inception/CN=${DOMAIN_NAME}"

# Copy NGINX configuration file
COPY ./conf/nginx.conf /home/fvastena/Desktop/inceptiontest/etc/nginx/nginx.conf

# Expose port 443
EXPOSE 443

# Command to run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]