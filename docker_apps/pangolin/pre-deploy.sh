#!/usr/bin/env bash
set -euo pipefail

# Load .env that Komodo wrote into this directory
if [ -f .env ]; then
    set -a
    source .env
    set +a
    echo "Loaded variables from .env"
else
    echo "WARNING: .env not found in current directory"
fi

echo "Rendering Pangolin config templates with pure bash..."

mkdir -p config/traefik/logs
mkdir -p config/crowdsec/db
mkdir -p config/crowdsec/acquis.d
mkdir -p config/letsencrypt

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

# Sanity check — fail loud if a critical variable is empty
for var in DOMAIN PANGOLIN_WG_PORT ADMIN_EMAIL; do
    if [ -z "${!var:-}" ]; then
        echo "ERROR: required variable $var is empty"
        exit 1
    fi
done

render() {
    local template="$1"
    local output="$2"
    cp "$template" "$output"
    for var in "${VARS[@]}"; do
        local value="${!var:-}"
        value="${value//\\/\\\\}"
        value="${value//&/\\&}"
        value="${value//|/\\|}"
        sed -i "s|\${${var}}|${value}|g" "$output"
    done
}

render config-templates/config.yml.template config/config.yml
render config-templates/traefik/traefik_config.yml.template config/traefik/traefik_config.yml
render config-templates/traefik/dynamic_config.yml.template config/traefik/dynamic_config.yml

cp config-templates/crowdsec/acquis.yaml config/crowdsec/acquis.yaml

echo "Render complete."