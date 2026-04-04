# Trilium

This app runs Trilium Notes using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Start the stack:

   make trilium-up

## Notes

- The app listens on port `8080` inside the container, mapped to `${TRILIUM_PORT}` (default `8686`) on the host.
- Persisted data is stored in the `trilium-data` volume mounted at `/home/node/trilium-data`.
- If you put Trilium behind a reverse proxy, point it to `http://127.0.0.1:${TRILIUM_PORT}`.
