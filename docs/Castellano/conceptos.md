# Conceptos básicos

Esta página explica los principales bloques de construcción de Helpbuttons en términos sencillos. Entender estos cinco conceptos es suficiente para trabajar en cualquier parte del código.

---

## Red (Network)

Una **Red** es el contenedor comunitario de nivel superior. Piensa en ella como la "app" que estás creando para tu comunidad.

Cada Red tiene:
- Un **nombre, descripción y ubicación** (usada para definir el área predeterminada del mapa)
- Un **radio** que define el alcance geográfico
- Un **avatar** y colores/tema personalizables
- Una **configuración de privacidad**: pública (visible para cualquiera) o privada (solo por invitación)
- Un conjunto de **Plantillas de Botón** que definen qué tipos de botones existen en esta Red
- **Coordinadores** que pueden moderar contenido y gestionar usuarios

Cada instalación de Helpbuttons aloja **una Red**. Instalaciones separadas pueden **federar** entre sí para compartir usuarios y contenido entre instancias.

**Ejemplo**: Un grupo de ayuda mutua de barrio gestiona su Red en `ayuda.mibarrio.org`. Está configurada como pública, tiene dos tipos de botón ("Ofrezco" y "Necesito"), y tres coordinadores.

---

## Botón (Helpbutton)

Un **Botón** es la publicación principal — la unidad de información que los usuarios publican y a la que otros usuarios responden. El nombre "Helpbutton" refleja el enfoque original de ayuda mutua, pero un botón puede representar cualquier tipo de oferta, necesidad, evento o recurso.

Cada botón tiene estos campos base:
- **Título** y **descripción**
- **Ubicación** (con privacidad opcional: punto exacto o área aproximada)
- **Tipo** (definido por las Plantillas de Botón de la Red — ej. "Oferta", "Necesidad", "Evento")
- **Etiquetas**
- **Imágenes**
- **Fecha** (opcional, lo convierte en evento)

Los botones pertenecen a la Red en la que fueron creados. Mediante la federación, un botón puede compartirse con otras Redes que usen la misma Plantilla de Botón.

Cada botón tiene un **Feed** — ver más abajo.

**Ejemplo**: Un usuario publica un botón: "Tengo 5kg de tomates para compartir" → tipo "Ofrezco", ubicación en área aproximada, etiquetado "comida, verduras". Otros usuarios lo ven en el mapa y contactan a través del feed del botón.

---

## Plantilla de Botón (ButtonTemplate)

Una **Plantilla de Botón** es lo que hace única a cada Red. Define campos adicionales más allá de la estructura base del botón — el coordinador de la Red crea plantillas que se adaptan al caso de uso de su comunidad.

Una red de reparto de comida podría añadir: tipo de alimento, cantidad, información dietética.
Una red de transporte podría añadir: origen, destino, hora de salida, plazas disponibles.
Una red de eventos podría añadir: fecha, duración, participantes máximos.

Las Plantillas de Botón se definen en JSON y el frontend renderiza automáticamente los campos de formulario y filtros apropiados.

**Ejemplo**: El coordinador crea una plantilla "Ofrezco transporte" con campos: `desde`, `hasta`, `hora_salida`, `plazas`. Cuando los usuarios crean un botón de este tipo, rellenan esos campos adicionales. La página de Explorar muestra un filtro de "hora de salida".

---

## Usuario

Un **Usuario** es una persona registrada que puede unirse a Redes, publicar Botones e interactuar con otros.

Propiedades clave:
- Los usuarios existen **a través de las Redes** — su perfil y reputación viajan con ellos
- Los usuarios pueden **unirse y abandonar** Redes libremente (sujeto a la configuración de privacidad)
- Los usuarios pueden **apoyarse** mutuamente (aval positivo, sin puntuaciones)
- Los usuarios pueden ser **bloqueados** por coordinadores dentro de una Red o globalmente
- Los coordinadores pueden asignar a otros usuarios **roles de coordinador** dentro de su Red

No existe una puntuación de reputación global — la reputación es social, establecida a través de avales entre iguales y confianza comunitaria.

---

## Feed

Un **Feed** es el hilo de conversación pública adjunto a un botón — donde ocurre la coordinación: preguntas, confirmaciones, actualizaciones de estado. Todos los miembros pueden leer y publicar en el feed de un botón.

---

## Mensajería

Toda la comunicación privada y grupal vive en la sección de **Mensajes**, separada de los feeds de botones. Cada hilo se denomina **Activity Conversation**. Hay tres tipos:

- **Conversación de botón**: se abre desde un botón concreto y crea un chat privado uno a uno entre el usuario y el creador del botón. Invisible para el resto.
- **Foro de comunidad**: una Activity Conversation grupal única abierta a todos los miembros de la Red.
- **Foro de coordinadores**: una Activity Conversation grupal restringida a los coordinadores de la Red.

---

## Etiqueta (Tag)

Las **Etiquetas** sirven dos propósitos distintos:

1. **Búsqueda y filtrado**: los usuarios pueden buscar botones por etiqueta en una Red
2. **Notificaciones**: los usuarios pueden suscribirse a etiquetas en su configuración y recibir notificaciones por email cuando se crean nuevos botones con esas etiquetas

Las etiquetas son de forma libre — cualquiera puede crear una etiqueta al publicar un botón. Los coordinadores de la Red pueden sugerir o destacar etiquetas preferidas en la configuración de la Red.

---

## Cómo encajan entre sí

```
Servidor
└── Red (ej. "Barrio Lavapiés")
    ├── Plantilla: "Ofrezco"
    ├── Plantilla: "Necesito"
    ├── Plantilla: "Evento"
    │
    ├── Botón: "Tomates para compartir"  [tipo: Ofrezco, propietario: usuario_A]
    │   └── Feed: [mensaje de usuario_B, respuesta de usuario_A, ...]
    │
    ├── Botón: "Necesito transporte a Madrid" [tipo: Necesito, propietario: usuario_C]
    │   └── Feed: [...]
    │
    └── Usuarios: [usuario_A, usuario_B, usuario_C, ...]
        └── Suscripciones a etiquetas, roles, perfiles
```

Cada instalación ejecuta una Red. Las instalaciones pueden federar con otros servidores, compartiendo usuarios y contenido. Los botones pueden compartirse entre Redes federadas que usen la misma Plantilla de Botón.

---

Para el detalle técnico — columnas de base de datos, interfaces TypeScript, endpoints de la API — ver [Arquitectura](arquitectura.md).
