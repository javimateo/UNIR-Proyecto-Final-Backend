# API Reference — Backend

Base URL: `http://localhost:3000` (desarrollo) / URL de Railway (producción)

Todos los endpoints protegidos requieren el header:
```
Authorization: Bearer <token>
```

---

## Autenticación

### `POST /api/auth/register`
Registrar un nuevo usuario.

**Body:**
```json
{
  "username": "javi",
  "email": "javi@example.com",
  "password": "mipassword"
}
```

**Respuesta 201:**
```json
{
  "id": 1,
  "username": "javi",
  "email": "javi@example.com",
  "role": "user"
}
```

**Errores:** `400` campos faltantes · `409` username o email ya en uso

---

### `POST /api/auth/login`
Iniciar sesión. Devuelve el JWT a usar en el resto de peticiones.

**Body:**
```json
{
  "email": "javi@example.com",
  "password": "mipassword"
}
```

**Respuesta 200:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Errores:** `401` credenciales incorrectas · `403` cuenta bloqueada

---

### `GET /api/auth/me` 🔒
Obtener los datos del usuario autenticado.

**Respuesta 200:**
```json
{
  "id": 1,
  "username": "javi",
  "email": "javi@example.com",
  "role": "user",
  "status": "active",
  "avatar_url": null,
  "created_at": "2026-01-01T00:00:00.000Z"
}
```

---

## Artículos

### `GET /api/items`
Listado público de artículos publicados. Admite filtros por query string.

**Query params opcionales:**
| Param | Tipo | Ejemplo |
|---|---|---|
| `category` | string (slug) | `portatiles-gaming` |
| `brand` | string (slug) | `apple` |
| `minPrice` | number | `100` |
| `maxPrice` | number | `500` |
| `condition` | string | `new` · `like_new` · `good` · `fair` · `poor` |
| `search` | string | `macbook` |

**Respuesta 200:**
```json
[
  {
    "id": 1,
    "title": "MacBook Pro M3",
    "model": "MBP 14 2024",
    "price": "1200.00",
    "item_condition": "like_new",
    "status": "published",
    "created_at": "2026-01-01T00:00:00.000Z",
    "category_id": 10,
    "category_name": "Portátiles gaming",
    "brand_id": 1,
    "brand_name": "Apple",
    "user_id": 3,
    "username": "user_sofia",
    "cover_photo": "/uploads-imagen/img-123.jpg"
  }
]
```

---

### `GET /api/items/:id`
Detalle de un artículo con todas sus fotos.

**Respuesta 200:**
```json
{
  "id": 1,
  "title": "MacBook Pro M3",
  "description": "En perfecto estado...",
  "specs": { "ram": "16GB", "storage": "512GB" },
  "price": "1200.00",
  "item_condition": "like_new",
  "status": "published",
  "category_id": 10,
  "category_name": "Portátiles gaming",
  "brand_id": 1,
  "brand_name": "Apple",
  "user_id": 3,
  "username": "user_sofia",
  "avatar_url": null,
  "photos": [
    { "id": 1, "url": "/uploads-imagen/img-123.jpg", "sort_order": 0 }
  ]
}
```

**Errores:** `404` no encontrado

---

### `POST /api/items` 🔒
Crear un artículo nuevo.

**Body:**
```json
{
  "title": "MacBook Pro M3",
  "category_id": 10,
  "brand_id": 1,
  "model": "MBP 14 2024",
  "description": "En perfecto estado...",
  "specs": { "ram": "16GB" },
  "price": 1200,
  "item_condition": "like_new",
  "status": "draft"
}
```
> `status` puede ser `draft` o `published`. Por defecto `draft`.

**Respuesta 201:**
```json
{ "id": 5 }
```

**Errores:** `400` campos faltantes · `404` categoría o marca no existe

---

### `PUT /api/items/:id` 🔒
Editar un artículo. Solo el propietario o admin.

**Body:** igual que POST.

**Respuesta 200:**
```json
{ "id": 5, "title": "MacBook Pro M3", ... }
```

**Errores:** `403` no es el propietario · `404` no encontrado

---

### `DELETE /api/items/:id` 🔒
Eliminar un artículo. Solo el propietario o admin.

**Respuesta:** `204 No Content`

**Errores:** `403` · `404`

---

### `PATCH /api/items/:id/sell` 🔒
Marcar el artículo como vendido. Solo el propietario.

**Respuesta 200:**
```json
{ "id": 5, "status": "sold" }
```

---

### `GET /api/users/:id/items`
Artículos publicados por un usuario concreto.

**Respuesta 200:** array igual que `GET /api/items`

---

## Fotos

### `POST /api/items/:id/photos` 🔒
Subir una foto a un artículo. Solo el propietario. Máximo 5 MB, formatos JPG/PNG.

