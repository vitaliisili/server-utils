# Nexus 3

This app runs Sonatype Nexus Repository Manager 3 using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and adjust values.
2. Start the stack:

   make nexus-up

## Reverse Proxy (CloudPanel)

- CloudPanel terminates TLS, Nexus runs HTTP internally.
- Point the proxy to `http://127.0.0.1:${NEXUS_PORT}`.

## First login

The initial admin password is stored at `/nexus-data/admin.password` inside the
container. Example:

```bash
docker exec nexus cat /nexus-data/admin.password
```
