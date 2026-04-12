# OneUptime

This app runs OneUptime with PostgreSQL, Redis, and ClickHouse using Docker Compose. OneUptime is a self-hosted monitoring platform for uptime, incidents, status pages, and observability.

## Setup

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