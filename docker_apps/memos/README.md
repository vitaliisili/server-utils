# Memos

This app runs Memos using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Start the stack:

   make memos-up

## Notes

- The app listens on port `5230` inside the container.
- Persisted data is stored in the `memos-data` volume mounted at `/var/opt/memos`.
- If you put Memos behind a reverse proxy, point it to `http://127.0.0.1:${MEMOS_PORT}`.
