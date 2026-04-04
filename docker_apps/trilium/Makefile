.PHONY: trilium-help trilium-up trilium-down trilium-restart trilium-logs trilium-status trilium-shell trilium-clean trilium-pull trilium-update

TRILIUM_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

trilium-help: ## Show Trilium commands
	@echo "Trilium Commands:"
	@grep -E '^trilium-[a-zA-Z_-]+:.*?## .*$$' $(TRILIUM_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

trilium-up: ## Start Trilium
	@echo "Starting Trilium..."
	@cd $(TRILIUM_DIR) && docker compose up -d
	@echo "Trilium is running!"

trilium-down: ## Stop Trilium
	@echo "Stopping Trilium..."
	@cd $(TRILIUM_DIR) && docker compose down
	@echo "Trilium stopped"

trilium-restart: ## Restart Trilium
	@echo "Restarting Trilium..."
	@cd $(TRILIUM_DIR) && docker compose restart
	@echo "Trilium restarted"

trilium-logs: ## Show Trilium logs
	@cd $(TRILIUM_DIR) && docker compose logs -f

trilium-status: ## Show Trilium status
	@cd $(TRILIUM_DIR) && docker compose ps

trilium-shell: ## Open shell in Trilium container
	@cd $(TRILIUM_DIR) && docker compose exec trilium sh

trilium-clean: ## Remove Trilium containers and volumes
	@echo "WARNING: This will remove all Trilium data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(TRILIUM_DIR) && docker compose down -v; echo "Trilium cleaned";; \
		*) echo "Canceled";; \
	esac

trilium-pull: ## Pull latest Trilium image
	@echo "Pulling latest Trilium image..."
	@cd $(TRILIUM_DIR) && docker compose pull
	@echo "Pull complete!"

trilium-update: ## Update Trilium to latest version
	@echo "Updating Trilium..."
	@cd $(TRILIUM_DIR) && docker compose pull
	@cd $(TRILIUM_DIR) && docker compose up -d
	@echo "Trilium updated!"
