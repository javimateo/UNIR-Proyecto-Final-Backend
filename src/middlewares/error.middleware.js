/**
 * Middleware global para la gestión centralizada de excepciones y errores (Fase 2 y 3)
 */
const errorMiddleware = (err, req, res, next) => {
    console.error(`[SERVER ERROR] ❌:`, err.stack || err.message || err);

    // Si es un error de Multer al subir archivos (ej: tamaño excesivo o formato incorrecto)
    if (err.code === 'LIMIT_FILE_SIZE') {
        return res.status(400).json({
            success: false,
            message: 'La imagen es demasiado pesada. El límite máximo admitido es de 5MB.'
        });
    }

    // Respuesta genérica para cualquier otra excepción interna del backend
    const statusCode = err.statusCode || 500;
    const message = err.message || 'Ha ocurrido un error interno en el servidor de Telemarket.';

    res.status(statusCode).json({
        success: false,
        status: statusCode,
        message: message
    });
};

module.exports = errorMiddleware;