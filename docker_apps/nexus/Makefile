.PHONY: nexus-help nexus-up nexus-down nexus-restart nexus-logs nexus-status nexus-shell nexus-clean nexus-pull nexus-update

NEXUS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

nexus-help: ## Show Nexus commands
	@echo "Nexus Commands:"
	@grep -E '^nexus-[a-zA-Z_-]+:.*?## .*$$' $(NEXUS_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

nexus-up: ## Start Nexus
	@echo "Starting Nexus..."
	@cd $(NEXUS_DIR) && docker compose up -d
	@echo "Nexus is running!"

nexus-down: ## Stop Nexus
	@echo "Stopping Nexus..."
	@cd $(NEXUS_DIR) && docker compose down
	@echo "Nexus stopped"

nexus-restart: ## Restart Nexus
	@echo "Restarting Nexus..."
	@cd $(NEXUS_DIR) && docker compose restart
	@echo "Nexus restarted"

nexus-logs: ## Show Nexus logs
	@cd $(NEXUS_DIR) && docker compose logs -f

nexus-status: ## Show Nexus status
	@cd $(NEXUS_DIR) && docker compose ps

nexus-shell: ## Open shell in Nexus container
	@cd $(NEXUS_DIR) && docker compose exec nexus sh

nexus-clean: ## Remove Nexus containers and volumes
	@echo "WARNING: This will remove all Nexus data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(NEXUS_DIR) && docker compose down -v; echo "Nexus cleaned";; \
		*) echo "Canceled";; \
	esac

nexus-pull: ## Pull latest Nexus image
	@echo "Pulling latest Nexus image..."
	@cd $(NEXUS_DIR) && docker compose pull
	@echo "Pull complete!"

nexus-update: ## Update Nexus to latest version
	@echo "Updating Nexus..."
	@cd $(NEXUS_DIR) && docker compose pull
	@cd $(NEXUS_DIR) && docker compose up -d
	@echo "Nexus updated!"
