#!/usr/bin/env bash
set -euo pipefail

# Load .env Komodo wrote
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

if [ -z "${CROWDSEC_BOUNCER_KEY:-}" ]; then
    echo "ERROR: CROWDSEC_BOUNCER_KEY not set"
    exit 1
fi

CONTAINER="crowdsec"
BOUNCER_NAME="traefik-bouncer"

echo "Waiting for CrowdSec container to be ready..."
for i in {1..30}; do
    if docker exec "$CONTAINER" cscli version >/dev/null 2>&1; then
        echo "CrowdSec is ready."
        break
    fi
    sleep 2
done

# Check if bouncer exists
if docker exec "$CONTAINER" cscli bouncers list -o json 2>/dev/null | grep -q "\"name\":\"$BOUNCER_NAME\""; then
    echo "Bouncer '$BOUNCER_NAME' already registered. Deleting to re-register with current key..."
    docker exec "$CONTAINER" cscli bouncers delete "$BOUNCER_NAME"
fi

echo "Registering bouncer '$BOUNCER_NAME' with our key..."
docker exec "$CONTAINER" cscli bouncers add "$BOUNCER_NAME" --key "$CROWDSEC_BOUNCER_KEY"

echo "Restarting Traefik to pick up new bouncer key..."
docker restart traefik

echo "Post-deploy complete."