# Convenciones de commits

Estas reglas están adaptadas de las [convenciones de commits de AngularJS](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/).

---

## Objetivos

- Permitir generar `CHANGELOG.md` automáticamente
- Poder ignorar commits irrelevantes al usar `git bisect`
- Proporcionar mejor contexto al navegar por el historial

---

## Formato del mensaje de commit

```
<tipo>(<alcance>): <asunto>
<LÍNEA EN BLANCO>
<cuerpo>
<LÍNEA EN BLANCO>
<pie>
```

Ninguna línea del mensaje puede superar los 100 caracteres.

### Tipos permitidos

| Tipo | Cuándo usarlo |
|---|---|
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `docs` | Solo documentación |
| `style` | Formato, punto y coma faltante — sin cambio lógico |
| `refactor` | Cambio de código que no es ni fix ni feat |
| `test` | Añadir tests faltantes |
| `chore` | Cambios de mantenimiento (build, dependencias) |

### Alcance (`scope`)

El alcance especifica qué parte del código afecta el commit. Ejemplos: `button`, `network`, `auth`, `map`, `feed`, `api`, `web`.

### Texto del asunto

- Usa el imperativo y tiempo presente: "cambiar" no "cambié" ni "cambios"
- No capitalizar la primera letra
- Sin punto (.) al final

---

## Cuerpo del mensaje

- Como el asunto, usa tiempo presente imperativo
- Incluye la motivación del cambio y contrasta con el comportamiento anterior

---

## Pie del mensaje

### Cambios importantes (Breaking changes)

Todos los cambios incompatibles deben mencionarse en el pie con descripción, justificación y notas de migración:

```
BREAKING CHANGE: el formato de los campos de ButtonTemplate ha cambiado.
    Antes se usaba un array, ahora es un objeto clave-valor.
    Para migrar: ejecuta el script migrate-templates.js antes de actualizar.
```

### Referencia a issues

Los bugs cerrados deben listarse en el pie con el prefijo "Closes":

```
Closes #234
```

O para múltiples issues:

```
Closes #123, #245, #992
```

---

## Ejemplos

```
feat(button): añadir campo de fecha de expiración

Permite que los botones expiren automáticamente después de una fecha dada.
Los botones expirados se muestran desactivados en el mapa.

Closes #156
```

```
fix(auth): corregir renovación de token JWT caducado

El token no se renovaba correctamente cuando expiraba durante una sesión activa.
Ahora se detecta la expiración y se redirige al login.

Closes #203
```

```
docs(instalacion): actualizar guía con nuevo proceso Docker

El proceso de instalación cambió al monorepo.
Eliminadas referencias a los repositorios hb-front y hb-back separados.
```

```
style(explore): formatear archivo de componente de mapa
```

```
refactor(network): simplificar lógica de resolución de URL de federación
```
