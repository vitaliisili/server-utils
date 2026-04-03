.PHONY: linkwarden-help linkwarden-up linkwarden-down linkwarden-restart linkwarden-logs linkwarden-status linkwarden-shell linkwarden-clean linkwarden-pull linkwarden-update

LINKWARDEN_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

linkwarden-help: ## Show linkwarden commands
	@echo "Linkwarden Commands:"
	@grep -E '^linkwarden-[a-zA-Z_-]+:.*?## .*$$' $(LINKWARDEN_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

linkwarden-up: ## Start linkwarden
	@echo "Starting linkwarden..."
	@cd $(LINKWARDEN_DIR) && docker compose up -d
	@echo "linkwarden is running!"

linkwarden-down: ## Stop linkwarden
	@echo "Stopping linkwarden..."
	@cd $(LINKWARDEN_DIR) && docker compose down
	@echo "linkwarden stopped"

linkwarden-restart: ## Restart linkwarden
	@echo "Restarting linkwarden..."
	@cd $(LINKWARDEN_DIR) && docker compose restart
	@echo "linkwarden restarted"

linkwarden-logs: ## Show linkwarden logs
	@cd $(LINKWARDEN_DIR) && docker compose logs -f

linkwarden-status: ## Show linkwarden status
	@cd $(LINKWARDEN_DIR) && docker compose ps

linkwarden-shell: ## Open shell in linkwarden container
	@cd $(LINKWARDEN_DIR) && docker compose exec linkwarden sh

linkwarden-clean: ## Remove linkwarden containers and volumes
	@echo "WARNING: This will remove all linkwarden data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(LINKWARDEN_DIR) && docker compose down -v; echo "linkwarden cleaned";; \
		*) echo "Canceled";; \
	esac

linkwarden-pull: ## Pull latest linkwarden images
	@echo "Pulling latest linkwarden images..."
	@cd $(LINKWARDEN_DIR) && docker compose pull
	@echo "Pull complete!"

linkwarden-update: ## Update linkwarden to latest version
	@echo "Updating linkwarden..."
	@cd $(LINKWARDEN_DIR) && docker compose pull
	@cd $(LINKWARDEN_DIR) && docker compose up -d
	@echo "linkwarden updated!"