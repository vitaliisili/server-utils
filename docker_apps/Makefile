.PHONY: help all-up all-down all-restart all-status all-logs

.DEFAULT_GOAL := help

# Include app-specific Makefiles
include drone/Makefile
include jenkins/Makefile
include n8n/Makefile
include portainer/Makefile
include rocketchat/Makefile
include nextcloud/Makefile
include linkwarden/Makefile

help: ## Show all available commands
	@echo "=== Docker Apps Management ==="
	@echo ""
	@echo "Global Commands:"
	@echo "  all-up              Start all services"
	@echo "  all-down            Stop all services"
	@echo "  all-restart         Restart all services"
	@echo "  all-status          Show status of all services"
	@echo ""
	@echo "=== Drone CI ==="
	@$(MAKE) -s drone-help
	@echo ""
	@echo "=== Jenkins ==="
	@$(MAKE) -s jenkins-help
	@echo ""
	@echo "=== n8n ==="
	@$(MAKE) -s n8n-help
	@echo ""
	@echo "=== Portainer ==="
	@$(MAKE) -s portainer-help
	@echo ""
	@echo "=== Rocket.Chat ==="
	@$(MAKE) -s rocketchat-help
	@echo ""
	@echo "=== Nextcloud ==="
	@$(MAKE) -s nextcloud-help
	@echo ""
	@echo "=== Linkwarden ==="
	@$(MAKE) -s linkwarden-help
	@echo ""

all-up: ## Start all services
	@echo "Starting all services..."
	@$(MAKE) drone-up
	@$(MAKE) jenkins-up
	@$(MAKE) n8n-up
	@$(MAKE) portainer-up
	@$(MAKE) rocketchat-up
	@$(MAKE) nextcloud-up
	@$(MAKE) linkwarden-up
	@echo "All services started!"

all-down: ## Stop all services
	@echo "Stopping all services..."
	@$(MAKE) drone-down
	@$(MAKE) jenkins-down
	@$(MAKE) n8n-down
	@$(MAKE) portainer-down
	@$(MAKE) rocketchat-down
	@$(MAKE) nextcloud-down
	@$(MAKE) linkwarden-down
	@echo "All services stopped!"

all-restart: ## Restart all services
	@echo "Restarting all services..."
	@$(MAKE) drone-restart
	@$(MAKE) jenkins-restart
	@$(MAKE) n8n-restart
	@$(MAKE) portainer-restart
	@$(MAKE) rocketchat-restart
	@$(MAKE) nextcloud-restart
	@$(MAKE) linkwarden-restart
	@echo "All services restarted!"

all-status: ## Show status of all services
	@echo "=== Drone Status ==="
	@$(MAKE) drone-status
	@echo ""
	@echo "=== Jenkins Status ==="
	@$(MAKE) jenkins-status
	@echo ""
	@echo "=== n8n Status ==="
	@$(MAKE) n8n-status
	@echo ""
	@echo "=== Portainer Status ==="
	@$(MAKE) portainer-status
	@echo ""
	@echo "=== Rocket.Chat Status ==="
	@$(MAKE) rocketchat-status
	@echo ""
	@echo "=== Nextcloud Status ==="
	@$(MAKE) nextcloud-status
	@echo ""
	@echo "=== Linkwarden Status ==="
	@$(MAKE) linkwarden-status
