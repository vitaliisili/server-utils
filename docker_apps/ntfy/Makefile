.PHONY: ntfy-help ntfy-up ntfy-down ntfy-restart ntfy-logs ntfy-status ntfy-shell ntfy-clean ntfy-pull ntfy-update

NTFY_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

ntfy-help: ## Show ntfy commands
	@echo "ntfy Commands:"
	@grep -E '^ntfy-[a-zA-Z_-]+:.*?## .*$$' $(NTFY_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

ntfy-up: ## Start ntfy
	@echo "Starting ntfy..."
	@cd $(NTFY_DIR) && docker compose up -d
	@echo "ntfy is running!"

ntfy-down: ## Stop ntfy
	@echo "Stopping ntfy..."
	@cd $(NTFY_DIR) && docker compose down
	@echo "ntfy stopped"

ntfy-restart: ## Restart ntfy
	@echo "Restarting ntfy..."
	@cd $(NTFY_DIR) && docker compose restart
	@echo "ntfy restarted"

ntfy-logs: ## Show ntfy logs
	@cd $(NTFY_DIR) && docker compose logs -f

ntfy-status: ## Show ntfy status
	@cd $(NTFY_DIR) && docker compose ps

ntfy-shell: ## Open shell in ntfy container
	@cd $(NTFY_DIR) && docker compose exec ntfy sh

ntfy-clean: ## Remove ntfy containers and volumes
	@echo "WARNING: This will remove all ntfy data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(NTFY_DIR) && docker compose down -v; echo "ntfy cleaned";; \
		*) echo "Canceled";; \
	esac

ntfy-pull: ## Pull latest ntfy image
	@echo "Pulling latest ntfy image..."
	@cd $(NTFY_DIR) && docker compose pull
	@echo "Pull complete!"

ntfy-update: ## Update ntfy to latest version
	@echo "Updating ntfy..."
	@cd $(NTFY_DIR) && docker compose pull
	@cd $(NTFY_DIR) && docker compose up -d
	@echo "ntfy updated!"