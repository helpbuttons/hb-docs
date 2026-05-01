# Arquitectura del software

## Repositorio

El proyecto vive en un único monorepo:

- **Código**: [github.com/helpbuttons/helpbuttons](https://github.com/helpbuttons/helpbuttons)
- **Documentación** (este repo): [github.com/helpbuttons/hb-docs](https://github.com/helpbuttons/hb-docs)

El desarrollo activo ocurre en la rama `dev`. Los pull requests deben apuntar a `dev`. La rama `main` sigue los lanzamientos de producción.

---

## Tecnologías

Las tecnologías se eligieron siguiendo tres principios: **software abierto**, **mobile-first** y **posicionamiento GIS**. También se priorizaron herramientas con buena adopción comunitaria y documentación.

### Frontend (`web/`)

| Tecnología | Rol |
|---|---|
| [TypeScript](https://www.typescriptlang.org/) | JavaScript tipado en toda la pila |
| [Next.js](https://nextjs.org/) | Framework React, enrutamiento por archivos, SSR |
| [React](https://reactjs.org/) | UI basada en componentes |
| [Pigeon Maps](https://pigeon-maps.js.org/) | Mapas interactivos (ligero, sin dependencias externas) |
| [RxJS](https://rxjs.dev/) | Gestión reactiva del estado |
| [react-icons](https://react-icons.github.io/react-icons/) | Iconos (set Bootstrap) |

### Backend (`api/`)

| Tecnología | Rol |
|---|---|
| [Node.js](https://nodejs.org/) | Runtime de JavaScript |
| [NestJS](https://nestjs.com/) | Framework backend modular (OOP + DI) |
| [TypeORM](https://typeorm.io/) | ORM de base de datos con soporte de migraciones |
| [PostgreSQL](https://www.postgresql.org/) | Base de datos relacional |
| [PostGIS](https://postgis.net/) | Extensión espacial para consultas geográficas |
| [H3](https://h3geo.org/) | Indexación espacial hexagonal de Uber |
| [Redis](https://redis.io/) | Caché y cola |
| Handlebars | Plantillas de email |

---

## Estructura del monorepo

```
helpbuttons/
├── api/                        # Backend NestJS
│   ├── src/
│   │   ├── app/                # Bootstrap, config global, validadores
│   │   ├── config/             # Módulo de configuración
│   │   ├── data/
│   │   │   ├── migrations/     # Migraciones TypeORM (ejecutar en orden)
│   │   │   └── seed/           # Seeders y datos de ejemplo
│   │   └── modules/            # Módulos de funcionalidades
│   ├── locales/                # Strings i18n de la API (en, es, cat, eu, pt)
│   └── Dockerfile
│
├── web/                        # Frontend Next.js
│   ├── public/
│   │   ├── assets/             # Imágenes, SVGs, assets de enrutamiento
│   │   └── locales/            # Strings i18n del frontend (en, es, cat, eu, pt)
│   └── src/
│       ├── components/         # Componentes UI compuestos
│       ├── elements/           # Elementos UI atómicos (botones, formularios...)
│       ├── layouts/            # Wrappers de layout de página
│       ├── pages/              # Rutas Next.js
│       ├── services/           # Servicios cliente de la API por dominio
│       ├── shared/             # DTOs, entidades y tipos compartidos
│       ├── state/              # Estado global de la app (basado en RxJS)
│       └── store/              # Event store
│
├── plugins/                    # Sistema de plugins
├── postgres/                   # Imagen Docker personalizada de PostgreSQL
├── docker-compose.yml
├── env.sample
└── README.md
```

---

## Módulos del backend (`api/src/modules/`)

Cada módulo gestiona su entidad, DTO, servicio, controlador y cualquier guard o estrategia relacionada.

| Módulo | Responsabilidad |
|---|---|
| `auth/` | Autenticación JWT, guards, estrategias de login |
| `button/` | Entidad Button — publicaciones geolocalizadas |
| `network/` | Redes — contenedores comunitarios |
| `user/` | Perfiles de usuario |
| `user-credential/` | Gestión de contraseñas y credenciales |
| `post/` | Comentarios y respuestas en botones |
| `group-message/` | Mensajería grupal entre usuarios |
| `activity/` | Feed de actividad |
| `tag/` | Creación y suscripción a etiquetas |
| `geo/` | Geocodificación (Komoot / Pelias / modo simulación) |
| `invite/` | Sistema de enlaces de invitación |
| `mail/` | Notificaciones email vía SMTP + plantillas Handlebars |
| `storage/` | Almacenamiento de archivos e imágenes |
| `setup/` | Asistente de configuración inicial |
| `deleteme/` | Eliminación de cuenta |

---

## Convenciones de carpetas del frontend (`web/src/`)

La convención de nombres para archivos y carpetas sigue el orden **FUNCIÓN-TIPO**:
- `BtnCircle` — Btn es la función (elemento botón), Circle es el tipo
- `CardNotification` — Card es la función, Notification es el tipo
- Excepción: cuando una clase de dominio tiene muchos elementos relacionados, el nombre de la clase va primero: `ButtonNew`, `ButtonCard`, `NetworkNew`, `NetworkCard`

### `elements/`
Bloques de construcción atómicos reutilizados en toda la app: `Accordion`, `Avatar`, `Btn`, `BtnCircle`, `Checkbox`, `Dropdown`, `Form`, campos, iconos, etc.

### `components/`
Grupos de elementos que implementan una funcionalidad: `button/`, `feed/`, `map/`, `popup/`, `nav/`, `network/`, `search/`, `user/`, etc.

### `layouts/`
Wrappers de layout a nivel de página que no son páginas completas en sí mismas.

### `pages/`
Cada subcarpeta aquí es una ruta Next.js. Cada página tiene su propio directorio con `index.tsx`.

### `services/`
Una carpeta por modelo de dominio, con funciones que llaman a la API: `Buttons`, `Networks`, `Users`, `Tags`, `Feed`, `Geo`, `Posts`.

### `state/`
Estado global basado en RxJS, dividido por dominio: `Activity`, `Alerts`, `Button`, `Explore`, `Map`, `Networks`, `Profile`, `Users`, etc.

### `store/`
El event store personalizado. Ver la documentación del Store en la versión inglesa para ejemplos completos de código.

---

## Añadir un nuevo atributo a un modelo

Este es el flujo estándar para extender un modelo de dominio:

**1. Backend — definir en entidad y DTO:**

```
api/src/modules/network/network.entity.ts   # definición de columna en DB
api/src/modules/network/network.dto.ts      # validación de petición POST
```

**2. Generar y ejecutar migración:**

```sh
yarn migration:generate src/data/migrations/add-mi-atributo
yarn migration:run
```

**3. Frontend — añadir al formulario de configuración:**

```
web/src/pages/Configuration/index.tsx       # añadir campo al manejador de envío
```

El mismo patrón aplica a `button/`, `user/` y cualquier otro módulo.

---

## Internacionalización (i18n)

La app incluye traducciones para: **inglés, español, catalán, euskera, portugués**.

- Strings de la API: `api/locales/<lang>/`
- Strings del frontend: `web/public/locales/<lang>/`

Para añadir un nuevo idioma, copia una de las carpetas de locales existentes y traduce los strings.
