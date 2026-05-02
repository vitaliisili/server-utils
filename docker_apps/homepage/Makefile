.PHONY: homepage-help homepage-up homepage-down homepage-restart homepage-logs homepage-status homepage-shell homepage-clean homepage-pull homepage-update

HOMEPAGE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

homepage-help: ## Show Homepage commands
	@echo "Homepage Commands:"
	@grep -E '^homepage-[a-zA-Z_-]+:.*?## .*$$' $(HOMEPAGE_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

homepage-up: ## Start Homepage
	@echo "Starting Homepage..."
	@cd $(HOMEPAGE_DIR) && docker compose up -d
	@echo "Homepage is running!"

homepage-down: ## Stop Homepage
	@echo "Stopping Homepage..."
	@cd $(HOMEPAGE_DIR) && docker compose down
	@echo "Homepage stopped"

homepage-restart: ## Restart Homepage
	@echo "Restarting Homepage..."
	@cd $(HOMEPAGE_DIR) && docker compose restart
	@echo "Homepage restarted"

homepage-logs: ## Show Homepage logs
	@cd $(HOMEPAGE_DIR) && docker compose logs -f

homepage-status: ## Show Homepage status
	@cd $(HOMEPAGE_DIR) && docker compose ps

homepage-shell: ## Open shell in Homepage container
	@cd $(HOMEPAGE_DIR) && docker compose exec homepage sh

homepage-clean: ## Remove Homepage containers (host config dir is preserved)
	@echo "WARNING: This will remove the Homepage container."
	@echo "The host config directory at HOMEPAGE_CONFIG_PATH (default /opt/docker_data/homepage/config) is preserved."
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(HOMEPAGE_DIR) && docker compose down -v; echo "Homepage cleaned";; \
		*) echo "Canceled";; \
	esac

homepage-pull: ## Pull latest Homepage image
	@echo "Pulling latest Homepage image..."
	@cd $(HOMEPAGE_DIR) && docker compose pull
	@echo "Pull complete!"

homepage-update: ## Update Homepage to latest version
	@echo "Updating Homepage..."
	@cd $(HOMEPAGE_DIR) && docker compose pull
	@cd $(HOMEPAGE_DIR) && docker compose up -d
	@echo "Homepage updated!"