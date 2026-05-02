# Homepage

This app runs [gethomepage/homepage](https://gethomepage.dev/) — a modern, fully static, fast, and YAML-configured self-hosted dashboard with 100+ service integrations and Docker auto-discovery.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Create the persistent config directory on the host (path comes from `HOMEPAGE_CONFIG_PATH`):

   ```
   sudo mkdir -p /opt/docker_data/homepage/config
   sudo chown -R 1000:1000 /opt/docker_data/homepage/config
   ```

3. Start the stack:

   ```
   make homepage-up
   ```

4. On first start, Homepage writes default YAML files into the config directory (e.g. `services.yaml`, `widgets.yaml`, `settings.yaml`, `bookmarks.yaml`, `docker.yaml`). Edit them in place to configure the dashboard — changes are picked up automatically.

## Notes

- Web UI listens on container port `3000`, mapped to `${HOMEPAGE_PORT}` (default `3310`) on the host.
- **Komodo persistence**: the config bind mount uses an **absolute host path** (`HOMEPAGE_CONFIG_PATH`) instead of `./config`. Komodo wipes and recreates the deploy directory on each redeploy, which would destroy a relative bind mount and reset the dashboard. Keeping the config under `/opt/docker_data/homepage/config` (or wherever you point `HOMEPAGE_CONFIG_PATH`) keeps it safe across redeploys.
- `/var/run/docker.sock` is mounted read-only to enable Docker integrations (auto-discovery of containers via labels). Remove that volume line if you don't want Homepage talking to the Docker socket.
- `HOMEPAGE_ALLOWED_HOSTS` is required since v1.0. `*` disables the check; for production set it to your real hostname(s).
- See the [docs](https://gethomepage.dev/configs/) for the full configuration reference.