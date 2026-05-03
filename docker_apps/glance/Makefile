.PHONY: glance-help glance-up glance-down glance-restart glance-logs glance-status glance-shell glance-clean glance-pull glance-update

GLANCE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

glance-help: ## Show Glance commands
	@echo "Glance Commands:"
	@grep -E '^glance-[a-zA-Z_-]+:.*?## .*$$' $(GLANCE_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

glance-up: ## Start Glance
	@echo "Starting Glance..."
	@cd $(GLANCE_DIR) && docker compose up -d
	@echo "Glance is running!"

glance-down: ## Stop Glance
	@echo "Stopping Glance..."
	@cd $(GLANCE_DIR) && docker compose down
	@echo "Glance stopped"

glance-restart: ## Restart Glance
	@echo "Restarting Glance..."
	@cd $(GLANCE_DIR) && docker compose restart
	@echo "Glance restarted"

glance-logs: ## Show Glance logs
	@cd $(GLANCE_DIR) && docker compose logs -f

glance-status: ## Show Glance status
	@cd $(GLANCE_DIR) && docker compose ps

glance-shell: ## Open shell in Glance container
	@cd $(GLANCE_DIR) && docker compose exec glance sh

glance-clean: ## Remove Glance containers (host config dir is preserved)
	@echo "WARNING: This will remove the Glance container."
	@echo "The host config directory at GLANCE_CONFIG_PATH (default /opt/docker_data/glance/config) is preserved."
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(GLANCE_DIR) && docker compose down -v; echo "Glance cleaned";; \
		*) echo "Canceled";; \
	esac

glance-pull: ## Pull latest Glance image
	@echo "Pulling latest Glance image..."
	@cd $(GLANCE_DIR) && docker compose pull
	@echo "Pull complete!"

glance-update: ## Update Glance to latest version
	@echo "Updating Glance..."
	@cd $(GLANCE_DIR) && docker compose pull
	@cd $(GLANCE_DIR) && docker compose up -d
	@echo "Glance updated!"