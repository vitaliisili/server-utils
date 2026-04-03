# OneUptime

This app runs OneUptime with PostgreSQL, Redis, and ClickHouse using Docker Compose. OneUptime is a self-hosted monitoring platform for uptime, incidents, status pages, and observability.

## Setup

### Option A — Infisical (recommended)

1. Set `workspaceId` in `infisical.json` to your OneUptime project ID.
2. Create `.infisical-auth` with your machine identity credentials:

   CLIENT_ID=your-client-id
   CLIENT_SECRET=your-client-secret
   DOMAIN=https://your-infisical-domain.com

3. Pull secrets and start:

   make oneuptime-secrets
   make oneuptime-up

> `.infisical-auth` is excluded from rsync and git — it stays local only.

### Option B — Manual

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make oneuptime-up

## Services

- **oneuptime-app** — Web UI and API, accessible on the configured port.
- **oneuptime-postgres** — PostgreSQL database for application state.
- **oneuptime-redis** — Redis for caching and queues.
- **oneuptime-clickhouse** — ClickHouse for telemetry and log storage.

## Notes

- Default port is `3210`.
- Persisted data is stored in `./data/postgres`, `./data/redis`, and `./data/clickhouse`.