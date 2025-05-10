# ~/inception/srcs/requirements/mariadb/Dockerfile
FROM debian:bookworm

# Installer MariaDB Server
RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/* # Nettoyer les caches APT

# Copier le script d'initialisation de la base de données
COPY ./tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

# Exposer le port par défaut de MariaDB (interne au réseau Docker)
EXPOSE 3306

# Définir le point d'entrée du conteneur
# Utiliser un script qui s'exécute et s'assure que le service principal reste en cours
CMD ["/usr/local/bin/init_db.sh"]

# Alternative simple (moins robuste pour l'init)
# CMD ["mysqld"]
