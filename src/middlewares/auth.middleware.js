// Middleware temporal para que el servidor arranque sin depender del login de tus compañeros
const verifyToken = (req, res, next) => {
    // Simulamos que el usuario ya se ha logueado correctamente y su ID es el 1
    req.user = { id: 1 }; 
    next(); // Continuar al controlador sin trabas
};

module.exports = verifyToken;