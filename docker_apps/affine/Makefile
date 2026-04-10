.PHONY: affine-help affine-up affine-down affine-restart affine-logs affine-status affine-shell affine-clean affine-pull affine-update affine-secrets

AFFINE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

affine-help: ## Show affine commands
	@echo "Affine Commands:"
	@grep -E '^affine-[a-zA-Z_-]+:.*?## .*$$' $(AFFINE_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

affine-up: ## Start affine
	@echo "Starting affine..."
	@cd $(AFFINE_DIR) && docker compose up -d
	@echo "affine is running!"

affine-down: ## Stop affine
	@echo "Stopping affine..."
	@cd $(AFFINE_DIR) && docker compose down
	@echo "affine stopped"

affine-restart: ## Restart affine
	@echo "Restarting affine..."
	@cd $(AFFINE_DIR) && docker compose restart
	@echo "affine restarted"

affine-logs: ## Show affine logs
	@cd $(AFFINE_DIR) && docker compose logs -f

affine-status: ## Show affine status
	@cd $(AFFINE_DIR) && docker compose ps

affine-shell: ## Open shell in affine container
	@cd $(AFFINE_DIR) && docker compose exec affine sh

affine-clean: ## Remove affine containers and volumes
	@echo "WARNING: This will remove all affine data!"
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(AFFINE_DIR) && docker compose down -v; echo "affine cleaned";; \
		*) echo "Canceled";; \
	esac

affine-pull: ## Pull latest affine images
	@echo "Pulling latest affine images..."
	@cd $(AFFINE_DIR) && docker compose pull
	@echo "Pull complete!"

affine-update: ## Update affine to latest version
	@echo "Updating affine..."
	@cd $(AFFINE_DIR) && docker compose pull
	@cd $(AFFINE_DIR) && docker compose up -d
	@echo "affine updated!"

affine-secrets: ## Pull secrets from Infisical and generate .env
	@echo "Fetching affine secrets from Infisical..."
	@if [ ! -f $(AFFINE_DIR).infisical-auth ]; then \
		echo "ERROR: .infisical-auth file not found."; \
		echo "Create it with two lines:"; \
		echo "  CLIENT_ID=your-client-id"; \
		echo "  CLIENT_SECRET=your-client-secret"; \
		exit 1; \
	fi
	@cd $(AFFINE_DIR) && \
		export $$(cat .infisical-auth | xargs) && \
		PROJECT_ID=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['workspaceId'])") && \
		ENV=$$(cat infisical.json | python3 -c "import sys,json; print(json.load(sys.stdin)['defaultEnvironment'])") && \
		TOKEN=$$(infisical login --method=universal-auth --client-id=$$CLIENT_ID --client-secret=$$CLIENT_SECRET --domain=$$DOMAIN --plain --silent) && \
		infisical export --token=$$TOKEN --domain=$$DOMAIN --projectId=$$PROJECT_ID --env=$$ENV --format=dotenv > .env
	@echo "Secrets saved to .env"