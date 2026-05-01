#!/usr/bin/env bash
set -euo pipefail

# Load .env that Komodo wrote into this directory
if [ -f .env ]; then
    set -a
    source .env
    set +a
    echo "Loaded variables from .env"
else
    echo "ERROR: .env not found"
    exit 1
fi

echo "Rendering Pangolin config templates..."

# Required directories
mkdir -p config/traefik/logs
mkdir -p config/crowdsec/db
mkdir -p config/crowdsec/acquis.d
mkdir -p config/letsencrypt

# Sanity check critical variables
for var in DOMAIN DASHBOARD_SUBDOMAIN ADMIN_EMAIL LETSENCRYPT_EMAIL PANGOLIN_SERVER_SECRET CROWDSEC_BOUNCER_KEY; do
    if [ -z "${!var:-}" ]; then
        echo "ERROR: required variable $var is empty"
        exit 1
    fi
done

# Variables to substitute in templates
VARS=(
    DOMAIN
    DASHBOARD_SUBDOMAIN
    LETSENCRYPT_EMAIL
    ADMIN_EMAIL
    ADMIN_PASSWORD
    PANGOLIN_SERVER_SECRET
    CROWDSEC_BOUNCER_KEY
    TZ
)

render() {
    local template="$1"
    local output="$2"
    cp "$template" "$output"
    for var in "${VARS[@]}"; do
        local value="${!var:-}"
        # Escape sed-special chars
        value="${value//\\/\\\\}"
        value="${value//&/\\&}"
        value="${value//|/\\|}"
        sed -i "s|\${${var}}|${value}|g" "$output"
    done
}

render config-templates/config.yml.template config/config.yml
render config-templates/traefik/traefik_config.yml.template config/traefik/traefik_config.yml
render config-templates/traefik/dynamic_config.yml.template config/traefik/dynamic_config.yml

# Static file (no variable substitution needed)
cp config-templates/crowdsec/acquis.yaml config/crowdsec/acquis.d/traefik.yaml

echo "Render complete."