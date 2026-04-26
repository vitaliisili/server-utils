.PHONY: snapotter-help snapotter-up snapotter-down snapotter-restart snapotter-logs snapotter-status snapotter-shell snapotter-clean snapotter-pull snapotter-update

SNAPOTTER_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

snapotter-help: ## Show snapotter commands
	@echo "SnapOtter Commands:"
	@grep -E '^snapotter-[a-zA-Z_-]+:.*?## .*$$' $(SNAPOTTER_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

snapotter-up: ## Start snapotter
	@echo "Starting snapotter..."
	@cd $(SNAPOTTER_DIR) && docker compose up -d
	@echo "snapotter is running!"

snapotter-down: ## Stop snapotter
	@echo "Stopping snapotter..."
	@cd $(SNAPOTTER_DIR) && docker compose down
	@echo "snapotter stopped"

snapotter-restart: ## Restart snapotter
	@echo "Restarting snapotter..."
	@cd $(SNAPOTTER_DIR) && docker compose restart
	@echo "snapotter restarted"

snapotter-logs: ## Show snapotter logs
	@cd $(SNAPOTTER_DIR) && docker compose logs -f

snapotter-status: ## Show snapotter status
	@cd $(SNAPOTTER_DIR) && docker compose ps

snapotter-shell: ## Open shell in snapotter container
	@cd $(SNAPOTTER_DIR) && docker compose exec snapotter sh

snapotter-clean: ## Remove snapotter containers and volumes
	@echo "WARNING: This will remove all snapotter data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(SNAPOTTER_DIR) && docker compose down -v; echo "snapotter cleaned";; \
		*) echo "Canceled";; \
	esac

snapotter-pull: ## Pull latest snapotter images
	@echo "Pulling latest snapotter images..."
	@cd $(SNAPOTTER_DIR) && docker compose pull
	@echo "Pull complete!"

snapotter-update: ## Update snapotter to latest version
	@echo "Updating snapotter..."
	@cd $(SNAPOTTER_DIR) && docker compose pull
	@cd $(SNAPOTTER_DIR) && docker compose up -d
	@echo "snapotter updated!"