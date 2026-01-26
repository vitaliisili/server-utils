# Infisical

This app runs Infisical with Postgres and Redis using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make infisical-up

## Notes

- The backend is available on port `3331`.
- The database container is `vs-infisical-db` and Redis is `vs-infisical-redis`.
- Persisted data is stored in Docker volumes: `vs_infisical_pg_data` and `vs_infisical_redis_data`.
