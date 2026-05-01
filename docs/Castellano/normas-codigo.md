# Normas de código

Este documento describe las convenciones y patrones utilizados en el código de Helpbuttons. Síguelos al contribuir para que el código nuevo se integre de forma natural con el estilo existente.

---

## Principios generales

- **TypeScript en todas partes**: tanto el frontend (`web/`) como el backend (`api/`) son completamente TypeScript. Evita los tipos `any` donde pueda definirse una interfaz o tipo adecuado.
- **Software libre**: prefiere bibliotecas de código abierto bien documentadas y ampliamente adoptadas. Introduce nuevas dependencias solo cuando sea necesario.
- **Mobile-first**: los componentes UI deben funcionar en pantallas pequeñas antes que en grandes.
- **Conciencia GIS**: la funcionalidad de localización y mapas es central — mantén los datos geográficos consistentes (lat/lng, GeoJSON, celdas H3).

---

## Convenciones de nombres

### Regla general
Los nombres de archivos y carpetas siguen el orden **FUNCIÓN-TIPO**:

```
BtnCircle        → Btn (función: elemento botón) + Circle (tipo)
CardNotification → Card (función: visualización tipo tarjeta) + Notification (tipo)
FormLogin        → Form (función) + Login (tipo)
```

**Excepción — clases de dominio**: cuando un modelo de dominio tiene muchos elementos asociados, el nombre de la clase va primero:

```
ButtonNew    → Button (clase) + New (función)
ButtonCard   → Button (clase) + Card (tipo)
NetworkNew   → Network (clase) + New (función)
NetworkCard  → Network (clase) + Card (tipo)
```

El objetivo es que cosas similares se agrupen naturalmente en un explorador de archivos: todos los componentes `Card*` juntos, todos los elementos de dominio `Button*` juntos.

### Componentes del frontend
- **PascalCase** para archivos de componentes y sus carpetas: `ButtonCard/`, `NetworkNew/`
- Cada componente vive en su propia carpeta con `index.tsx` como punto de entrada
- Los archivos CSS son en **minúsculas**: `button-card.css`, no `ButtonCard.css`

### Módulos del backend
- Las carpetas de módulos son en **minúsculas con guiones**: `group-message/`, `user-credential/`
- Archivos de entidad: `<nombre>.entity.ts`
- Archivos de DTO: `<nombre>.dto.ts`
- Archivos de servicio: `<nombre>.service.ts`
- Archivos de controlador: `<nombre>.controller.ts`

### Distinción de nombres importante
- **`Btn`** = un elemento HTML botón nativo (átomo de UI)
- **`Button`** = un Helpbutton (la publicación, el objeto de dominio)

Nunca los uses indistintamente.

---

## Convenciones del frontend

### Estructura de componentes

Cada componente vive en su propia carpeta:

```
components/
└── ButtonCard/
    ├── index.tsx      # exportación principal del componente
    ├── data.tsx       # eventos del store y selectores de estado (si hace falta)
    └── button-card.css
```

### Gestión del estado

El estado se gestiona a través del **Store** personalizado — un flujo de eventos RxJS. No uses estado a nivel de componente (`useState`) para datos que necesiten compartirse entre componentes no relacionados. El Store está documentado en la versión inglesa con ejemplos de código completos.

- Lee el estado con el hook `useRef`: `const user = useRef(store, (state) => state.currentUser)`
- Escribe el estado emitiendo eventos: `store.emit(new SetLoadingEvent(true))`
- Las operaciones asíncronas usan `WatchEvent` para encadenar más eventos

### Servicios

Todas las llamadas a la API pasan por la capa `services/`. Nunca llames a `fetch` o `axios` directamente desde un componente. Crea una función de servicio tipada en `web/src/services/<dominio>/` y llama a esa.

### CSS

- Los nombres de clase son en **minúsculas con guiones**: `.button-card`, `.nav-item`
- Los nombres de archivo son en **minúsculas**: `button-card.css`
- Evita estilos en línea excepto para valores dinámicos (colores, coordenadas de datos)
- Los iconos vienen de [react-icons](https://react-icons.github.io/react-icons/icons?name=bs) (set Bootstrap)

### i18n

Todos los textos visibles para el usuario deben usar el sistema i18n. Nunca codifiques texto de visualización directamente. Las claves de strings viven en `web/public/locales/<lang>/`.

---

## Convenciones del backend

### Estructura de módulos

Cada módulo de funcionalidades sigue las convenciones de NestJS:

```
modules/
└── button/
    ├── button.entity.ts      # Entidad TypeORM (esquema DB)
    ├── button.dto.ts         # Validación de peticiones (class-validator)
    ├── button.service.ts     # Lógica de negocio
    ├── button.controller.ts  # Endpoints HTTP
    └── button.module.ts      # Definición del módulo NestJS
```

### Añadir un nuevo atributo a un modelo

1. Añade la columna a `<nombre>.entity.ts`
2. Añade el campo con validación a `<nombre>.dto.ts`
3. Genera una migración: `yarn migration:generate src/data/migrations/<descripcion>`
4. Ejecuta las migraciones: `yarn migration:run`
5. Actualiza el formulario/DTO del frontend correspondiente en `web/src/shared/` y la página relevante

### Migraciones TypeORM

- Siempre genera una migración con nombre descriptivo, nunca edites las existentes
- Los nombres de migración deben ser descriptivos: `add-expiration-to-button`, `add-invite-role`
- Ejecuta `yarn migration:run` después de hacer pull de cambios que incluyan nuevas migraciones

### Convenciones de API

- Los endpoints REST siguen las convenciones del controlador NestJS
- Los DTOs usan decoradores `class-validator` para la validación de entrada
- Los Guards manejan la autenticación JWT — aplica el decorador `@UseGuards(JwtAuthGuard)` en rutas protegidas
- El proveedor de geocodificación es intercambiable — usa la abstracción `GeoService`, nunca llames a una API de geocodificación directamente

---

## Convenciones de commits

Sigue los mensajes de commit estilo Angular. Ver [Convenciones de commits](commits.md) para la guía completa.

Resumen:
```
<tipo>(<alcance>): <descripción corta>

feat(button): añadir campo de fecha de expiración
fix(network): corregir resolución de URL de federación
docs(readme): actualizar pasos de instalación
```

Tipos: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## Flujo de trabajo Git

- Crea ramas desde `dev`, no desde `main`
- Abre PRs hacia `dev`
- `main` sigue los lanzamientos de producción
- La instancia de desarrollo en vivo en [dev.helpbuttons.org](https://dev.helpbuttons.org) se despliega automáticamente desde `dev`

---

## Explorar la biblioteca de componentes

Mientras ejecutas en modo desarrollo, visita [http://localhost:3000/RepositoryPage](http://localhost:3000/RepositoryPage) para ver todos los elementos y componentes estilizados con props de ejemplo. Úsalo como referencia antes de crear nuevos elementos de UI — el componente que necesitas puede que ya exista.
