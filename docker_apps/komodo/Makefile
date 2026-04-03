.PHONY: komodo-help komodo-up komodo-down komodo-restart komodo-logs komodo-status komodo-shell komodo-clean komodo-pull komodo-update komodo-secrets

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

komodo-secrets: ## Pull secrets from Infisical and generate .env
	@echo "Fetching komodo secrets from Infisical..."
	@if [ ! -f $(KOMODO_DIR).infisical-auth ]; then \
		echo "ERROR: .infisical-auth file not found."; \
		echo "Create it with two lines:"; \
		echo "  CLIENT_ID=your-client-id"; \
		echo "  CLIENT_SECRET=your-client-secret"; \
		exit 1; \
	fi
	@cd $(KOMODO_DIR) && \
		export $$(cat .infisical-auth | xargs) && \
		PROJECT_ID=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['workspaceId'])") && \
		ENV=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['defaultEnvironment'])") && \
		TOKEN=$$(infisical login --method=universal-auth --client-id=$$CLIENT_ID --client-secret=$$CLIENT_SECRET --domain=$$DOMAIN --plain --silent) && \
		infisical export --token=$$TOKEN --domain=$$DOMAIN --projectId=$$PROJECT_ID --env=$$ENV --format=dotenv > .env
	@echo "Secrets saved to .env"