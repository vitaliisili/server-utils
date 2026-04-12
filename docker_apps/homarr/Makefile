.PHONY: homarr-help homarr-up homarr-down homarr-restart homarr-logs homarr-status homarr-shell homarr-clean homarr-pull homarr-update

HOMARR_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

homarr-help: ## Show homarr commands
	@echo "Homarr Commands:"
	@grep -E '^homarr-[a-zA-Z_-]+:.*?## .*$$' $(HOMARR_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

homarr-up: ## Start homarr
	@echo "Starting homarr..."
	@cd $(HOMARR_DIR) && docker compose up -d
	@echo "homarr is running!"

homarr-down: ## Stop homarr
	@echo "Stopping homarr..."
	@cd $(HOMARR_DIR) && docker compose down
	@echo "homarr stopped"

homarr-restart: ## Restart homarr
	@echo "Restarting homarr..."
	@cd $(HOMARR_DIR) && docker compose restart
	@echo "homarr restarted"

homarr-logs: ## Show homarr logs
	@cd $(HOMARR_DIR) && docker compose logs -f

homarr-status: ## Show homarr status
	@cd $(HOMARR_DIR) && docker compose ps

homarr-shell: ## Open shell in homarr container
	@cd $(HOMARR_DIR) && docker compose exec homarr sh

homarr-clean: ## Remove homarr containers and volumes
	@echo "WARNING: This will remove all homarr data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(HOMARR_DIR) && docker compose down -v; echo "homarr cleaned";; \
		*) echo "Canceled";; \
	esac

homarr-pull: ## Pull latest homarr image
	@echo "Pulling latest homarr image..."
	@cd $(HOMARR_DIR) && docker compose pull
	@echo "Pull complete!"

homarr-update: ## Update homarr to latest version
	@echo "Updating homarr..."
	@cd $(HOMARR_DIR) && docker compose pull
	@cd $(HOMARR_DIR) && docker compose up -d
	@echo "homarr updated!"