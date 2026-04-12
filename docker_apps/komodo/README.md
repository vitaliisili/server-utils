# Komodo

This app runs Komodo with MongoDB using Docker Compose. Komodo is a self-hosted server and deployment management platform.

## Setup

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