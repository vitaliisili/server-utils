.PHONY: dockhand-help dockhand-up dockhand-down dockhand-restart dockhand-logs dockhand-status dockhand-shell dockhand-clean dockhand-pull dockhand-update

DOCKHAND_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

dockhand-help: ## Show dockhand commands
	@echo "Dockhand Commands:"
	@grep -E '^dockhand-[a-zA-Z_-]+:.*?## .*$$' $(DOCKHAND_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

dockhand-up: ## Start dockhand
	@echo "Starting dockhand..."
	@cd $(DOCKHAND_DIR) && docker compose up -d
	@echo "dockhand is running!"

dockhand-down: ## Stop dockhand
	@echo "Stopping dockhand..."
	@cd $(DOCKHAND_DIR) && docker compose down
	@echo "dockhand stopped"

dockhand-restart: ## Restart dockhand
	@echo "Restarting dockhand..."
	@cd $(DOCKHAND_DIR) && docker compose restart
	@echo "dockhand restarted"

dockhand-logs: ## Show dockhand logs
	@cd $(DOCKHAND_DIR) && docker compose logs -f

dockhand-status: ## Show dockhand status
	@cd $(DOCKHAND_DIR) && docker compose ps

dockhand-shell: ## Open shell in dockhand container
	@cd $(DOCKHAND_DIR) && docker compose exec dockhand sh

dockhand-clean: ## Remove dockhand containers and volumes
	@echo "WARNING: This will remove all dockhand data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(DOCKHAND_DIR) && docker compose down -v; echo "dockhand cleaned";; \
		*) echo "Canceled";; \
	esac

dockhand-pull: ## Pull latest dockhand images
	@echo "Pulling latest dockhand images..."
	@cd $(DOCKHAND_DIR) && docker compose pull
	@echo "Pull complete!"

dockhand-update: ## Update dockhand to latest version
	@echo "Updating dockhand..."
	@cd $(DOCKHAND_DIR) && docker compose pull
	@cd $(DOCKHAND_DIR) && docker compose up -d
	@echo "dockhand updated!"