require('dotenv').config();
const app = require('./src/app');

// Recuperamos el puerto desde las variables de entorno (.env) o usamos el 3000 por defecto
const PORT = process.env.PORT || 3000;

// Ponemos el servidor en escucha
app.listen(PORT, () => {
    console.log(`\n==================================================`);
    console.log(`🚀 SERVIDOR CORRIENDO EN: http://localhost:${PORT}`);
    console.log(`📂 Modo Estructura Modular 'src' Activa`);
    console.log(`==================================================\n`);
});