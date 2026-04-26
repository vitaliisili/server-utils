# SnapOtter

This app runs SnapOtter using Docker Compose. SnapOtter is a self-hosted image processing tool with 47 tools, local AI, and pipelines in a single container.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make snapotter-up

## Notes

- Default port is `1349`.
- AI features (background removal, upscaling, OCR) run locally with no external API calls.
- `shm_size` is set to `2gb` for Python ML shared memory requirements.
- Persisted data is stored in `snapotter-data` volume (database, AI models, user files).
- Temporary processing files use the `snapotter-workspace` volume.
- Default credentials are `admin`/`admin` — you will be forced to change the password on first login.
- If you put SnapOtter behind a reverse proxy, point it to `http://127.0.0.1:${SNAPOTTER_PORT}`.
- Secrets are stored in the `.env` file (excluded from git).