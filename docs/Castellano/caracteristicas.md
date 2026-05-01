# Características

Helpbuttons es una plataforma rica en funcionalidades para la cooperación comunitaria basada en geolocalización. A continuación encontrarás una visión completa de lo que ofrece.

Para una explicación de cómo funcionan juntas estas características, ver [Conceptos](conceptos.md).

---

## Botones (publicaciones)

### Estructura base
Cada Botón tiene: título, ubicación, descripción, tipo, etiquetas e imágenes. El tipo y los campos adicionales los define la Plantilla de Botón de la Red.

### Geolocalización
Los Botones están vinculados a una ubicación geográfica. Los usuarios pueden buscar por lugar, explorar en el mapa o filtrar por distancia. Los resultados se muestran en mapa y lista simultáneamente.

### Ocultar ubicación exacta
Los usuarios pueden publicar un botón con un área aproximada en lugar de un punto exacto, preservando la privacidad mientras se habilita el descubrimiento basado en ubicación.

### Múltiples imágenes
Sube múltiples imágenes por botón. Se muestran como galería en la página del botón.

### Eventos
Añadir una fecha a un botón lo convierte en evento. Los eventos pueden listarse cronológicamente y expiran automáticamente tras su fecha. También se admiten fechas periódicas.

### Precio y moneda
Los usuarios pueden añadir un precio a un botón. Un precio de `0` muestra una insignia de "Gratis". "Precio a consultar" también es una opción. La moneda se escribe libremente (ej. EUR, USD). No se proporciona conversión de divisas.

---

## Plantillas de botón modulares

La característica definitoria de Helpbuttons es el sistema de **Plantillas de Botón**. Los admins de la Red definen tipos de botón con campos personalizados: fecha, precio, booleano, lista, o cualquier tipo de campo que la comunidad desarrolle. Esto hace que el mismo código funcione para compartir comida, transporte, intercambio de habilidades, coordinación de emergencias o cualquier otro uso.

---

## Mapas y exploración

### Vistas del mapa
La página de Explorar ofrece múltiples vistas:
- **Mapa + lista**: pines en el mapa, lista resumen junto a él
- **Zonas en panal**: botones agrupados por área geográfica, clic para expandir
- **Solo lista**: para exploración con mucho texto o bajo ancho de banda

### Enrutamiento URL profundo
El estado del mapa (zoom, lat/lng, botón seleccionado) se codifica en la URL, haciéndola completamente compartible y enlazable.

### Mapa embebible
Las Redes pueden insertar un widget de mapa de solo lectura en sitios web externos.

---

## Comunicación

### Feed del botón (mensajes públicos)
Cada botón tiene un feed — un hilo de conversación donde los usuarios pueden dejar mensajes, actualizaciones y notas de coordinación. Visible para todos los participantes.

### Mensajes privados
Los usuarios pueden responder en privado en el feed de un botón. Solo el propietario del botón y el autor del mensaje pueden ver las respuestas privadas.

### Mensajería grupal
Los usuarios pueden intercambiar mensajes en conversaciones grupales, independientemente de botones específicos.

---

## Etiquetas

### Creación y búsqueda de etiquetas
Los usuarios crean etiquetas al publicar botones. Las etiquetas son buscables y filtrables en la Red.

### Suscripciones y notificaciones por etiqueta
Los usuarios pueden suscribirse a etiquetas en su configuración. Cuando se crea un nuevo botón con una etiqueta suscrita, reciben una notificación por email.

---

## Notificaciones por email

Los usuarios pueden activar o desactivar notificaciones por email para:
- Nuevos mensajes en los feeds de sus botones
- Nuevos mensajes privados directos
- Nuevos botones creados con etiquetas suscritas
- Cambios de estado en botones

---

## Perfiles de usuario

### Perfil público o privado
Los usuarios pueden elegir mostrar u ocultar sus botones en su página de perfil público.

### Contacto por teléfono
Los usuarios pueden añadir un número de teléfono a su perfil, habilitando llamadas directas, y enlaces de WhatsApp y Telegram desde otros usuarios.

### Seguir botones
Los usuarios pueden seguir los botones de otros usuarios para recibir actualizaciones sobre cambios y mensajes del propietario.

### Reputación por avales
No hay sistema de puntuación por estrellas. Los usuarios pueden avalarse mutuamente — una señal de confianza social en lugar de una puntuación numérica.

---

## Moderación y administración

### Administración descentralizada
Los propietarios de la Red pueden asignar tantos administradores adicionales como necesiten. Los admins pueden moderar, eliminar y bloquear contenido o usuarios. Múltiples admins distribuyen la carga de trabajo y aumentan la confianza comunitaria.

### Bloqueo de usuarios
Los admins pueden bloquear usuarios dentro de una Red o globalmente. Los usuarios bloqueados no pueden volver a unirse.

### Redes solo por invitación
Los admins pueden configurar una Red como privada. Los visitantes pueden ver los botones pero no interactuar sin una invitación. Los enlaces de invitación pueden limitarse por número de usos y tiempo de expiración.

---

## Personalización de la Red

### Apariencia
Los admins pueden personalizar: colores, logo/avatar, nombre, descripción, etiquetas preferidas, tipos de botón, configuración predeterminada del mapa e idioma.

### Ubicación y radio
Cada Red tiene una ubicación principal y un radio geográfico que establece la vista predeterminada del mapa.

### Soporte de dominio personalizado
Si tu red está hospedada en el servidor del equipo en helpbuttons.org, puedes usar un dominio personalizado (ej. `coopera.mibarrio.org`).

---

## Federación

Si dos Redes federan, los usuarios pueden moverse entre ellas con las mismas credenciales y el contenido puede compartirse entre instancias. Este es el bloque de construcción para un ecosistema descentralizado e interconectado de comunidades. Ver [Filosofía](filosofia.md) para más contexto sobre por qué esto importa.

---

## Internacionalización

La plataforma incluye soporte para: **inglés, español, catalán, euskera, portugués**. Se pueden añadir idiomas adicionales traduciendo los archivos de locales en `api/locales/` y `web/public/locales/`.
