# ntfy

This app runs ntfy with PostgreSQL using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed.
2. Start the stack:

   make ntfy-up

3. Create an admin user:

   docker exec -it ntfy ntfy user add --role=admin yourname

## Notes

- The app listens on port `80` inside the container.
- Auth is set to `deny-all` by default — all access requires authentication.
- Attachments are stored in the `ntfy-attachments` volume.
- PostgreSQL data is stored in the `ntfy-postgres-data` volume.
- If you put ntfy behind a reverse proxy, point it to `http://127.0.0.1:${NTFY_PORT}`.
- Secrets are stored in the `.env` file (excluded from git).
