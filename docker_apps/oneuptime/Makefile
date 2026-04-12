.PHONY: oneuptime-help oneuptime-up oneuptime-down oneuptime-restart oneuptime-logs oneuptime-status oneuptime-shell oneuptime-clean oneuptime-pull oneuptime-update

ONEUPTIME_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

oneuptime-help: ## Show oneuptime commands
	@echo "OneUptime Commands:"
	@grep -E '^oneuptime-[a-zA-Z_-]+:.*?## .*$$' $(ONEUPTIME_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

oneuptime-up: ## Start oneuptime
	@echo "Starting oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose up -d
	@echo "oneuptime is running!"

oneuptime-down: ## Stop oneuptime
	@echo "Stopping oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose down
	@echo "oneuptime stopped"

oneuptime-restart: ## Restart oneuptime
	@echo "Restarting oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose restart
	@echo "oneuptime restarted"

oneuptime-logs: ## Show oneuptime logs
	@cd $(ONEUPTIME_DIR) && docker compose logs -f

oneuptime-status: ## Show oneuptime status
	@cd $(ONEUPTIME_DIR) && docker compose ps

oneuptime-shell: ## Open shell in oneuptime-app container
	@cd $(ONEUPTIME_DIR) && docker compose exec oneuptime-app sh

oneuptime-clean: ## Remove oneuptime containers and volumes
	@echo "WARNING: This will remove all oneuptime data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(ONEUPTIME_DIR) && docker compose down -v; echo "oneuptime cleaned";; \
		*) echo "Canceled";; \
	esac

oneuptime-pull: ## Pull latest oneuptime images
	@echo "Pulling latest oneuptime images..."
	@cd $(ONEUPTIME_DIR) && docker compose pull
	@echo "Pull complete!"

oneuptime-update: ## Update oneuptime to latest version
	@echo "Updating oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose pull
	@cd $(ONEUPTIME_DIR) && docker compose up -d
	@echo "oneuptime updated!"