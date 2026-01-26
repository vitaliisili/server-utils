.PHONY: help push pull sync dry-run check-remote server-status server-shell push-and-up

# Load environment variables from .env file
ifneq (,$(wildcard .env))
    include .env
    export
endif

# Remote server configuration - EDIT THESE IF ENV FILE IS NOT PRESENT
REMOTE_USER ?= ubuntu
REMOTE_HOST ?= your-server-ip
REMOTE_PATH ?= /home/ubuntu/docker_apps
SSH_KEY ?= ~/.ssh/id_rsa

# Local path to sync
LOCAL_PATH := ./docker_apps

# Rsync options
RSYNC_OPTS := -avz --progress --delete
RSYNC_EXCLUDE := --exclude='backups/' --exclude='*.log' --exclude='.git/' --exclude='*.swp' --exclude='.DS_Store' --exclude='__pycache__/' --exclude='app_example/'
SSH_OPTS := -e "ssh -i $(SSH_KEY)"

help: ## Show deployment commands
	@echo "=== Deployment Commands ==="
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

push: ## Push docker_apps to remote server (includes .env files)
	@echo "Pushing $(LOCAL_PATH) to $(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_PATH)"
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "mkdir -p $(REMOTE_PATH)"
	@rsync $(RSYNC_OPTS) $(RSYNC_EXCLUDE) $(SSH_OPTS) \
		$(LOCAL_PATH)/ $(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_PATH)/
	@echo "Push complete!"

pull: ## Pull docker_apps from remote server to local
	@echo "Pulling from remote to $(LOCAL_PATH)"
	@rsync $(RSYNC_OPTS) $(RSYNC_EXCLUDE) $(SSH_OPTS) \
		$(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_PATH)/ $(LOCAL_PATH)/
	@echo "Pull complete!"

sync: push ## Alias for push

dry-run: ## Show what would be pushed (without making changes)
	@echo "Dry run - showing what would be synced:"
	@rsync $(RSYNC_OPTS) $(RSYNC_EXCLUDE) --dry-run $(SSH_OPTS) \
		$(LOCAL_PATH)/ $(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_PATH)/

check-remote: ## List files on remote server
	@echo "Files on remote server:"
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "ls -lah $(REMOTE_PATH) && echo '' && find $(REMOTE_PATH) -maxdepth 2 -type f -name '.env'"

server-status: ## Check Docker containers on remote server
	@echo "Docker status on remote:"
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && docker ps -a"

server-shell: ## SSH into remote server
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST)

push-and-up: push ## Push and start all services on remote
	@echo "Starting services on remote..."
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && make all-up"

push-and-restart: push ## Push and restart all services on remote
	@echo "Restarting services on remote..."
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && make all-restart"

remote-all-down: ## Stop all services on remote
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && make all-down"

remote-all-status: ## Show status of all services on remote
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && make all-status"