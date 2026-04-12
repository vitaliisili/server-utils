.PHONY: komodo-help komodo-up komodo-down komodo-restart komodo-logs komodo-status komodo-shell komodo-clean komodo-pull komodo-update

KOMODO_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

komodo-help: ## Show komodo commands
	@echo "Komodo Commands:"
	@grep -E '^komodo-[a-zA-Z_-]+:.*?## .*$$' $(KOMODO_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

komodo-up: ## Start komodo
	@echo "Starting komodo..."
	@cd $(KOMODO_DIR) && docker compose up -d
	@echo "komodo is running!"

komodo-down: ## Stop komodo
	@echo "Stopping komodo..."
	@cd $(KOMODO_DIR) && docker compose down
	@echo "komodo stopped"

komodo-restart: ## Restart komodo
	@echo "Restarting komodo..."
	@cd $(KOMODO_DIR) && docker compose restart
	@echo "komodo restarted"

komodo-logs: ## Show komodo logs
	@cd $(KOMODO_DIR) && docker compose logs -f

komodo-status: ## Show komodo status
	@cd $(KOMODO_DIR) && docker compose ps

komodo-shell: ## Open shell in komodo-core container
	@cd $(KOMODO_DIR) && docker compose exec komodo-core sh

komodo-clean: ## Remove komodo containers and volumes
	@echo "WARNING: This will remove all komodo data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(KOMODO_DIR) && docker compose down -v; echo "komodo cleaned";; \
		*) echo "Canceled";; \
	esac

komodo-pull: ## Pull latest komodo images
	@echo "Pulling latest komodo images..."
	@cd $(KOMODO_DIR) && docker compose pull
	@echo "Pull complete!"

komodo-update: ## Update komodo to latest version
	@echo "Updating komodo..."
	@cd $(KOMODO_DIR) && docker compose pull
	@cd $(KOMODO_DIR) && docker compose up -d
	@echo "komodo updated!"