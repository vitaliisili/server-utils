# DDNS Updater

This app runs [qdm12/ddns-updater](https://github.com/qdm12/ddns-updater) using Docker Compose. It periodically checks the public IP and updates DNS records on supported providers (Cloudflare, Namecheap, Google Domains, GoDaddy, etc.).

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Create the provider configuration at `data/config.json` inside the named volume (see [provider docs](https://github.com/qdm12/ddns-updater#configuration)).
3. Start the stack:

   make ddns-updater-up

## Notes

- The web UI listens on port `8000` inside the container, mapped to `${DDNS_UPDATER_PORT}` on the host.
- Persisted data is stored in the `ddns-updater-data` volume mounted at `/updater/data`.
- `PERIOD` controls how often the IP is checked (e.g. `5m`, `1h`).
- If you put DDNS Updater behind a reverse proxy, point it to `http://127.0.0.1:${DDNS_UPDATER_PORT}`.