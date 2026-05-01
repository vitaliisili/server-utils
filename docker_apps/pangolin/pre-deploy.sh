#!/usr/bin/env bash
set -euo pipefail

# Detect available template renderer
if command -v envsubst &> /dev/null; then
    RENDERER="envsubst"
elif command -v python3 &> /dev/null; then
    RENDERER="python3"
else
    echo "ERROR: neither envsubst nor python3 available in this environment"
    exit 1
fi

echo "Using renderer: $RENDERER"
echo "Rendering Pangolin config templates..."

# Make required directories (parents of files we'll write)
mkdir -p config/traefik/logs
mkdir -p config/crowdsec/db
mkdir -p config/crowdsec/acquis.d
mkdir -p config/letsencrypt

render() {
    local template="$1"
    local output="$2"

    if [[ "$RENDERER" == "envsubst" ]]; then
        envsubst < "$template" > "$output"
    else
        python3 -c "
import os, sys
from string import Template
with open('$template') as f:
    t = Template(f.read())
sys.stdout.write(t.safe_substitute(os.environ))
" > "$output"
    fi
}

render config-templates/config.yml.template config/config.yml
render config-templates/traefik/traefik_config.yml.template config/traefik/traefik_config.yml
render config-templates/traefik/dynamic_config.yml.template config/traefik/dynamic_config.yml

# Static file (no variable substitution needed)
cp config-templates/crowdsec/acquis.yaml config/crowdsec/acquis.yaml

echo "Render complete."