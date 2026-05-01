# Coding Standards

This document describes the conventions and patterns used in the Helpbuttons codebase. Follow these when contributing so that new code integrates naturally with the existing style.

---

## General principles

- **TypeScript everywhere**: both frontend (`web/`) and backend (`api/`) are fully TypeScript. Avoid `any` types where a proper interface or type can be defined.
- **Open software choices**: prefer well-documented, widely adopted open-source libraries. Introduce new dependencies only when necessary.
- **Mobile-first**: UI components should work on small screens before large ones.
- **GIS awareness**: location and map functionality are core — keep geographic data consistent (lat/lng, GeoJSON, H3 cells).

---

## Naming conventions

### General rule
File and folder names follow **FUNCTION-TYPE** order:

```
BtnCircle      → Btn (function: button element) + Circle (type)
CardNotification → Card (function: card display) + Notification (type)
FormLogin      → Form (function) + Login (type)
```

**Exception — domain classes**: when a domain model has many associated elements, the class name comes first:

```
ButtonNew      → Button (class) + New (function)
ButtonCard     → Button (class) + Card (type)
NetworkNew     → Network (class) + New (function)
NetworkCard    → Network (class) + Card (type)
```

The goal is that similar things group together naturally in a file browser: all `Card*` components together, all `Button*` domain elements together.

### Frontend components
- **PascalCase** for component files and their folders: `ButtonCard/`, `NetworkNew/`
- Each component lives in its own folder with an `index.tsx` as the entry point
- CSS files are **lowercase**, including file names: `button-card.css`, not `ButtonCard.css`

### Backend modules
- Module folders are **lowercase with hyphens**: `group-message/`, `user-credential/`
- Entity files: `<name>.entity.ts`
- DTO files: `<name>.dto.ts`
- Service files: `<name>.service.ts`
- Controller files: `<name>.controller.ts`

### Important naming distinction
- **`Btn`** = a native HTML button element (UI atom)
- **`Button`** = a Helpbutton post (the domain object)

Never use these interchangeably.

---

## Frontend conventions

### Component structure

Each component lives in its own folder:

```
components/
└── ButtonCard/
    ├── index.tsx      # main component export
    ├── data.tsx       # store events and state selectors (if needed)
    └── button-card.css
```

### State management

State is managed through the custom **Store** — an RxJS event stream. Do not use component-level state (`useState`) for data that needs to be shared across unrelated components. See [Store](9store.md) for full documentation.

- Read state with the `useRef` hook: `const user = useRef(store, (state) => state.currentUser)`
- Write state by emitting events: `store.emit(new SetLoadingEvent(true))`
- Async operations use `WatchEvent` to chain further events

### Services

All API calls go through the `services/` layer. Never call `fetch` or `axios` directly from a component. Create a typed service function in `web/src/services/<domain>/` and call that.

### CSS

- Class names are **lowercase with hyphens**: `.button-card`, `.nav-item`
- File names are **lowercase**: `button-card.css`
- Avoid inline styles except for dynamic values (colors, coordinates from data)
- Icons come from [react-icons](https://react-icons.github.io/react-icons/icons?name=bs) (Bootstrap set)

### i18n

All user-visible strings must use the i18n system. Never hardcode display text. String keys live in `web/public/locales/<lang>/`.

---

## Backend conventions

### Module structure

Every feature module follows NestJS conventions:

```
modules/
└── button/
    ├── button.entity.ts      # TypeORM entity (DB schema)
    ├── button.dto.ts         # Request validation (class-validator)
    ├── button.service.ts     # Business logic
    ├── button.controller.ts  # HTTP endpoints
    └── button.module.ts      # NestJS module definition
```

### Adding a new attribute to a model

1. Add the column to `<name>.entity.ts`
2. Add the field with validation to `<name>.dto.ts`
3. Generate a migration: `yarn migration:generate src/data/migrations/<description>`
4. Run migrations: `yarn migration:run`
5. Update the corresponding frontend form/DTO in `web/src/shared/` and the relevant page

### TypeORM migrations

- Always generate a named migration, never edit existing ones
- Migration names should be descriptive: `add-expiration-to-button`, `add-invite-role`
- Run `yarn migration:run` after pulling changes that include new migrations

### API conventions

- REST endpoints follow NestJS controller conventions
- DTOs use `class-validator` decorators for input validation
- Guards handle JWT authentication — apply the `@UseGuards(JwtAuthGuard)` decorator on protected routes
- The geocoding provider is pluggable — use the `GeoService` abstraction, never call a geocoding API directly

### Email

Email templates use Handlebars (`.hbs` files in `api/src/modules/mail/templates/`). Use the `MailService` to send emails — never send directly via nodemailer from a controller or service outside this module.

---

## Commit conventions

Follow Angular-style commit messages. See [Commit conventions](11commit.md) for the full guide.

Short version:
```
<type>(<scope>): <short description>

feat(button): add expiration date field
fix(network): correct federation URL resolution
docs(readme): update installation steps
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## Git workflow

- Branch from `dev`, not from `main`
- Open PRs back to `dev`
- `main` tracks production releases
- The live dev instance at [dev.helpbuttons.org](https://dev.helpbuttons.org) auto-deploys from `dev`

See [Contributing](contributing.md) for the full workflow.

---

## Browsing the component library

While running locally, visit [http://localhost:3000/RepositoryPage](http://localhost:3000/RepositoryPage) to see all styled elements and components rendered with example props. Use this as a reference before creating new UI elements — the component you need may already exist.
