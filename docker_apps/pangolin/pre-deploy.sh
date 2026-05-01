#!/usr/bin/env bash
set -euo pipefail

echo "Rendering Pangolin config templates with pure bash..."

# Required directories
mkdir -p config/traefik/logs
mkdir -p config/crowdsec/db
mkdir -p config/crowdsec/acquis.d
mkdir -p config/letsencrypt

# List variables to substitute (must match what's in templates)
VARS=(
    PANGOLIN_HOST
    GERBIL_HOST
    TRAEFIK_HOST
    CROWDSEC_HOST
    PANGOLIN_HTTP_PORT
    PANGOLIN_HTTPS_PORT
    PANGOLIN_WG_PORT
    PANGOLIN_WG_RELAY_PORT
    DOMAIN
    DASHBOARD_SUBDOMAIN
    LETSENCRYPT_EMAIL
    ADMIN_EMAIL
    ADMIN_PASSWORD
    CROWDSEC_BOUNCER_KEY
    TZ
)

render() {
    local template="$1"
    local output="$2"

    cp "$template" "$output"

    for var in "${VARS[@]}"; do
        local value="${!var:-}"
        # Escape sed-special chars: & / \ and the delimiter |
        value="${value//\\/\\\\}"
        value="${value//&/\\&}"
        value="${value//|/\\|}"
        sed -i "s|\${${var}}|${value}|g" "$output"
    done
}

render config-templates/config.yml.template config/config.yml
render config-templates/traefik/traefik_config.yml.template config/traefik/traefik_config.yml
render config-templates/traefik/dynamic_config.yml.template config/traefik/dynamic_config.yml

# Static file
cp config-templates/crowdsec/acquis.yaml config/crowdsec/acquis.yaml

echo "Render complete."