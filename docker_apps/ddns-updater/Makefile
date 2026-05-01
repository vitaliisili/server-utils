.PHONY: ddns-updater-help ddns-updater-up ddns-updater-down ddns-updater-restart ddns-updater-logs ddns-updater-status ddns-updater-shell ddns-updater-clean ddns-updater-pull ddns-updater-update

DDNS_UPDATER_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

ddns-updater-help: ## Show DDNS Updater commands
	@echo "DDNS Updater Commands:"
	@grep -E '^ddns-updater-[a-zA-Z_-]+:.*?## .*$$' $(DDNS_UPDATER_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

ddns-updater-up: ## Start DDNS Updater
	@echo "Starting DDNS Updater..."
	@cd $(DDNS_UPDATER_DIR) && docker compose up -d
	@echo "DDNS Updater is running!"

ddns-updater-down: ## Stop DDNS Updater
	@echo "Stopping DDNS Updater..."
	@cd $(DDNS_UPDATER_DIR) && docker compose down
	@echo "DDNS Updater stopped"

ddns-updater-restart: ## Restart DDNS Updater
	@echo "Restarting DDNS Updater..."
	@cd $(DDNS_UPDATER_DIR) && docker compose restart
	@echo "DDNS Updater restarted"

ddns-updater-logs: ## Show DDNS Updater logs
	@cd $(DDNS_UPDATER_DIR) && docker compose logs -f

ddns-updater-status: ## Show DDNS Updater status
	@cd $(DDNS_UPDATER_DIR) && docker compose ps

ddns-updater-shell: ## Open shell in DDNS Updater container
	@cd $(DDNS_UPDATER_DIR) && docker compose exec ddns-updater sh

ddns-updater-clean: ## Remove DDNS Updater containers and volumes
	@echo "WARNING: This will remove all DDNS Updater data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(DDNS_UPDATER_DIR) && docker compose down -v; echo "DDNS Updater cleaned";; \
		*) echo "Canceled";; \
	esac

ddns-updater-pull: ## Pull latest DDNS Updater image
	@echo "Pulling latest DDNS Updater image..."
	@cd $(DDNS_UPDATER_DIR) && docker compose pull
	@echo "Pull complete!"

ddns-updater-update: ## Update DDNS Updater to latest version
	@echo "Updating DDNS Updater..."
	@cd $(DDNS_UPDATER_DIR) && docker compose pull
	@cd $(DDNS_UPDATER_DIR) && docker compose up -d
	@echo "DDNS Updater updated!"
