.PHONY: oneuptime-help oneuptime-up oneuptime-down oneuptime-restart oneuptime-logs oneuptime-status oneuptime-shell oneuptime-clean oneuptime-pull oneuptime-update oneuptime-secrets

ONEUPTIME_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

oneuptime-help: ## Show oneuptime commands
	@echo "OneUptime Commands:"
	@grep -E '^oneuptime-[a-zA-Z_-]+:.*?## .*$$' $(ONEUPTIME_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

oneuptime-up: ## Start oneuptime
	@echo "Starting oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose up -d
	@echo "oneuptime is running!"

oneuptime-down: ## Stop oneuptime
	@echo "Stopping oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose down
	@echo "oneuptime stopped"

oneuptime-restart: ## Restart oneuptime
	@echo "Restarting oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose restart
	@echo "oneuptime restarted"

oneuptime-logs: ## Show oneuptime logs
	@cd $(ONEUPTIME_DIR) && docker compose logs -f

oneuptime-status: ## Show oneuptime status
	@cd $(ONEUPTIME_DIR) && docker compose ps

oneuptime-shell: ## Open shell in oneuptime-app container
	@cd $(ONEUPTIME_DIR) && docker compose exec oneuptime-app sh

oneuptime-clean: ## Remove oneuptime containers and volumes
	@echo "WARNING: This will remove all oneuptime data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(ONEUPTIME_DIR) && docker compose down -v; echo "oneuptime cleaned";; \
		*) echo "Canceled";; \
	esac

oneuptime-pull: ## Pull latest oneuptime images
	@echo "Pulling latest oneuptime images..."
	@cd $(ONEUPTIME_DIR) && docker compose pull
	@echo "Pull complete!"

oneuptime-update: ## Update oneuptime to latest version
	@echo "Updating oneuptime..."
	@cd $(ONEUPTIME_DIR) && docker compose pull
	@cd $(ONEUPTIME_DIR) && docker compose up -d
	@echo "oneuptime updated!"

oneuptime-secrets: ## Pull secrets from Infisical and generate .env
	@echo "Fetching oneuptime secrets from Infisical..."
	@if [ ! -f $(ONEUPTIME_DIR).infisical-auth ]; then \
		echo "ERROR: .infisical-auth file not found."; \
		echo "Create it with two lines:"; \
		echo "  CLIENT_ID=your-client-id"; \
		echo "  CLIENT_SECRET=your-client-secret"; \
		exit 1; \
	fi
	@cd $(ONEUPTIME_DIR) && \
		export $$(cat .infisical-auth | xargs) && \
		PROJECT_ID=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['workspaceId'])") && \
		ENV=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['defaultEnvironment'])") && \
		TOKEN=$$(infisical login --method=universal-auth --client-id=$$CLIENT_ID --client-secret=$$CLIENT_SECRET --domain=$$DOMAIN --plain --silent) && \
		infisical export --token=$$TOKEN --domain=$$DOMAIN --projectId=$$PROJECT_ID --env=$$ENV --format=dotenv > .env
	@echo "Secrets saved to .env"