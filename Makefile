# Makefile

SRCS_DIR = srcs

COMPOSE_FILE = $(SRCS_DIR)/docker-compose.yml

ENV_FILE = $(SRCS_DIR)/.env

all: build up

build:
	@echo "Montage des images Docker..."
	docker compose -f $(COMPOSE_FILE) build

# Lancer les conteneurs
up:
	@echo "Démarrage des conteneurs..."
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d

down:
	@echo "Arrêt des conteneurs..."
	docker compose -f $(COMPOSE_FILE) down

clean: down
	@echo "Nettoyage des conteneurs, images et volumes..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all --remove-orphans

re: clean all

.PHONY: all build up down clean re