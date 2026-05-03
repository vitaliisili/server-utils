.PHONY: anchor-help anchor-up anchor-down anchor-restart anchor-logs anchor-status anchor-shell anchor-clean anchor-pull anchor-update

ANCHOR_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

anchor-help: ## Show Anchor commands
	@echo "Anchor Commands:"
	@grep -E '^anchor-[a-zA-Z_-]+:.*?## .*$$' $(ANCHOR_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

anchor-up: ## Start Anchor
	@echo "Starting Anchor..."
	@cd $(ANCHOR_DIR) && docker compose up -d
	@echo "Anchor is running!"

anchor-down: ## Stop Anchor
	@echo "Stopping Anchor..."
	@cd $(ANCHOR_DIR) && docker compose down
	@echo "Anchor stopped"

anchor-restart: ## Restart Anchor
	@echo "Restarting Anchor..."
	@cd $(ANCHOR_DIR) && docker compose restart
	@echo "Anchor restarted"

anchor-logs: ## Show Anchor logs
	@cd $(ANCHOR_DIR) && docker compose logs -f

anchor-status: ## Show Anchor status
	@cd $(ANCHOR_DIR) && docker compose ps

anchor-shell: ## Open shell in Anchor container
	@cd $(ANCHOR_DIR) && docker compose exec anchor sh

anchor-clean: ## Remove Anchor containers and volumes
	@echo "WARNING: This will remove all Anchor data (database, notes, attachments, config)!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(ANCHOR_DIR) && docker compose down -v; echo "Anchor cleaned";; \
		*) echo "Canceled";; \
	esac

anchor-pull: ## Pull latest Anchor image
	@echo "Pulling latest Anchor image..."
	@cd $(ANCHOR_DIR) && docker compose pull
	@echo "Pull complete!"

anchor-update: ## Update Anchor to latest version
	@echo "Updating Anchor..."
	@cd $(ANCHOR_DIR) && docker compose pull
	@cd $(ANCHOR_DIR) && docker compose up -d
	@echo "Anchor updated!"