.PHONY: pangolin-help pangolin-render pangolin-up pangolin-down pangolin-restart pangolin-logs pangolin-status pangolin-shell pangolin-clean pangolin-pull pangolin-update

PANGOLIN_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

pangolin-help: ## Show Pangolin commands
	@echo "Pangolin Commands:"
	@grep -E '^pangolin-[a-zA-Z_-]+:.*?## .*$$' $(PANGOLIN_DIR)Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'

pangolin-render: ## Render config templates from .env into config/
	@echo "Rendering config templates..."
	@cd $(PANGOLIN_DIR) && set -a && . ./.env && set +a && \
		mkdir -p config/traefik/logs config/crowdsec/db config/crowdsec/acquis.d config/letsencrypt && \
		envsubst < config-templates/config.yml.template > config/config.yml && \
		envsubst < config-templates/traefik/traefik_config.yml.template > config/traefik/traefik_config.yml && \
		envsubst < config-templates/traefik/dynamic_config.yml.template > config/traefik/dynamic_config.yml && \
		cp config-templates/crowdsec/acquis.yaml config/crowdsec/acquis.yaml
	@echo "Config rendered to config/"

pangolin-up: pangolin-render ## Render templates and start Pangolin
	@echo "Starting Pangolin..."
	@cd $(PANGOLIN_DIR) && docker compose up -d
	@echo "Pangolin is running!"

pangolin-down: ## Stop Pangolin
	@echo "Stopping Pangolin..."
	@cd $(PANGOLIN_DIR) && docker compose down
	@echo "Pangolin stopped"

pangolin-restart: ## Restart Pangolin
	@echo "Restarting Pangolin..."
	@cd $(PANGOLIN_DIR) && docker compose restart
	@echo "Pangolin restarted"

pangolin-logs: ## Show Pangolin logs
	@cd $(PANGOLIN_DIR) && docker compose logs -f

pangolin-status: ## Show Pangolin status
	@cd $(PANGOLIN_DIR) && docker compose ps

pangolin-shell: ## Open shell in Pangolin app container
	@cd $(PANGOLIN_DIR) && docker compose exec pangolin sh

pangolin-clean: ## Remove containers, volumes, AND generated config/
	@echo "WARNING: This removes containers, volumes, AND generated config/."
	@echo "The .env and config-templates/ are preserved."
	@printf "Are you sure? [y/N] "; \
	read -r reply; \
	case "$$reply" in \
		[Yy]*) cd $(PANGOLIN_DIR) && docker compose down -v && rm -rf config/; echo "Pangolin cleaned";; \
		*) echo "Canceled";; \
	esac

pangolin-pull: ## Pull latest Pangolin images
	@echo "Pulling latest Pangolin images..."
	@cd $(PANGOLIN_DIR) && docker compose pull
	@echo "Pull complete!"

pangolin-update: pangolin-render ## Render templates, pull images, and restart
	@echo "Updating Pangolin..."
	@cd $(PANGOLIN_DIR) && docker compose pull
	@cd $(PANGOLIN_DIR) && docker compose up -d
	@echo "Pangolin updated!"