**Body:** `multipart/form-data`
| Campo | Tipo |
|---|---|
| `image` | archivo (JPG, PNG) |

**Respuesta 201:**
```json
{
  "success": true,
  "photo": {
    "id": 3,
    "item_id": 5,
    "url": "/uploads-imagen/img-1234567890.jpg"
  }
}
```

**Errores:** `403` no es el propietario · `404` artículo no encontrado

---

### `DELETE /api/items/:id/photos/:photoId` 🔒
Eliminar una foto. Solo el propietario del artículo.

**Respuesta 200:**
```json
{ "success": true, "message": "La imagen ha sido eliminada por completo del servidor." }
```

---

## Usuarios

### `GET /api/users` 🔒 `admin`
Listado de usuarios con filtros.

**Query params opcionales:** `search`, `role` (`user`/`moderator`/`admin`), `status` (`active`/`blocked`/`deleted`)

**Respuesta 200:** array de usuarios (sin `password_hash`)

---

### `GET /api/users/:id`
Perfil público de un usuario.

**Respuesta 200:**
```json
{
  "id": 3,
  "username": "user_sofia",
  "role": "user",
  "status": "active",
  "avatar_url": null,
  "created_at": "2026-01-01T00:00:00.000Z"
}
```

---

### `PUT /api/users/:id` 🔒
Editar perfil. Solo el propietario o admin.

**Body:**
```json
{
  "username": "nuevo_nombre",
  "email": "nuevo@example.com",
  "avatar_url": "https://..."
}
```

---

### `PATCH /api/users/:id/role` 🔒 `admin`
Cambiar el rol de un usuario.

**Body:**
```json
{ "role": "moderator" }
```
> Valores: `user` · `moderator` · `admin`

---

### `PATCH /api/users/:id/status` 🔒 `admin` `moderator`
Bloquear o desbloquear un usuario.

**Body:**
```json
{ "status": "blocked" }
```
> Valores: `active` · `blocked`

---

### `DELETE /api/users/:id` 🔒
Eliminar cuenta (soft delete). Solo el propietario o admin.

**Respuesta:** `204 No Content`

---

## Categorías

### `GET /api/categories`
Listado de categorías. Público.

**Respuesta 200:**
```json
[
  { "id": 1, "name": "Portátiles" },
  { "id": 10, "name": "Portátiles gaming" }
]
```

### `POST /api/categories` 🔒 `admin`
**Body:** `{ "name": "Nueva categoría" }`
**Respuesta 201:** `{ "id": 35, "name": "Nueva categoría" }`

### `PUT /api/categories/:id` 🔒 `admin`
**Body:** `{ "name": "Nombre actualizado" }`

### `DELETE /api/categories/:id` 🔒 `admin`
**Respuesta:** `204` · `400` si tiene artículos asociados

---

## Marcas

### `GET /api/brands`
Listado de marcas. Público.

**Respuesta 200:**
```json
[
  { "id": 1, "name": "Apple", "slug": "apple", "logo_url": null }
]
```

### `POST /api/brands` 🔒 `admin`
**Body:** `{ "name": "Nueva marca", "logo_url": "https://..." }`
**Respuesta 201:** `{ "id": 19, "name": "Nueva marca", "logo_url": null }`

### `PUT /api/brands/:id` 🔒 `admin`
**Body:** `{ "name": "Nombre actualizado", "logo_url": null }`

### `DELETE /api/brands/:id` 🔒 `admin`
**Respuesta:** `204` · `400` si tiene artículos asociados

---

## Favoritos

Todos los endpoints requieren autenticación 🔒

### `GET /api/favorites`
Mis artículos favoritos.

**Respuesta 200:**
```json
[
  {
    "item_id": 1,
    "title": "MacBook Pro M3",
    "price": "1200.00",
    "item_condition": "like_new",
    "status": "published"
  }
]
```

### `POST /api/favorites`
Añadir a favoritos.

**Body:** `{ "item_id": 1 }`
**Respuesta 201:** `{ "user_id": 2, "item_id": 1 }`
**Errores:** `404` artículo no existe · `409` ya está en favoritos

### `DELETE /api/favorites/:id`
Quitar de favoritos. `:id` es el `item_id`.

**Respuesta:** `204 No Content`

---

## Mensajes

Todos los endpoints requieren autenticación 🔒

### `GET /api/messages/conversations`
Lista de conversaciones del usuario autenticado, ordenadas por actividad reciente.

**Respuesta 200:**
```json
[
  {
    "id": 2,
    "item_id": 1,
    "item_title": "MacBook Pro M3",
    "buyer_id": 7,
    "buyer_name": "user_carlos",
    "seller_id": 3,
    "seller_name": "user_sofia",
    "last_message": "Hola, ¿sigue disponible?",
    "last_message_at": "2026-01-01T10:00:00.000Z",
    "unread_count": 1
  }
]
```

---

