# ntfy

This app runs ntfy using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Start the stack:

   make ntfy-up

## Notes

- The app listens on port `80` inside the container.
- Cache is stored in the `ntfy-cache` volume mounted at `/var/cache/ntfy`.
- Configuration is stored in the `ntfy-data` volume mounted at `/etc/ntfy`.
- If you put ntfy behind a reverse proxy, point it to `http://127.0.0.1:${NTFY_PORT}`.