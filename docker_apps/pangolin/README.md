# Pangolin

This app runs [Pangolin](https://github.com/fosrl/pangolin) — a self-hosted tunneling reverse-proxy stack with WireGuard, Traefik, and CrowdSec — using Docker Compose.

The stack bundles four services:

- **pangolin** — the management app and dashboard (`fosrl/pangolin`)
- **gerbil** — WireGuard relay; owns the public ports
- **traefik** — reverse proxy (shares gerbil's network namespace via `network_mode: service:gerbil`)
- **crowdsec** — IDS/WAF that reads Traefik logs

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Prepare the bind-mounted `config/` directory next to `docker-compose.yml`. At minimum you need `config/traefik/traefik_config.yml`; see the [Pangolin install guide](https://docs.fossorial.io/) for the recommended starting templates.
3. Open ports `80`, `443`, `51820/udp`, and `21820/udp` on your firewall and DNS.
4. Start the stack:

   make pangolin-up

## Notes

- `config/` is a **bind mount**, not a named volume — required so Traefik and CrowdSec can read user-edited config files. It is preserved across `pangolin-clean`.
- Subdirectories with runtime state that should NOT be wiped or copied around carelessly: `config/letsencrypt/` (Let's Encrypt certs) and `config/crowdsec/db/` (CrowdSec SQLite). Consider adding them to your rsync excludes if you push this app to a remote server.
- Traefik routes traffic through gerbil's network namespace, so its container has no separate IP — port mappings are declared on the `gerbil` service.
- `gerbil` requires `NET_ADMIN` and `SYS_MODULE` capabilities for WireGuard.
- Since Pangolin **is** a Traefik distribution, you do not put it behind another reverse proxy — it replaces one.