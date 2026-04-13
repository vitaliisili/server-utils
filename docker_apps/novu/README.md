# Novu

This app runs Novu with MongoDB and Redis using Docker Compose. Novu is an open-source notification infrastructure for developers.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Generate secrets:

   openssl rand -hex 32    # for JWT_SECRET and NOVU_SECRET_KEY
   openssl rand -hex 16    # for STORE_ENCRYPTION_KEY (must be 32 chars)

3. Start the stack:

   make novu-up

## Services

- **novu-api** — REST API server.
- **novu-worker** — Background job processor (digests, broadcasts).
- **novu-ws** — WebSocket server for real-time notifications.
- **novu-dashboard** — Web UI.
- **novu-mongodb** — MongoDB database.
- **novu-redis** — Redis for cache and job queue.

## Notes

- Dashboard is on port `4400`, API on `3400`, WebSocket on `3402`.
- Novu exposes 3 ports that need reverse proxy entries: dashboard, API, and WebSocket.
- `STORE_ENCRYPTION_KEY` must be exactly 32 characters.
- Secrets are stored in the `.env` file (excluded from git).