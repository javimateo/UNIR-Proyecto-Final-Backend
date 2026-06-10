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
Documentación interactiva (Swagger): `http://localhost:3000/api/docs`

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
├── config/       # Configuración de DB y Swagger
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

---

## Guía de desarrollo — Git Flow

### Estructura de ramas

| Rama | Uso |
|------|-----|
| `main` | Código estable. Solo recibe merges desde `develop`. |
| `develop` | Rama base del equipo. Punto de partida para todo. |
| `feature/<nombre>` | Nueva funcionalidad. Sale de `develop`, vuelve a `develop` via PR. |
| `fix/<nombre>` | Corrección de bug. Sale de `develop`, vuelve a `develop` via PR. |
| `docs/<nombre>` | Cambios de documentación. Sale de `develop`, vuelve a `develop` via PR. |

### Flujo de trabajo

**1. Antes de empezar, sincroniza `develop`:**
```bash
git checkout develop
git pull origin develop
```

**2. Crea tu rama:**
```bash
git checkout -b feature/fase-2-items
# o
git checkout -b fix/login-token-expiry
```

**3. Trabaja y commitea:**
```bash
git add <ficheros>
git commit -m "feat: descripción del cambio"
```

**4. Sube tu rama y abre un Pull Request:**
```bash
git push origin feature/fase-2-items
# En GitHub: New Pull Request → base: develop ← compare: feature/fase-2-items
```

### Convención de mensajes de commit

```
feat: nueva funcionalidad
fix: corrección de bug
docs: cambio de documentación
refactor: cambio de código sin nueva funcionalidad ni bug
chore: tareas de mantenimiento (deps, config, etc.)
```

### Pull Requests

- Cada rama se integra en `develop` exclusivamente mediante PR.
- El autor del PR **no** lo mergea — lo revisa y aprueba otro miembro del equipo.
- Antes de aprobar, el revisor comprueba que el código sigue las convenciones del proyecto.
- Una vez aprobado, cualquiera de los dos puede hacer el merge.
- Borrar la rama después del merge (GitHub lo ofrece automáticamente).

### Resolución de conflictos

Si `develop` ha avanzado mientras trabajabas en tu rama:
```bash
git checkout develop
git pull origin develop
git checkout feature/mi-rama
git merge develop
# Resolver conflictos, luego:
git add .
git commit -m "chore: merge develop into feature/mi-rama"
git push
```
prueba de git