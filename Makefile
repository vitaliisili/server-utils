.PHONY: help push pull sync dry-run check-remote server-status server-shell remote-all-down remote-all-status

# Load environment variables from .env file
ifneq (,$(wildcard .env))
    include .env
    export
endif

# Include all app Makefiles
include docker_apps/drone/Makefile
include docker_apps/jenkins/Makefile
include docker_apps/n8n/Makefile
include docker_apps/portainer/Makefile
include docker_apps/rocketchat/Makefile
include docker_apps/nextcloud/Makefile
include docker_apps/linkwarden/Makefile
include docker_apps/komodo/Makefile
include docker_apps/oneuptime/Makefile

# Remote server configuration - EDIT THESE IF ENV FILE IS NOT PRESENT
REMOTE_USER ?= ubuntu
REMOTE_HOST ?= your-server-ip
SSH_KEY ?= ~/.ssh/id_rsa

# Derive home directory from user (root uses /root, others use /home/<user>)
ifeq ($(REMOTE_USER),root)
    REMOTE_HOME ?= /root
else
    REMOTE_HOME ?= /home/$(REMOTE_USER)
endif
REMOTE_PATH ?= $(REMOTE_HOME)/docker_apps

# Local path to sync
LOCAL_PATH := ./docker_apps

# Rsync options
RSYNC_OPTS := -avz --progress --delete
RSYNC_EXCLUDE := --exclude='data/' --exclude='backups/' --exclude='*.log' --exclude='.git/' --exclude='*.swp' --exclude='.DS_Store' --exclude='__pycache__/' --exclude='app_example/' --exclude='.infisical-auth'
SSH_OPTS := -e "ssh -i $(SSH_KEY)"

help: ## Show all available commands
	@echo "=== Deployment Commands ==="
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-25s %s\n", $$1, $$2}'
	@echo ""
	@echo "=== App Commands ==="
	@$(MAKE) -s drone-help
	@echo ""
	@$(MAKE) -s jenkins-help
	@echo ""
	@$(MAKE) -s n8n-help
	@echo ""
	@$(MAKE) -s portainer-help
	@echo ""
	@$(MAKE) -s rocketchat-help
	@echo ""
	@$(MAKE) -s nextcloud-help
	@echo ""
	@$(MAKE) -s linkwarden-help
	@echo ""
	@$(MAKE) -s komodo-help
	@echo ""
	@$(MAKE) -s oneuptime-help

push: ## Push docker_apps to remote server
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

dry-run: ## Show what would be pushed without making changes
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

remote-all-down: ## Stop all services on remote
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && make all-down"

remote-all-status: ## Show status of all services on remote
	@ssh -i $(SSH_KEY) $(REMOTE_USER)@$(REMOTE_HOST) "cd $(REMOTE_PATH) && make all-status"