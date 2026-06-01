# Backend — Plataforma de Compraventa de Tecnología

API REST para la plataforma de compraventa de tecnología de segunda mano.  
Proyecto Final de Máster Full Stack — UNIR.

**Stack:** Node.js · Express · MySQL

---

## Requisitos

- Node.js 18+
- MySQL 8+

## Instalación

```bash
npm install
cp .env.example .env
# Editar .env con las credenciales de la base de datos
```

## Base de datos

```bash
mysql -u root -p < ../BBDD.sql
mysql -u root -p secondhand_platform < ../seed_data.sql
```

## Ejecución

```bash
# Desarrollo (nodemon)
npm run dev

# Producción
npm start
```

La API arranca por defecto en `http://localhost:3000`.

---

## Variables de entorno

| Variable | Descripción |
|----------|-------------|
| `PORT` | Puerto del servidor (por defecto 3000) |
| `DB_HOST` | Host de MySQL |
| `DB_PORT` | Puerto de MySQL (por defecto 3306) |
| `DB_USER` | Usuario de MySQL |
| `DB_PASS` | Contraseña de MySQL |
| `DB_NAME` | Nombre de la base de datos |
| `JWT_SECRET` | Clave secreta para firmar JWT |
| `JWT_EXPIRES_IN` | Expiración del token (ej. `7d`) |

---

## Estructura

```
src/
├── config/       # Configuración de DB y variables de entorno
├── controllers/  # Lógica de cada endpoint
├── middlewares/  # Auth, roles, errores
├── models/       # Queries SQL
└── routes/       # Definición de rutas
```

---

## Roles

| Rol | Acceso |
|-----|--------|
| `user` | Publicar artículos, mensajería, favoritos, reportes |
| `moderator` | Gestión de reportes y moderación de contenidos |
| `admin` | Control total: usuarios, roles, categorías, estadísticas |
