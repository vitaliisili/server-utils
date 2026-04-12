# Dockhand

This app runs Dockhand with PostgreSQL using Docker Compose. Dockhand is a Docker container management tool.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make dockhand-up

## Notes

- Default port is `3100` (mapped from container port `3000`).
- Docker socket is mounted for container management.
- Persisted data is stored in `dockhand-data` and `dockhand-postgres-data` volumes.
- If you put Dockhand behind a reverse proxy, point it to `http://127.0.0.1:${DOCKHAND_PORT}`.
- Secrets are stored in the `.env` file (excluded from git).