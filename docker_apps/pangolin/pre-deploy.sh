#!/usr/bin/env bash
set -euo pipefail

# Komodo runs this from the run_directory (docker_apps/pangolin)
# Env vars from Komodo's "Environment" field are already in our shell

echo "Rendering Pangolin config templates..."

# Make required directories
mkdir -p config/traefik/logs
mkdir -p config/crowdsec/db
mkdir -p config/crowdsec/acquis.d
mkdir -p config/letsencrypt

# Render templates
envsubst < config-templates/config.yml.template > config/config.yml
envsubst < config-templates/traefik/traefik_config.yml.template > config/traefik/traefik_config.yml
envsubst < config-templates/traefik/dynamic_config.yml.template > config/traefik/dynamic_config.yml

# Static file (no vars)
cp config-templates/crowdsec/acquis.yaml config/crowdsec/acquis.yaml

echo "Render complete."