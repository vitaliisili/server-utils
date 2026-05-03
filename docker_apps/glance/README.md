# Glance

This app runs [glanceapp/glance](https://github.com/glanceapp/glance) — a self-hosted dashboard that puts feeds, weather, calendars, RSS, monitors, Docker container status, and more on one page, configured via a single `glance.yml`.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Create the persistent config directory on the host (path comes from `GLANCE_CONFIG_PATH`) and seed it with a `glance.yml`:

   ```
   sudo mkdir -p /opt/docker_data/glance/config
   sudo curl -L -o /opt/docker_data/glance/config/glance.yml \
     https://raw.githubusercontent.com/glanceapp/glance/main/docs/glance.yml
   sudo chown -R 1000:1000 /opt/docker_data/glance/config
   ```

3. Start the stack:

   ```
   make glance-up
   ```

4. Edit `glance.yml` in place to add pages, columns, and widgets — see the [configuration docs](https://github.com/glanceapp/glance/blob/main/docs/configuration.md). Glance auto-reloads when the file changes.

## Notes

- Web UI listens on container port `8080`, mapped to `${GLANCE_PORT}` (default `3410`) on the host.
- **Komodo persistence**: the config bind mount uses an **absolute host path** (`GLANCE_CONFIG_PATH`) instead of `./config`. Komodo wipes and recreates the deploy directory on each redeploy, which would destroy a relative bind mount and reset your dashboard. Keep the config under `/opt/docker_data/glance/config` (or wherever you point `GLANCE_CONFIG_PATH`) so it survives redeploys.
- `/var/run/docker.sock` is mounted read-only to enable the `docker-containers` widget. Remove that volume line if you don't want Glance reading container metadata.
- Widget docs: <https://github.com/glanceapp/glance#preconfigured-pages>