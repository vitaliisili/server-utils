.PHONY: memos-help memos-up memos-down memos-restart memos-logs memos-status memos-shell memos-clean memos-pull memos-update

MEMOS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

memos-help: ## Show Memos commands
	@echo "Memos Commands:"
	@grep -E '^memos-[a-zA-Z_-]+:.*?## .*$$' $(MEMOS_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

memos-up: ## Start Memos
	@echo "Starting Memos..."
	@cd $(MEMOS_DIR) && docker compose up -d
	@echo "Memos is running!"

memos-down: ## Stop Memos
	@echo "Stopping Memos..."
	@cd $(MEMOS_DIR) && docker compose down
	@echo "Memos stopped"

memos-restart: ## Restart Memos
	@echo "Restarting Memos..."
	@cd $(MEMOS_DIR) && docker compose restart
	@echo "Memos restarted"

memos-logs: ## Show Memos logs
	@cd $(MEMOS_DIR) && docker compose logs -f

memos-status: ## Show Memos status
	@cd $(MEMOS_DIR) && docker compose ps

memos-shell: ## Open shell in Memos container
	@cd $(MEMOS_DIR) && docker compose exec memos sh

memos-clean: ## Remove Memos containers and volumes
	@echo "WARNING: This will remove all Memos data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(MEMOS_DIR) && docker compose down -v; echo "Memos cleaned";; \
		*) echo "Canceled";; \
	esac

memos-pull: ## Pull latest Memos image
	@echo "Pulling latest Memos image..."
	@cd $(MEMOS_DIR) && docker compose pull
	@echo "Pull complete!"

memos-update: ## Update Memos to latest version
	@echo "Updating Memos..."
	@cd $(MEMOS_DIR) && docker compose pull
	@cd $(MEMOS_DIR) && docker compose up -d
	@echo "Memos updated!"
