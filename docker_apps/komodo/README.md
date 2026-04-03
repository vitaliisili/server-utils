# Komodo

This app runs Komodo with MongoDB using Docker Compose. Komodo is a self-hosted server and deployment management platform.

## Setup

### Option A — Infisical (recommended)

1. Set `workspaceId` in `infisical.json` to your Komodo project ID.
2. Create `.infisical-auth` with your machine identity credentials:

   CLIENT_ID=your-client-id
   CLIENT_SECRET=your-client-secret
   DOMAIN=https://your-infisical-domain.com

3. Pull secrets and start:

   make komodo-secrets
   make komodo-up

> `.infisical-auth` is excluded from rsync and git — it stays local only.

### Option B — Manual

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make komodo-up

## Services

- **komodo-core** — Web UI and API, accessible on the configured port.
- **komodo-periphery** — Local agent that executes operations on this server via Docker.
- **komodo-mongo** — MongoDB database for core state.

## Notes

- Default port is `9120`.
- `KOMODO_PASSKEY` must match between core and periphery.
- Periphery mounts the Docker socket to manage containers on this host.
- Persisted data is stored in `./data/mongo`, `./data/backups`, and `./data/periphery`.