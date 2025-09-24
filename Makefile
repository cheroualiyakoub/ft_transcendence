# Define the Docker Compose command
COMPOSE = docker-compose
ENV_FILE = .env

# Create .env file if it doesn't exist
env:
	@if [ ! -f $(ENV_FILE) ]; then \
        if [ -f .env.example ]; then \
            cp .env.example $(ENV_FILE); \
            echo "$(ENV_FILE) created from .env.example"; \
        else \
            touch $(ENV_FILE); \
            echo "$(ENV_FILE) created (empty)"; \
        fi \
    else \
        echo "$(ENV_FILE) already exists"; \
    fi

# Build the base image
build-base:
	@echo "Building base Node.js image..."
	docker build -t ft_base_node ./base
	@echo "Base image 'ft_base_node' built successfully."

# Build all services (depends on base image)
build: build-base
	@echo "Building all services..."
	$(COMPOSE) build
	@echo "All services built successfully."

# Start all services (builds base image first if needed)
up: build-base
	@echo "Starting all services..."
	$(COMPOSE) up -d --build
	@echo "All services are up and running."

# Stop all services
down:
	$(COMPOSE) down

# Show logs for all services
logs:
	$(COMPOSE) logs -f

# Removes containers, networks, anonymous volumes (keeps images)
clean:
	$(COMPOSE) down -v --remove-orphans
	@echo "Containers, networks, and anonymous volumes removed (images kept)."

# Full clean: removes everything including base image
fclean:
	$(COMPOSE) down -v --rmi all --remove-orphans
	docker rmi ft_base_node 2>/dev/null || true
	@echo "Full cleanup done: containers, networks, volumes, images, and base image removed."

# Restart all services
restart: down up

# Open shell in a service container
shell:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
        echo "Usage: make shell <service>"; \
    else \
        $(COMPOSE) exec $(word 2,$(MAKECMDGOALS)) sh; \
    fi

# Build individual services
build-%: build-base
	$(COMPOSE) build $*

# Start individual services
up-%:
	$(COMPOSE) up -d $*

# Help command
help:
	@echo "Available commands:"
	@echo "  make env        -> Create .env file"
	@echo "  make build-base -> Build base Node.js image"
	@echo "  make build      -> Build all services"
	@echo "  make up         -> Start all services"
	@echo "  make down       -> Stop all services"
	@echo "  make logs       -> Show logs"
	@echo "  make clean      -> Clean containers and volumes"
	@echo "  make fclean     -> Full cleanup including images"
	@echo "  make restart    -> Restart all services"
	@echo "  make shell <service> -> Open shell in service"

.PHONY: env build-base build up down logs clean fclean restart shell help