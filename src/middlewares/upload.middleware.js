const multer = require('multer');
const path = require('path');

// Configuración del motor de almacenamiento de Multer
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        // Al estar en src/middlewares/, subimos dos niveles ('../../') 
        // para salir a la raíz real donde está la carpeta 'uploads-imagen'
        cb(null, path.join(__dirname, '../../uploads-imagen'));
    },
    filename: (req, file, cb) => {
        // Generamos un nombre único: img-timestamp.extensión
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, `img-${uniqueSuffix}${path.extname(file.originalname)}`);
    }
});

// Filtro de validación de formatos (Solo imágenes)
const fileFilter = (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
    
    if (allowedTypes.includes(file.mimetype)) {
        cb(null, true); // Aceptar archivo
    } else {
        cb(new Error('Formato de archivo no válido. Solo se admiten JPG, JPEG y PNG.'), false);
    }
};

const upload = multer({
    storage: storage,
    fileFilter: fileFilter,
    limits: {
        fileSize: 5 * 1024 * 1024 // Límite máximo: 5MB
    }
});

module.exports = upload;