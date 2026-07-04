# Backend — Plan de desarrollo

Stack: **Node.js + Express + MySQL**  
Actualiza este fichero conforme avance el desarrollo.

---

## Estructura de carpetas

```
backend/
├── src/
│   ├── config/
│   │   ├── db.js            # Pool de conexiones MySQL
│   │   └── env.js           # Validación de variables de entorno
│   ├── controllers/
│   │   ├── auth.controller.js
│   │   ├── users.controller.js
│   │   ├── items.controller.js
│   │   ├── categories.controller.js
│   │   ├── brands.controller.js
│   │   ├── conversations.controller.js
│   │   ├── messages.controller.js
│   │   ├── reports.controller.js
│   │   ├── favorites.controller.js
│   │   └── valuations.controller.js
│   ├── middlewares/
│   │   ├── auth.middleware.js      # Verifica JWT
│   │   ├── role.middleware.js      # requireRole('admin') etc.
│   │   ├── validate.middleware.js  # Valida body con esquemas
│   │   └── error.middleware.js     # Handler global de errores
│   ├── models/
│   │   ├── user.model.js
│   │   ├── item.model.js
│   │   ├── category.model.js
│   │   ├── brand.model.js
│   │   ├── conversation.model.js
│   │   ├── message.model.js
│   │   ├── report.model.js
│   │   ├── favorite.model.js
│   │   └── valuation.model.js
│   ├── routes/
│   │   ├── auth.routes.js
│   │   ├── users.routes.js
│   │   ├── items.routes.js
│   │   ├── categories.routes.js
│   │   ├── brands.routes.js
│   │   ├── conversations.routes.js
│   │   ├── reports.routes.js
│   │   ├── favorites.routes.js
│   │   └── valuations.routes.js
│   └── app.js
├── .env.example
├── package.json
└── server.js
```

---

## Fases de desarrollo

### Fase 0 — Proyecto base
- [ ] `npm init`, instalar dependencias (`express`, `mysql2`, `bcrypt`, `jsonwebtoken`, `dotenv`, `cors`)
- [ ] Configurar `db.js` con pool de conexiones
- [ ] Configurar `app.js` (cors, json parser, rutas, error middleware)
- [ ] Crear `.env.example` con las variables necesarias (`DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME`, `JWT_SECRET`, `PORT`)

---

### Fase 1 — Autenticación
**Endpoints:**
| Método | Ruta | Descripción |
|--------|------|-------------|
| POST | `/api/auth/register` | Registro de usuario nuevo |
| POST | `/api/auth/login` | Login, devuelve JWT |
| GET  | `/api/auth/me` | Devuelve usuario autenticado (requiere JWT) |

**Notas:**
- `register`: hashear contraseña con `bcrypt` antes de insertar.
- `login`: comparar hash, devolver JWT con payload `{ id, username, role }`.
- `me`: extraer usuario del token, devolver datos públicos (sin `password_hash`).
- El JWT se envía en header `Authorization: Bearer <token>`.

---

### Fase 2 — Artículos (núcleo de la plataforma)
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET    | `/api/items` | Listado con filtros (categoría, precio, estado, marca, condición) | Público |
| GET    | `/api/items/:id` | Detalle de un artículo | Público |
| POST   | `/api/items` | Crear artículo | user |
| PUT    | `/api/items/:id` | Editar artículo | Propietario |
| DELETE | `/api/items/:id` | Eliminar artículo | Propietario / admin |
| PATCH  | `/api/items/:id/sell` | Marcar como vendido | Propietario |
| GET    | `/api/users/:id/items` | Artículos de un usuario | Público |

**Notas:**
- Filtros en `GET /api/items`: `?category=`, `?brand=`, `?minPrice=`, `?maxPrice=`, `?condition=`, `?status=`, `?search=` (búsqueda por título).
- Solo se devuelven artículos con `status = 'published'` a usuarios no autenticados.
- Al crear/editar, verificar que `category_id` y `brand_id` existen.
- `specs` se recibe como objeto JSON del frontend y se almacena como JSON en la BD.

---

### Fase 3 — Fotos de artículos
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| POST   | `/api/items/:id/photos` | Subir fotos a un artículo | Propietario |
| DELETE | `/api/items/:id/photos/:photoId` | Eliminar una foto | Propietario |

**Notas:**
- Por ahora almacenar URL (el frontend enviará una URL pública). Subida de ficheros real es deseable pero no MVP.
- Máximo de fotos por artículo: 8.

---

