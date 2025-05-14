# Makefile

SRCS_DIR = srcs

COMPOSE_FILE = $(SRCS_DIR)/docker-compose.yml

ENV_FILE = $(SRCS_DIR)/.env

all: build up

build:
	@echo "Montage des images Docker..."
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	docker compose -f $(COMPOSE_FILE) build

# Lancer les conteneurs
up:
	@echo "Démarrage des conteneurs..."
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d

down:
	@echo "$(YELLOW)Arrêt des conteneurs...$(RESET)"
	docker compose -f $(COMPOSE_FILE) down -v

clean: 
	@echo "Nettoyage des conteneurs, images et volumes..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all --remove-orphans

fclean: down
	@echo "$(RED)Suppression complète des données et ressources Docker...$(RESET)"
	docker system prune -af --volumes
	sudo rm -rf $(HOME)/data

status:
	@echo "$(GREEN)Statut des conteneurs:$(RESET)"
	docker ps -a
	@echo "\n$(GREEN)Réseaux:$(RESET)"
	docker network ls
	@echo "\n$(GREEN)Volumes:$(RESET)"
	docker volume ls

re: clean all

.PHONY: all build up down clean fclean re