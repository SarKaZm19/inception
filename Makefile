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

status:
	@echo "$(GREEN)Statut des conteneurs:$(RESET)"
	$(DOCKER) ps -a
	@echo "\n$(GREEN)Réseaux:$(RESET)"
	$(DOCKER) network ls
	@echo "\n$(GREEN)Volumes:$(RESET)"
	$(DOCKER) volume ls

down:
	@echo "$(YELLOW)Arrêt des conteneurs...$(RESET)"
	$(DOCKER_COMPOSE) down -v

clean:
	@echo "$(YELLOW)Nettoyage des conteneurs, réseaux et volumes non utilisés...$(RESET)"
	$(DOCKER) system prune -f

fclean: down
	@echo "$(RED)Suppression complète des données et ressources Docker...$(RESET)"
	$(DOCKER) system prune -af --volumes
	sudo rm -rf $(HOME)/data

clean: down
	@echo "Nettoyage des conteneurs, images et volumes..."
	docker compose -f $(COMPOSE_FILE) down --volumes --rmi all --remove-orphans

re: clean all

.PHONY: all build up down clean fclean re