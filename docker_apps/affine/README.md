# Affine

This app runs Affine with PostgreSQL and Redis using Docker Compose.

## Setup

### Option A — Infisical (recommended)

1. Set `workspaceId` in `infisical.json` to your Affine project ID.
2. Create `.infisical-auth` with your machine identity credentials:

   CLIENT_ID=your-client-id
   CLIENT_SECRET=your-client-secret
   DOMAIN=https://your-infisical-domain.com

3. Pull secrets and start:

   make affine-secrets
   make affine-up

> `.infisical-auth` is excluded from rsync and git — it stays local only.

### Option B — Manual

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make affine-up

## Services

- **affine** — Web UI and API, accessible on the configured port.
- **affine-migration** — Runs database migrations before the main service starts.
- **affine-postgres** — PostgreSQL database with pgvector extension.
- **affine-redis** — Redis for caching and pub/sub.

## Notes

- Default port is `3010`.
- Persisted data is stored in named volumes: `affine-storage`, `affine-config`, `affine-postgres-data`, `affine-redis-data`.
- If you put Affine behind a reverse proxy, point it to `http://127.0.0.1:${AFFINE_PORT}`.
- Secrets are managed via Infisical (see `infisical.json`).