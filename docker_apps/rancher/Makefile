.PHONY: rancher-help rancher-up rancher-down rancher-restart rancher-logs rancher-status rancher-shell rancher-clean rancher-pull rancher-update

RANCHER_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

rancher-help: ## Show rancher commands
	@echo "Rancher Commands:"
	@grep -E '^rancher-[a-zA-Z_-]+:.*?## .*$$' $(RANCHER_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

rancher-up: ## Start rancher
	@echo "Starting rancher..."
	@cd $(RANCHER_DIR) && docker compose up -d
	@echo "rancher is running!"

rancher-down: ## Stop rancher
	@echo "Stopping rancher..."
	@cd $(RANCHER_DIR) && docker compose down
	@echo "rancher stopped"

rancher-restart: ## Restart rancher
	@echo "Restarting rancher..."
	@cd $(RANCHER_DIR) && docker compose restart
	@echo "rancher restarted"

rancher-logs: ## Show rancher logs
	@cd $(RANCHER_DIR) && docker compose logs -f

rancher-status: ## Show rancher status
	@cd $(RANCHER_DIR) && docker compose ps

rancher-shell: ## Open shell in rancher container
	@cd $(RANCHER_DIR) && docker compose exec rancher bash

rancher-clean: ## Remove rancher containers and volumes
	@echo "WARNING: This will remove all rancher data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(RANCHER_DIR) && docker compose down -v; echo "rancher cleaned";; \
		*) echo "Canceled";; \
	esac

rancher-pull: ## Pull latest rancher image
	@echo "Pulling latest rancher image..."
	@cd $(RANCHER_DIR) && docker compose pull
	@echo "Pull complete!"

rancher-update: ## Update rancher to latest version
	@echo "Updating rancher..."
	@cd $(RANCHER_DIR) && docker compose pull
	@cd $(RANCHER_DIR) && docker compose up -d
	@echo "rancher updated!"