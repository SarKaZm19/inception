# Makefile

# Définir le chemin vers le dossier srcs
SRCS_DIR = srcs

# Nom du fichier docker-compose
COMPOSE_FILE = $(SRCS_DIR)/docker-compose.yml

# Nom du fichier .env
ENV_FILE = $(SRCS_DIR)/.env

# Variables pour les secrets (à adapter si vous en ajoutez)
SECRETS_DIR = secrets
DB_PASSWORD_SECRET = $(SECRETS_DIR)/db_password.txt
DB_ROOT_PASSWORD_SECRET = $(SECRETS_DIR)/db_root_password.txt
WP_ADMIN_PASSWORD_SECRET = $(SECRETS_DIR)/wp_admin_password.txt

# Cible par défaut : construire et lancer les services
all: build up

# Construire les images Docker
build:
	@echo "Building Docker images..."
	docker compose -f $(COMPOSE_FILE) build

# Lancer les conteneurs
up:
	@echo "Starting containers..."
# --env-file pour charger les variables du .env
# --secret pour monter les secrets dans les conteneurs
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d \
		--secret db_password,source=$(DB_PASSWORD_SECRET) \
		--secret db_root_password,source=$(DB_ROOT_PASSWORD_SECRET) \
		--secret wp_admin_password,source=$(WP_ADMIN_PASSWORD_SECRET)

# Arrêter les conteneurs
down:
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE_FILE) down

# Nettoyer (arrêter les conteneurs et supprimer les images, volumes, réseaux)
clean: down
	@echo "Cleaning up Docker resources..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all --remove-orphans

# Redémarrer les conteneurs
re: clean all

.PHONY: all build up down clean re