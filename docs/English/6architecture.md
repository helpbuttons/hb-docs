# Software Architecture

## Repository

The project lives in a single monorepo:

- **Code**: [github.com/helpbuttons/helpbuttons](https://github.com/helpbuttons/helpbuttons)
- **Docs** (this repo): [github.com/helpbuttons/hb-docs](https://github.com/helpbuttons/hb-docs)

Active development happens on the `dev` branch. Pull requests should target `dev`. The `main` branch tracks production releases.

---

## Technologies

Technologies were chosen following three principles: **open software**, **mobile-first**, and **GIS positioning**. We also favored tools with good community adoption and documentation.

### Frontend (`web/`)

| Technology | Role |
|---|---|
| [TypeScript](https://www.typescriptlang.org/) | Typed JavaScript across the whole stack |
| [Next.js](https://nextjs.org/) | React framework, file-based routing, SSR |
| [React](https://reactjs.org/) | Component-based UI |
| [Leaflet](https://leafletjs.com/) | Interactive maps |
| [RxJS](https://rxjs.dev/) | Reactive state management (see [Store](9store.md)) |
| [react-icons](https://react-icons.github.io/react-icons/) | Icon set (Bootstrap icons) |

### Backend (`api/`)

| Technology | Role |
|---|---|
| [Node.js](https://nodejs.org/) | JavaScript runtime |
| [NestJS](https://nestjs.com/) | Modular backend framework (OOP + DI) |
| [TypeORM](https://typeorm.io/) | Database ORM with migration support |
| [PostgreSQL](https://www.postgresql.org/) | Relational database |
| [PostGIS](https://postgis.net/) | Spatial extension for geographic queries |
| [H3](https://h3geo.org/) | Uber's hexagonal spatial indexing library |
| [Redis](https://redis.io/) | Cache and queue |
| Handlebars | Email templates |

### Infrastructure

| Technology | Role |
|---|---|
| Docker + docker-compose | Container orchestration |
| Custom PostgreSQL image | PostgreSQL + PostGIS + H3 bundled |
| Yarn | Package manager |

---

## Monorepo structure

```
helpbuttons/
├── api/                        # NestJS backend
│   ├── src/
│   │   ├── app/                # Bootstrap, global config, validators
│   │   ├── config/             # Configuration module
│   │   ├── data/
│   │   │   ├── migrations/     # TypeORM migrations (run in order)
│   │   │   └── seed/           # Database seeders and sample data
│   │   └── modules/            # Feature modules (see below)
│   ├── locales/                # API i18n strings (en, es, cat, eu, pt)
│   └── Dockerfile
│
├── web/                        # Next.js frontend
│   ├── public/
│   │   ├── assets/             # Images, SVGs, routing assets
│   │   └── locales/            # Frontend i18n strings (en, es, cat, eu, pt)
│   └── src/
│       ├── components/         # Composed UI components
│       ├── elements/           # Atomic UI elements (buttons, forms, fields…)
│       ├── layouts/            # Page layout wrappers
│       ├── pages/              # Next.js routes (see Pages section below)
│       ├── services/           # API client services per domain
│       ├── shared/             # DTOs, entities, types shared by api and web
│       ├── state/              # Global app state (RxJS-based, per domain)
│       └── store/              # Event store (see Store docs)
│
├── plugins/                    # Plugin system
├── postgres/                   # Custom PostgreSQL Docker image
├── docker-compose.yml
├── env.sample
└── README.md
```

---

## Backend modules (`api/src/modules/`)

Each module owns its entity, DTO, service, controller, and any related guards or strategies.

| Module | Responsibility |
|---|---|
| `auth/` | JWT authentication, guards, login strategies |
| `button/` | Core Button entity — geo-located posts |
| `network/` | Networks — community containers |
| `user/` | User profiles |
| `user-credential/` | Password and credential management |
| `post/` | Comments and replies on buttons |
| `group-message/` | Group messaging between users |
| `activity/` | Activity feed |
| `tag/` | Tag creation and subscription |
| `geo/` | Geocoding (Komoot / Pelias / simulate mode) |
| `invite/` | Invite link system |
| `mail/` | Email notifications via SMTP + Handlebars templates |
| `storage/` | File and image storage |
| `setup/` | First-run setup wizard |
| `deleteme/` | Account deletion |

---

## Frontend folder conventions (`web/src/`)

The naming convention for files and folders follows **FUNCTION-TYPE** order:
- `BtnCircle` — Btn is the function (button), Circle is the type
- `CardNotification` — Card is the function, Notification is the type
- Exception: when a domain class has many related elements, the class name comes first: `ButtonNew`, `ButtonCard`, `NetworkNew`, `NetworkCard`

### `elements/`
Atomic building blocks reused everywhere: `Accordion`, `Avatar`, `Btn`, `BtnCircle`, `Checkbox`, `Dropdown`, `Form`, fields, icons, etc.

### `components/`
Groups of elements that implement a feature: `button/`, `feed/`, `map/`, `popup/`, `nav/`, `network/`, `search/`, `user/`, etc.

### `layouts/`
Page-level layout wrappers that are not full pages themselves (e.g. `ActivityLayout`, `FeedLayout`).

### `pages/`
Every subfolder here is a Next.js route. See the [Pages section](7pages.md) for descriptions of each.

### `services/`
One folder per domain model, containing functions that call the API: `Buttons`, `Networks`, `Users`, `Tags`, `Feed`, `Geo`, `Posts`. Also contains cross-cutting concerns: `Alerts`, `Errors`, `HttpUtils`.

### `state/`
RxJS-based global state, split per domain: `Activity`, `Alerts`, `Button`, `Explore`, `Map`, `Networks`, `Profile`, `Users`, etc.

### `store/`
The custom event store. See [Store](9store.md) for full documentation and examples.

---

## Basic domain concepts

In order to understand the project you need to know how three concepts interact: Buttons, Users, and Networks.

A **Network** is an environment where users can create Buttons. Using a common analogy: if Airbnb were built on Helpbuttons, Airbnb itself would be a Network, each listing would be a Button, and each host would be a User.

One server can hold more than one separate Network, and Networks can federate — sharing users and content between instances to facilitate inter-community cooperation.

A **Button** (also called Helpbutton) is the core post. It can be published in any Network that shares the same ButtonTemplate. A **ButtonTemplate** defines the extra fields and structure that differentiate one type of Network from another — a food-sharing network has different fields than a transport-sharing network.

For full model descriptions see the sections below, or the [Core Concepts](concepts.md) page for a simpler overview.

---

## Models

### Button / Helpbutton

A Button is the app's post. Its base fields are: title, type, location, date, description, images, and tags. On top of these, the ButtonTemplate adds extra fields specific to the Network's purpose.

Every button has a **Feed** — a chronological list of interactions (messages, changes, updates) visible to its participants.

```typescript
export interface IButton {
  id?: any | null,
  owner: any,
  name: string,
  templateButtonId: any | null,
  type: enum,
  tags: [ITag],
  description: string,
  date: [],
  // GIS data
  geoPlace: [],
  // optional
  networks: [],
  feedType: enum,           // 'single' | 'group'
  templateExtraData: {},    // JSON: custom fields defined by ButtonTemplate
}
```

### Network

The Network is the community container. It has a location, radius, description, avatar, name, and display options (map view, list view, honeycomb zones, etc.). Its ButtonTemplate defines which fields and filters appear in the Explore page and button creation forms.

A Network can be **public** (anyone can see and interact) or **private** (requires an invitation to join). The creator is the owner and first moderator. Moderators can assign additional admin roles.

Networks can federate with other Networks — sharing users and content between instances. See [Features](4features.md) for details.

```typescript
export interface INetwork {
  id: string,
  name: string,
  url: string,
  avatar: string,
  privacy: string,          // 'public' | 'private'
  tags: [],
  description: string,
  buttonsTemplate: {},      // button types: name, color, fields
  showButtons: string,      // 'area' | 'point'
  place: string,
  geoPlace: {},
  radius: string,
  friendNetworks: [],
  networkRoles: [],         // admin-assigned roles with user lists
  blockedUsers: [],         // blocked user IDs
}
```

### User

Users exist across Networks. They can join and leave Networks, and their reputation and profile travel with them. Reputation is established through **supports** from other users — there is no rating system, only positive endorsements. Moderation relies on blocks and community support signals.

```typescript
export interface IUser {
  username: string,
  email: string,
  realm: string,
  roles: [],
  token: string,
}
```

### ButtonTemplate

ButtonTemplate is the module that gives each Network its specific character. The `fields` JSON object enumerates extra button fields: dates, prices, booleans, checklists, or any field type added by the community. This is what allows the same codebase to power food-sharing, transport-sharing, skill-exchange, or emergency-support networks.

```typescript
export interface ITemplateButton {
  id: any | null,
  name: string,
  type: enum,
  fields: {},   // JSON: custom field definitions
  owner: int,
}
```

Example ButtonTemplate JSON:
```json
{
  "id": 0,
  "name": "Event",
  "type": "offer",
  "fields": {},
  "created": "2024-01-01T00:00:00.000Z",
  "owner": "1"
}
```

### Feed

A Feed is a chronological list of interactions attached to an entity. The **Button Feed** shows all messages, updates, and changes related to a specific button. The **Profile Feed** shows all activity related to a user.

Feed content and visibility vary by user role — the button owner sees different information than regular participants.

### Tag

Tags serve two purposes: **search filtering** and **notification subscription**. Users can subscribe to tags in their settings to receive notifications whenever a button with that tag is created.

---

## Adding a new attribute to a Network

This is the standard flow for extending a domain model — use this as a reference for contributing:

**1. Backend — define in entity and DTO:**

```
api/src/modules/network/network.entity.ts   # database column definition
api/src/modules/network/network.dto.ts      # POST request validation
```

**2. Generate and run migration:**

```sh
yarn migration:generate src/data/migrations/add-my-attribute
yarn migration:run
```

**3. Frontend — add to configuration form:**

```
web/src/pages/Configuration/index.tsx       # add field to the submit handler
```

The same pattern applies to `button/`, `user/`, and any other module.

---

## Geocoding

The geocoding system is pluggable. Providers are configured via environment:

- **Komoot** (Photon) — default, open and free
- **Pelias** — self-hostable geocoding stack
- **Simulate** — for local development without external calls

---

## Internationalisation (i18n)

The app ships with translations for: **English**, **Spanish**, **Catalan**, **Basque**, **Portuguese**.

- API strings: `api/locales/<lang>/`
- Frontend strings: `web/public/locales/<lang>/`

To add a new language, copy one of the existing locale folders and translate the strings.
