// ... (Tus imports de express, cors, etc., están arriba)

// ==========================================
// 📸 CONTROL DE RUTAS: MONTAJE COHERENTE
// ==========================================

// Forzamos que el enrutador de fotos cuelgue de /api/items
app.use('/api/items', require('./routes/photos.routes'));

// Aquí tienes tu línea 22 original:
// Manejo de rutas no encontradas (404)
app.use((req, res, next) => {
    res.status(404).json({ message: "Endpoint no encontrado" });
});

// Middleware de error global
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ message: "Error interno del servidor" });
});

module.exports = app;