# ~/inception/Makefile

# Include the .env file to use variables like DOMAIN_NAME
include srcs/.env

# Define the path to docker-compose.yml
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

# Default target: build and up
all: build up

# Build Docker images
build:
    @echo "Building Docker images..."
    docker-compose -f ${DOCKER_COMPOSE_FILE} build

# Start containers
up:
    @echo "Starting containers..."
    docker-compose -f ${DOCKER_COMPOSE_FILE} up -d

# Stop and remove containers, networks, and volumes
down:
    @echo "Stopping and removing containers, network, and volumes..."
    docker-compose -f ${DOCKER_COMPOSE_FILE} down -v

# Clean up: stop and remove containers, networks, volumes, and built images
clean: down
    @echo "Removing built images..."
    docker-compose -f ${DOCKER_COMPOSE_FILE} rm -fsv
    docker image prune -f --filter label=com.docker.compose.project=${PWD##*/} # Remove images built by compose

# Rebuild: clean and then build and up
re: clean all

# Phony targets
.PHONY: all build up down clean re



