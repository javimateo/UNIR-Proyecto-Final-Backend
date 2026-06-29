const express = require('express');
const cors = require('cors');
const path = require('path');

// Importaciones del núcleo
const itemsRoutes = require('./routes/items.routes');
const photosRoutes = require('./routes/photos.routes');
const errorMiddleware = require('./middlewares/error.middleware');

const app = express();

// Middlewares globales básicos
app.use(cors());
app.use(express.json());

// Servir la carpeta física de imágenes de manera estática
app.use('/uploads-imagen', express.static(path.join(__dirname, '../uploads-imagen')));

// Asociación de endpoints modulares
app.use('/api/items', itemsRoutes);
app.use('/api/items', photosRoutes);

// Manejador global de errores (Debe ser obligatoriamente el último app.use)
app.use(errorMiddleware);

module.exports = app;