### `PATCH /api/messages/:id/read`
Marcar un mensaje como leído. Solo puede hacerlo el destinatario.

**Respuesta 200:** `{ "ok": true }`

**Errores:** `404` mensaje no encontrado o no eres el destinatario

---

### `POST /api/messages`
Enviar un mensaje a un vendedor sobre un artículo. Crea la conversación automáticamente si no existe.

**Body:**
```json
{
  "item_id": 1,
  "receiver_id": 3,
  "message_text": "Hola, ¿sigue disponible?"
}
```

**Respuesta 201:**
```json
{
  "success": true,
  "data": {
    "id": 5,
    "conversation_id": 2,
    "sender_id": 7,
    "content": "Hola, ¿sigue disponible?"
  }
}
```

### `GET /api/messages/inbox`
Mensajes recibidos del usuario autenticado.

**Respuesta 200:**
```json
{
  "success": true,
  "count": 2,
  "messages": [
    {
      "id": 5,
      "content": "Hola, ¿sigue disponible?",
      "sent_at": "2026-01-01T10:00:00.000Z",
      "is_read": false,
      "item_id": 1,
      "sender_name": "user_carlos",
      "item_title": "MacBook Pro M3"
    }
  ]
}
```

### `GET /api/messages/chat/:itemId/:userId`
Historial de mensajes entre el usuario autenticado y otro usuario sobre un artículo concreto.

**Respuesta 200:**
```json
{
  "success": true,
  "messages": [
    {
      "id": 5,
      "content": "Hola, ¿sigue disponible?",
      "sent_at": "2026-01-01T10:00:00.000Z",
      "is_read": false,
      "sender_name": "user_carlos"
    }
  ]
}
```

---

## Reportes

### `POST /api/reports` 🔒
Reportar un artículo. El artículo pasa automáticamente a `under_review`.

**Body:**
```json
{
  "item_id": 1,
  "reason": "El precio parece fraudulento"
}
```

**Respuesta 201:**
```json
{ "id": 7, "item_id": 1, "reason": "...", "status": "pending" }
```

**Errores:** `400` es tu propio artículo · `404` artículo no existe · `409` ya tienes un reporte pendiente

---

### `GET /api/reports` 🔒 `moderator` `admin`
Listado de reportes. Por defecto solo pendientes.

**Query params:** `status` (`pending` / `resolved_active` / `resolved_removed`)

**Respuesta 200:**
```json
[
  {
    "id": 3,
    "reason": "Artículo sospechoso",
    "status": "pending",
    "created_at": "2026-01-01T00:00:00.000Z",
    "item_id": 5,
    "item_title": "MacBook Pro M3",
    "reporter_id": 7,
    "reporter_username": "user_carlos",
    "moderator_id": null,
    "moderator_username": null
  }
]
```

---

### `GET /api/reports/:id` 🔒 `moderator` `admin`
Detalle de un reporte.

---

### `PATCH /api/reports/:id/resolve` 🔒 `moderator` `admin`
Resolver un reporte.

**Body:**
```json
{
  "resolution": "resolved_active",
  "moderator_note": "Revisado, artículo correcto"
}
```
> `resolution`: `resolved_active` → artículo vuelve a `published` · `resolved_removed` → artículo pasa a `removed`

**Respuesta 200:**
```json
{ "id": 3, "status": "resolved_active", "item_status": "published" }
```

---

## Estadísticas

### `GET /api/admin/stats` 🔒 `admin`
Estadísticas globales de la plataforma para el panel de administración.

**Respuesta 200:**
```json
{
  "users": {
    "active": 42,
    "blocked": 3,
    "deleted": 1,
    "total": 46
  },
  "items": {
    "published": 120,
    "draft": 15,
    "under_review": 4,
    "sold": 30,
    "removed": 2,
    "total": 171
  },
  "reports": {
    "pending": 4,
    "resolved_active": 10,
    "resolved_removed": 2,
    "total": 16
  },
  "recent": {
    "published_last_30d": 25
  }
}
```

---

## Códigos de respuesta comunes

| Código | Significado |
|---|---|
| `200` | OK |
| `201` | Creado |
| `204` | Sin contenido (borrado correcto) |
| `400` | Petición incorrecta (campo faltante o inválido) |
| `401` | Token no proporcionado o inválido |
| `403` | Sin permisos para esta acción |
| `404` | Recurso no encontrado |
| `409` | Conflicto (duplicado) |
| `500` | Error interno del servidor |

Todos los errores devuelven:
```json
{ "error": "Descripción del error en español" }
```

---

## Roles

| Rol | Permisos adicionales |
|---|---|
| `user` | Operaciones propias (artículos, favoritos, mensajes, reportes) |
| `moderator` | Ver y resolver reportes, bloquear usuarios |
| `admin` | Todo lo anterior + gestión de usuarios, categorías y marcas |
