.PHONY: novu-help novu-up novu-down novu-restart novu-logs novu-status novu-shell novu-clean novu-pull novu-update

NOVU_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

novu-help: ## Show novu commands
	@echo "Novu Commands:"
	@grep -E '^novu-[a-zA-Z_-]+:.*?## .*$$' $(NOVU_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

novu-up: ## Start novu
	@echo "Starting novu..."
	@cd $(NOVU_DIR) && docker compose up -d
	@echo "novu is running!"

novu-down: ## Stop novu
	@echo "Stopping novu..."
	@cd $(NOVU_DIR) && docker compose down
	@echo "novu stopped"

novu-restart: ## Restart novu
	@echo "Restarting novu..."
	@cd $(NOVU_DIR) && docker compose restart
	@echo "novu restarted"

novu-logs: ## Show novu logs
	@cd $(NOVU_DIR) && docker compose logs -f

novu-status: ## Show novu status
	@cd $(NOVU_DIR) && docker compose ps

novu-shell: ## Open shell in novu-api container
	@cd $(NOVU_DIR) && docker compose exec novu-api sh

novu-clean: ## Remove novu containers and volumes
	@echo "WARNING: This will remove all novu data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(NOVU_DIR) && docker compose down -v; echo "novu cleaned";; \
		*) echo "Canceled";; \
	esac

novu-pull: ## Pull latest novu images
	@echo "Pulling latest novu images..."
	@cd $(NOVU_DIR) && docker compose pull
	@echo "Pull complete!"

novu-update: ## Update novu to latest version
	@echo "Updating novu..."
	@cd $(NOVU_DIR) && docker compose pull
	@cd $(NOVU_DIR) && docker compose up -d
	@echo "novu updated!"