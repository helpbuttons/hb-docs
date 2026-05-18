# Guía de instalación

> **¿No eres desarrollador/a?** Si no tienes un entorno técnico, puedes solicitar una Red directamente en [helpbuttons.org](https://helpbuttons.org) — el equipo puede configurártela en su servidor. También puedes pedir ayuda en el [grupo de Telegram](https://t.me/+-_0KxKJ427VkYjU0) de la comunidad.

Helpbuttons vive en un único monorepo: [github.com/helpbuttons/helpbuttons](https://github.com/helpbuttons/helpbuttons). Contiene el frontend (`web/`), la API backend (`api/`) y la configuración de la base de datos — todo se ejecuta junto mediante Docker Compose.

---

## Producción: ejecutar con Docker

Esta es la forma recomendada para auto-hospedaje.

### Requisitos

- [Docker](https://www.docker.com/) >= 24.0.7
- [docker-compose](https://docs.docker.com/compose/) >= 2.23.3

### Pasos

**1. Clonar el repositorio**

```sh
git clone https://github.com/helpbuttons/helpbuttons.git
cd helpbuttons
```

**2. Configurar el entorno**

```sh
cp env.sample .env
```

Edita `.env` con tu configuración. Las variables clave:

```ini
hostName=ejemplo.com          # tu dominio o IP
POSTGRES_PASSWORD=changeme    # pon una contraseña segura
smtpHost=                     # servidor SMTP para notificaciones de email
smtpPort=
smtpUser=
smtpPass=
from=                         # dirección de email del remitente
```

**3. Generar el secreto JWT**

```sh
docker-compose run api yarn cli config:genjwt
```

Copia el valor generado y añádelo a tu `.env`:

```ini
jwtSecret=<pega aquí>
```

**4. Iniciar la aplicación**

```sh
docker-compose up -d
```

**5. Ejecutar las migraciones de base de datos**

```sh
docker-compose run api yarn migration:run
```

Abre [http://localhost:3000](http://localhost:3000) en tu navegador. La primera vez que visites, un asistente de configuración te guiará para crear la cuenta de coordinador y tu primera Red.

### Actualizar

```sh
docker-compose pull
docker-compose up -d
docker-compose run api yarn migration:run
```

---

## Configuración para desarrollo

Para contribuir con código, elige el modo que se adapte a lo que vas a trabajar.

### Requisitos

- Docker >= 24.0.7 y docker-compose >= 2.23.3
- Node.js >= v20.11.0
- Yarn >= 1.22.21

```sh
git clone https://github.com/helpbuttons/helpbuttons.git
cd helpbuttons
git checkout dev
cp env.sample .env
```

Edita `.env` con:

```ini
hostName=localhost
VERSION=dev
API_URL=http://localhost:3001/
```

Genera y añade el secreto JWT (igual que el paso 3 de producción).

---

### Opción A — trabajar en el frontend (API + BD en Docker)

Usa esto cuando estés cambiando código React/Next.js en `web/`.

**1.** En `docker-compose.yml`, descomenta la exposición de puerto para `api`:

```yaml
ports:
  - "3001:3001"
```

**2.** Inicia la API y la base de datos:

```sh
docker-compose up api db redis -d
docker-compose run api yarn migration:run
```

**3.** Ejecuta el frontend localmente:

```sh
cd web
ln -s ../.env .
yarn
yarn dev
```

Navega a [http://localhost:3000](http://localhost:3000).

---

### Opción B — trabajar en el backend (BD en Docker)

Usa esto cuando estés cambiando código NestJS en `api/`.

**1.** En `docker-compose.yml`, descomenta la exposición de puerto para `db`:

```yaml
ports:
  - "5432:5432"
```

**2.** Inicia solo la base de datos:

```sh
docker-compose up db redis -d
```

**3.** Añade en `.env`:

```ini
POSTGRES_HOSTNAME=localhost
```

**4.** Ejecuta la API localmente:

```sh
cd api
mkdir -p uploads && chmod o+w uploads
ln -s ../.env .
yarn
yarn dev
yarn migration:run
```

La API se ejecuta en [http://localhost:3001](http://localhost:3001).

---

## Resolución de problemas

**Error de OpenSSL en Node.js 17+**

```sh
export NODE_OPTIONS=--openssl-legacy-provider
```

**El backend no arranca por errores de base de datos**

Reinicia el volumen de la base de datos:

```sh
docker-compose down
rm -rf db/
docker-compose up -d
docker-compose run api yarn migration:run
```

**Eliminar el esquema y empezar de cero**

```sh
docker-compose exec api yarn schema:drop
docker-compose run api yarn migration:run
```

**Acceder a la base de datos directamente**

```sh
docker-compose exec db psql -U postgres hb-db
```

**Copia de seguridad y restauración**

```sh
# backup
docker-compose exec db pg_dump -U postgres hb-db > dump.sql

# restaurar
docker exec -i <container_id> psql -U postgres hb-db < dump.sql
```

---

¡Bienvenida a la lista de contribuidores! Consulta [Normas de código](normas-codigo.md) antes de enviar tu primer PR.
