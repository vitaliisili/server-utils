# Homarr

This app runs Homarr using Docker Compose. Homarr is a modern dashboard for your server with 40+ integrations.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Generate an encryption key: `openssl rand -hex 32`
3. Start the stack:

   make homarr-up

## Notes

- Default port is `7575`.
- On first launch, you will be prompted to create an admin account.
- Docker socket is mounted for Docker integration (container status, management).
- Persisted data is stored in the `homarr-appdata` volume.
- If you put Homarr behind a reverse proxy, point it to `http://127.0.0.1:${HOMARR_PORT}`.
- Secrets are stored in the `.env` file (excluded from git).