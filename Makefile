# -----------------------------
# Project: ft_transcendence
# Author: Your Name
# -----------------------------

# Variables
COMPOSE=docker-compose
ENV_FILE=.env

# Services
SERVICES=gateway user tournament match chat ai nginx

# -----------------------------
# Helpers
# -----------------------------
.PHONY: help env up down build logs clean fclean restart shell

help:
	@echo "Makefile commands:"
	@echo "  make env        -> Copy .env.example to .env if missing"
	@echo "  make up         -> Build and start all services (detached)"
	@echo "  make down       -> Stop all services (keep images)"
	@echo "  make build      -> Build all Docker images"
	@echo "  make logs       -> Show logs of all services"
	@echo "  make clean      -> Remove containers, networks, and anonymous volumes (keep images)"
	@echo "  make fclean     -> Remove everything: containers, networks, volumes, images, orphans"
	@echo "  make restart    -> Restart all services"
	@echo "  make shell <service> -> Open shell in a service container"

env:
	@if [ ! -f $(ENV_FILE) ]; then \
		cp .env.example $(ENV_FILE); \
		echo "$(ENV_FILE) created from .env.example"; \
	else \
		echo "$(ENV_FILE) already exists"; \
	fi

# -----------------------------
# Docker commands
# -----------------------------
up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

build:
	$(COMPOSE) build

logs:
	$(COMPOSE) logs -f

# Removes containers, networks, anonymous volumes (keeps images)
clean:
	$(COMPOSE) down -v --remove-orphans
	@echo "Containers, networks, and anonymous volumes removed (images kept)."

# Full clean: removes everything including images
fclean:
	$(COMPOSE) down -v --rmi all --remove-orphans
	@echo "Full cleanup done: containers, networks, volumes, and images removed."

restart: down up

shell:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make shell <service>"; \
	else \
		$(COMPOSE) exec $(word 2,$(MAKECMDGOALS)) sh; \
	fi

# -----------------------------
# Optional: build/run individual services
# -----------------------------
build-%:
	$(COMPOSE) build $*

up-%:
	$(COMPOSE) up -d $*

logs-%:
	$(COMPOSE) logs -f $*
