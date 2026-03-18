# Linkwarden

This app runs Linkwarden with a Postgres database and Meilisearch using Docker Compose.

## Setup

1. Copy `.env-example` to `.env` and fill in values.
2. Start the stack:

   make linkwarden-up

## Notes

- The database container is named `linkwarden-postgres`.
- Meilisearch is used for full-text search of bookmarks.
- Persisted data is stored in `./data/postgres`, `./data/meili`, and `./data/linkwarden`.