### Fase 4 — Categorías y marcas
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET    | `/api/categories` | Árbol de categorías | Público |
| POST   | `/api/categories` | Crear categoría | admin |
| PUT    | `/api/categories/:id` | Editar categoría | admin |
| DELETE | `/api/categories/:id` | Eliminar categoría | admin |
| GET    | `/api/brands` | Listado de marcas | Público |
| POST   | `/api/brands` | Crear marca | admin |
| PUT    | `/api/brands/:id` | Editar marca | admin |
| DELETE | `/api/brands/:id` | Eliminar marca | admin |

**Notas:**
- `GET /api/categories` devuelve el árbol completo (raíz + hijos) en un solo objeto anidado.

---

### Fase 5 — Mensajería
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET    | `/api/conversations` | Mis conversaciones (comprador o vendedor) | user |
| POST   | `/api/conversations` | Iniciar conversación sobre un artículo | user |
| GET    | `/api/conversations/:id/messages` | Mensajes de una conversación | Participante |
| POST   | `/api/conversations/:id/messages` | Enviar mensaje | Participante |
| PATCH  | `/api/conversations/:id/read` | Marcar mensajes como leídos | Participante |

**Notas:**
- Solo el comprador puede iniciar una conversación. No puede haber dos conversaciones del mismo comprador sobre el mismo artículo (UNIQUE en BD).
- Solo los participantes (buyer o seller) pueden leer y escribir en una conversación.
- No se expone ningún dato de contacto personal en los mensajes.

---

### Fase 6 — Reportes y moderación
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| POST   | `/api/reports` | Reportar un artículo | user |
| GET    | `/api/reports` | Listado de reportes pendientes | moderator / admin |
| GET    | `/api/reports/:id` | Detalle de un reporte | moderator / admin |
| PATCH  | `/api/reports/:id/resolve` | Resolver reporte (activo o retirado) | moderator / admin |

**Notas:**
- Al crear un reporte, el artículo pasa automáticamente a `status = 'under_review'`.
- Al resolver con `resolved_removed`: el artículo pasa a `status = 'removed'`.
- Al resolver con `resolved_active`: el artículo vuelve a `status = 'published'`.
- En ambos casos se registra `moderator_id`, `moderator_note` y `resolved_at`.

---

### Fase 7 — Gestión de usuarios (admin)
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET    | `/api/users` | Listado de usuarios con filtros | admin |
| GET    | `/api/users/:id` | Perfil público de un usuario | Público |
| PUT    | `/api/users/:id` | Editar datos de un usuario | Propietario / admin |
| PATCH  | `/api/users/:id/role` | Cambiar rol | admin |
| PATCH  | `/api/users/:id/status` | Bloquear / desbloquear cuenta | admin |
| DELETE | `/api/users/:id` | Eliminar cuenta (soft delete) | Propietario / admin |

**Notas:**
- El perfil público solo expone `username`, `avatar_url`, `created_at` y valoraciones recibidas.
- El borrado es un soft delete: `status = 'deleted'`, no se borra el registro.

---

### Fase 8 — Favoritos y valoraciones *(deseables)*
**Endpoints:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET    | `/api/favorites` | Mis favoritos | user |
| POST   | `/api/favorites` | Añadir a favoritos | user |
| DELETE | `/api/favorites/:itemId` | Quitar de favoritos | user |
| POST   | `/api/valuations` | Crear valoración tras transacción | user |
| GET    | `/api/users/:id/valuations` | Valoraciones recibidas por un usuario | Público |

---

### Fase 9 — Panel de estadísticas (admin) *(deseable)*
**Endpoint:**
| Método | Ruta | Descripción | Roles |
|--------|------|-------------|-------|
| GET    | `/api/admin/stats` | Estadísticas globales | admin |

**Respuesta incluye:**
- Total de usuarios activos / bloqueados
- Total de artículos por estado (`published`, `sold`, `removed`…)
- Total de reportes pendientes / resueltos
- Artículos publicados en los últimos 30 días

---

## Dependencias previstas

```json
{
  "dependencies": {
    "express": "^4.x",
    "mysql2": "^3.x",
    "bcrypt": "^5.x",
    "jsonwebtoken": "^9.x",
    "dotenv": "^16.x",
    "cors": "^2.x"
  },
  "devDependencies": {
    "nodemon": "^3.x"
  }
}
```

---

## Estado del desarrollo

| Fase | Estado |
|------|--------|
| 0 — Proyecto base | ✔ Completado |
| 1 — Autenticación | ✔ Completado |
| 2 — Artículos | ✔ Completado |
| 3 — Fotos | ⬜ Pendiente |
| 4 — Categorías y marcas | ⬜ Pendiente |
| 5 — Mensajería | ⬜ Pendiente |
| 6 — Reportes y moderación | ⬜ Pendiente |
| 7 — Gestión de usuarios | ⬜ Pendiente |
| 8 — Favoritos y valoraciones | ⬜ Pendiente |
| 9 — Estadísticas | ⬜ Pendiente |
