const express = require('express');
const cors = require('cors');
const path = require('path');

// ==========================================
// 1. IMPORTACIÓN DE RUTAS (Tus módulos)
// ==========================================
// Importamos el módulo de mensajes que acabamos de crear
const messagesRoutes = require('./routes/messages.routes');

// Nota: Cuando tus compañeros terminen sus módulos, sus rutas se importarán aquí:
// const itemsRoutes = require('./routes/items.routes');
// const authRoutes = require('./routes/auth.routes');

// ==========================================
// 2. CONFIGURACIÓN DEL SERVIDOR
// ==========================================
const app = express();

// Middlewares globales necesarios
app.use(cors());
app.use(express.json()); // Permite al servidor entender datos en formato JSON

// Configuración para la carpeta de imágenes subidas (del módulo anterior)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// ==========================================
// 3. REGISTRO DE ENDPOINTS (Rutas del API)
// ==========================================
// Registramos oficialmente el prefijo para los mensajes
app.use('/api/messages', messagesRoutes);

// Nota: Cuando tus compañeros unan su código, registrarán sus rutas aquí:
// app.use('/api/items', itemsRoutes);
// app.use('/api/auth', authRoutes);

// Ruta de cortesía para comprobar desde el navegador que el backend responde
app.get('/', (req, res) => {
    res.send('🚀 El servidor del Proyecto Final está corriendo perfectamente.');
});

// ==========================================
// 4. GESTOR GLOBAL DE ERRORES
// ==========================================
app.use((err, req, res, next) => {
    console.error('❌ Error detectado en el servidor:', err.stack);
    res.status(500).json({
        success: false,
        message: 'Ha ocurrido un error interno en el servidor.',
        error: err.message
    });
});

// ==========================================
// 5. ARRANQUE DEL SERVIDOR
// ==========================================
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`==================================================`);
    console.log(`🚀 SERVIDOR CORRIENDO EN: http://localhost:${PORT}`);
    console.log(`📂 Estructura de carpetas directa en la Raíz Activa`);
    console.log(`==================================================`);
});