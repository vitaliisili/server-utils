# Rancher

This app runs Rancher using Docker Compose. Rancher is a complete container management platform for Kubernetes.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make rancher-up

3. Access the UI at `https://localhost:9443` and log in with the bootstrap password from your `.env`.

## Notes

- Default ports are `9080` (HTTP) and `9443` (HTTPS).
- Runs in **privileged mode** (required — Rancher runs an embedded k3s cluster inside the container).
- Uses `--no-cacerts` for deployment behind a reverse proxy (TLS terminated at the proxy).
- Data is persisted in the `rancher-data` volume at `/var/lib/rancher` (embedded etcd, no external database needed).
- Audit logs are stored in the `rancher-auditlog` volume.
- If you put Rancher behind a reverse proxy, make sure it forwards `X-Forwarded-Proto`, `X-Forwarded-Port`, `X-Forwarded-For`, and supports WebSocket connections.
- Secrets are stored in the `.env` file (excluded from git).