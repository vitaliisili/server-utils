.PHONY: infisical-help infisical-up infisical-down infisical-restart infisical-logs infisical-status infisical-shell infisical-clean infisical-pull infisical-update

INFISICAL_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

infisical-help: ## Show Infisical commands
	@echo "Infisical Commands:"
	@grep -E '^infisical-[a-zA-Z_-]+:.*?## .*$$' $(INFISICAL_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

infisical-up: ## Start Infisical
	@echo "Starting Infisical..."
	@cd $(INFISICAL_DIR) && docker compose up -d
	@echo "Infisical is running!"

infisical-down: ## Stop Infisical
	@echo "Stopping Infisical..."
	@cd $(INFISICAL_DIR) && docker compose down
	@echo "Infisical stopped"

infisical-restart: ## Restart Infisical
	@echo "Restarting Infisical..."
	@cd $(INFISICAL_DIR) && docker compose restart
	@echo "Infisical restarted"

infisical-logs: ## Show Infisical logs
	@cd $(INFISICAL_DIR) && docker compose logs -f

infisical-status: ## Show Infisical status
	@cd $(INFISICAL_DIR) && docker compose ps

infisical-shell: ## Open shell in Infisical backend
	@cd $(INFISICAL_DIR) && docker compose exec vs-infisical-backend sh

infisical-clean: ## Remove Infisical containers and volumes
	@echo "WARNING: This will remove all Infisical data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(INFISICAL_DIR) && docker compose down -v; echo "Infisical cleaned";; \
		*) echo "Canceled";; \
	esac

infisical-pull: ## Pull latest Infisical images
	@echo "Pulling latest Infisical images..."
	@cd $(INFISICAL_DIR) && docker compose pull
	@echo "Pull complete!"

infisical-update: ## Update Infisical to latest version
	@echo "Updating Infisical..."
	@cd $(INFISICAL_DIR) && docker compose pull
	@cd $(INFISICAL_DIR) && docker compose up -d
	@echo "Infisical updated!"
