const express = require('express');
const cors = require('cors');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./config/swagger');
const errorMiddleware = require('./middlewares/error.middleware');

const app = express();

// Configuración de Middlewares base
app.use(cors());
app.use(express.json());

// 🟢 Servir carpeta de imágenes públicamente (Requisito: Gestión de fotografías)
app.use('/uploads', express.static('uploads'));

// Documentación API
app.use('/api/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Rutas base (Autenticación, Imágenes y Mensajes)
app.use('/api/auth', require('./routes/auth.routes'));
app.use('/api/messages', require('./routes/message.routes'));
app.use('/api/uploads', require('./routes/image.routes'));

// 🚀 RUTAS DEL NÚCLEO (Activadas según requisitos del proyecto)
// Gestión de artículos (Publicación, Búsqueda, Edición)
app.use('/api/items', require('./routes/items.routes'));

// Gestión de usuarios (Administrador)
app.use('/api/users', require('./routes/users.routes'));

// Gestión de categorías (Administrador)
app.use('/api/categories', require('./routes/categories.routes'));

// Gestión de reportes (Moderador - Requisito: Listado de reportes pendientes)
app.use('/api/reports', require('./routes/reports.routes'));

// Funcionalidades Deseables (Favoritos y Valoraciones)
app.use('/api/favorites', require('./routes/favorites.routes'));
app.use('/api/valuations', require('./routes/valuations.routes'));

// Manejador de errores global
app.use(errorMiddleware);

module.exports = app;