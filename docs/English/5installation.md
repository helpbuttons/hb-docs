# Installation Guide

> **Not a developer?** If you don't have a technical setup, you can request a Network directly at [helpbuttons.org](https://helpbuttons.org) — the team can set it up for you on their server. You can also ask for help in the community [Telegram group](https://t.me/+-_0KxKJ427VkYjU0).

Helpbuttons lives in a single monorepo: [github.com/helpbuttons/helpbuttons](https://github.com/helpbuttons/helpbuttons). It contains the frontend (`web/`), the backend API (`api/`), and the database configuration — all run together via Docker Compose.

---

## Production: run with Docker

This is the recommended way for self-hosting.

### Requirements

- [Docker](https://www.docker.com/) >= 24.0.7
- [docker-compose](https://docs.docker.com/compose/) >= 2.23.3

### Steps

**1. Clone the repository**

```sh
git clone https://github.com/helpbuttons/helpbuttons.git
cd helpbuttons
```

**2. Configure your environment**

```sh
cp env.sample .env
```

Edit `.env` with your settings. The key variables:

```ini
hostName=example.com          # your domain or IP
POSTGRES_PASSWORD=changeme    # set a strong password
smtpHost=                     # SMTP server for email notifications
smtpPort=
smtpUser=
smtpPass=
from=                         # sender email address
```

**3. Generate a JWT secret**

```sh
docker-compose run api yarn cli config:genjwt
```

Copy the generated value and add it to your `.env`:

```ini
jwtSecret=<paste here>
```

**4. Start the application**

```sh
docker-compose up -d
```

**5. Run database migrations**

```sh
docker-compose run api yarn migration:run
```

Open [http://localhost:3000](http://localhost:3000) in your browser. The first time you visit, a setup wizard will guide you through creating the coordinator account and your first Network.

### Upgrade

```sh
docker-compose pull
docker-compose up -d
docker-compose run api yarn migration:run
```

---

## Development setup

For contributing code, choose the mode that matches what you are working on.

### Requirements

- Docker >= 24.0.7 and docker-compose >= 2.23.3
- Node.js >= v20.11.0
- Yarn >= 1.22.21

```sh
git clone https://github.com/helpbuttons/helpbuttons.git
cd helpbuttons
git checkout dev
cp env.sample .env
```

Edit `.env` with:

```ini
hostName=localhost
VERSION=dev
API_URL=http://localhost:3001/
```

Generate and add the JWT secret (same as production step 3 above).

---

### Option A — work on the frontend (API + DB in Docker)

Use this when you are changing React/Next.js code in `web/`.

**1.** In `docker-compose.yml`, uncomment the port exposure for `api`:

```yaml
ports:
  - "3001:3001"
```

**2.** Start the API and database:

```sh
docker-compose up api db redis -d
docker-compose run api yarn migration:run
```

**3.** Run the frontend locally:

```sh
cd web
ln -s ../.env .
yarn
yarn dev
```

Browse to [http://localhost:3000](http://localhost:3000).

---

### Option B — work on the backend (DB in Docker)

Use this when you are changing NestJS code in `api/`.

**1.** In `docker-compose.yml`, uncomment the port exposure for `db`:

```yaml
ports:
  - "5432:5432"
```

**2.** Start only the database:

```sh
docker-compose up db redis -d
```

**3.** Set these additional env vars in `.env`:

```ini
POSTGRES_HOSTNAME=localhost
```

**4.** Run the API locally:

```sh
cd api
mkdir -p uploads && chmod o+w uploads
ln -s ../.env .
yarn
yarn dev
yarn migration:run
```

API runs at [http://localhost:3001](http://localhost:3001).

---

## Troubleshooting

**OpenSSL error on Node.js 17+**

```sh
export NODE_OPTIONS=--openssl-legacy-provider
```

**Backend fails to start due to database errors**

Reset the database volume:

```sh
docker-compose down
rm -rf db/
docker-compose up -d
docker-compose run api yarn migration:run
```

**Drop schema and restart fresh**

```sh
docker-compose exec api yarn schema:drop
docker-compose run api yarn migration:run
```

**Access the database directly**

```sh
docker-compose exec db psql -U postgres hb-db
```

**Database backup and restore**

```sh
# backup
docker-compose exec db pg_dump -U postgres hb-db > dump.sql

# restore
docker exec -i <container_id> psql -U postgres hb-db < dump.sql
```

---

## Preview all UI components

Once running in dev mode, visit [http://localhost:3000/RepositoryPage](http://localhost:3000/RepositoryPage) to browse all styled components and UI elements.

---

### Welcome to the contributors list!

Now head to [Contributing Guide](contributing.md) to understand the git workflow and coding conventions before submitting your first PR.
