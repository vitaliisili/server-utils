# Docker Stacks

Curated, multi-app Docker Compose stacks — pre-wired bundles of related services that work together out of the box. Unlike [`docker_apps/`](../docker_apps), where each folder runs a single application, a stack combines several containers (media servers, *arr automation, utilities, etc.) in one compose file so you can spin up an entire workflow with a single command.

## Available Stacks

| Stack | Description | Default Port(s) |
|-------|-------------|-----------------|
| _Coming soon_ | | |

<!--
Examples of stacks planned for this folder:

| [media-stack-plex](media-stack-plex)       | Plex + Sonarr + Radarr + Prowlarr + qBittorrent + Bazarr | 32400, 8989, 7878, ... |
| [media-stack-jellyfin](media-stack-jellyfin) | Jellyfin + Sonarr + Radarr + Prowlarr + qBittorrent + Bazarr | 8096, 8989, 7878, ... |
-->

## Stack Layout

Each stack lives in its own subdirectory and follows the same conventions as `docker_apps/`:

```
docker_stacks/
├── <stack-name>/
│   ├── docker-compose.yml  # All services in one file
│   ├── .env-example        # Template for environment variables
│   ├── .env                # Actual secrets (gitignored)
│   ├── Makefile            # Stack-specific commands (up/down/logs/...)
│   └── README.md           # Setup, included services, and notes
└── ...
```

## Per-Stack Commands

Like single apps, every stack exposes a uniform set of Make commands:

```
make <stack>-up         # Start all services in the stack
make <stack>-down       # Stop all services
make <stack>-restart    # Restart the stack
make <stack>-logs       # Tail logs from all services
make <stack>-status     # Show status of all containers
make <stack>-pull       # Pull latest images
make <stack>-update     # Pull and restart
make <stack>-clean      # Remove containers and volumes (with confirmation)
```

## Adding a New Stack

1. Create `docker_stacks/<stack>/` with `docker-compose.yml`, `Makefile`, `.env-example`, and `README.md`.
2. Use a shared network across services in the stack (e.g. `<stack>-network`) so they can talk to each other.
3. Prefix container and volume names with the stack name to avoid collisions with other stacks (e.g. `media-stack-plex-sonarr`, `media-stack-plex-config`).
4. Document every included service, its purpose, and its default port in the stack's `README.md`.
5. Add `include docker_stacks/<stack>/Makefile` and a help entry to the root `Makefile`.
6. Add the stack to the table above and to the root `README.md`.