# Anchor

This app runs [Anchor](https://github.com/ZhFahim/anchor) — a self-hosted documents and notes app with embedded PostgreSQL, JWT auth, and optional OIDC.

## Setup

1. Copy `.env-example` to `.env` and adjust values if needed (especially `ANCHOR_APP_URL` if you put it behind a reverse proxy, and `ANCHOR_USER_SIGNUP` if you want to allow registrations).
2. Start the stack:

   ```
   make anchor-up
   ```

3. Open `http://localhost:3510` (or whatever `ANCHOR_PORT` points to) and create the first account.

## Notes

- Web UI listens on container port `3000`, mapped to `${ANCHOR_PORT}` (default `3510`) on the host.
- All persistent state — embedded PostgreSQL database, user notes, attachments, generated `JWT_SECRET`, and config — lives in the `anchor-data` named volume mounted at `/data`. Named volumes survive Komodo redeploys, so no absolute host path is needed here.
- `ANCHOR_USER_SIGNUP` defaults to `disabled` to avoid accidentally opening signup on a public deployment. Set it to `enabled` (open) or `review` (admin approval) when you want users to register.
- `ANCHOR_JWT_SECRET` is auto-generated on first boot if left empty; set it explicitly only if you want a known value (e.g. for backups/restore across hosts).
- For OIDC / external Postgres / advanced options, see the upstream env-var table: <https://github.com/ZhFahim/anchor#configuration>
- `make anchor-clean` removes the named volume — that wipes **all** notes, attachments, and the database. Back up `/var/lib/docker/volumes/anchor-data/` first.