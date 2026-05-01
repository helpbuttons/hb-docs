# Issues y Pull Requests

El tracker de issues se usa **ÚNICAMENTE** para reportar bugs. Las nuevas funcionalidades deben discutirse primero en nuestro canal de [Telegram](https://t.me/+-_0KxKJ427VkYjU0).

El repositorio está en [github.com/helpbuttons/helpbuttons](https://github.com/helpbuttons/helpbuttons). Abre issues y pull requests allí.

Antes de abrir un issue, busca entre los existentes para evitar duplicados.

Copia cualquiera de estas plantillas para iniciar un issue:

---

## Plantilla de bug

```markdown
## Comportamiento esperado
<!-- Cuéntanos qué debería ocurrir -->

## Comportamiento actual
<!-- Cuéntanos qué ocurre en cambio -->

## Posible solución
<!-- No obligatorio, pero sugiere una corrección/razón del bug -->

## Pasos para reproducir
<!-- Proporciona un enlace a un ejemplo en vivo, o pasos inequívocos para -->
<!-- reproducir el bug. Incluye código si es relevante -->
1.
2.
3.
4.

## Contexto (entorno)
<!-- ¿Cómo te ha afectado? ¿Qué intentas conseguir? -->
<!-- El contexto ayuda a encontrar una solución más útil en el mundo real -->

## Descripción detallada
<!-- Proporciona una descripción detallada del cambio o adición que propones -->

## Posible implementación
<!-- No obligatorio, sugiere una idea para implementar la adición o el cambio -->
```

---

## Plantilla de Pull Request

```markdown
## Descripción
<!-- Describe tus cambios en detalle -->

## Issue relacionado
<!-- Este proyecto solo acepta pull requests relacionados con issues abiertos -->
<!-- Si sugieres una nueva funcionalidad o cambio, primero discútelo en un issue -->
<!-- Si corriges un bug, debe existir un issue que lo describa con pasos para reproducirlo -->
<!-- Enlaza el issue aquí: -->

## Motivación y contexto
<!-- ¿Por qué es necesario este cambio? ¿Qué problema resuelve? -->

## ¿Cómo se ha probado?
<!-- Describe en detalle cómo has probado tus cambios -->
<!-- Incluye detalles del entorno de prueba y los tests ejecutados -->

## Capturas de pantalla (si procede):
```

---

## Flujo de trabajo de contribución

1. Elige un issue del repositorio o crea uno nuevo
2. Crea una rama desde `dev`: `git checkout -b feat/mi-funcionalidad dev`
3. Desarrolla tu cambio siguiendo las [Normas de código](normas-codigo.md)
4. Haz commits siguiendo las [Convenciones de commits](commits.md)
5. Abre un PR hacia `dev`
6. Espera revisión — puedes pedir ayuda en el canal de Telegram
