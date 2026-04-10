.PHONY: ntfy-help ntfy-up ntfy-down ntfy-restart ntfy-logs ntfy-status ntfy-shell ntfy-clean ntfy-pull ntfy-update ntfy-secrets

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

ntfy-secrets: ## Pull secrets from Infisical and generate .env
	@echo "Fetching ntfy secrets from Infisical..."
	@if [ ! -f $(NTFY_DIR).infisical-auth ]; then \
		echo "ERROR: .infisical-auth file not found."; \
		echo "Create it with two lines:"; \
		echo "  CLIENT_ID=your-client-id"; \
		echo "  CLIENT_SECRET=your-client-secret"; \
		exit 1; \
	fi
	@cd $(NTFY_DIR) && \
		export $$(cat .infisical-auth | xargs) && \
		PROJECT_ID=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['workspaceId'])") && \
		ENV=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['defaultEnvironment'])") && \
		TOKEN=$$(infisical login --method=universal-auth --client-id=$$CLIENT_ID --client-secret=$$CLIENT_SECRET --domain=$$DOMAIN --plain --silent) && \
		infisical export --token=$$TOKEN --domain=$$DOMAIN --projectId=$$PROJECT_ID --env=$$ENV --format=dotenv > .env
	@echo "Secrets saved to .env"