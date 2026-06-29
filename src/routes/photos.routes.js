const express = require('express');
const router = express.Router();

const photosController = require('../controllers/photos.controller');
const upload = require('../middlewares/upload.middleware');
// 📝 CORRECCIÓN PUNTO 2: Importamos el middleware de autenticación real del proyecto
const verifyToken = require('../middlewares/auth.middleware');

// Endpoints modulares protegidos para la gestión de archivos multimedia

// POST /api/items/:id/photos -> 🛡️ Protegido con token
router.post('/:id/photos', verifyToken, upload.single('image'), photosController.uploadPhoto);

// DELETE /api/items/:id/photos/:photoId -> 🛡️ Protegido con token
router.delete('/:id/photos/:photoId', verifyToken, photosController.deletePhoto);

module.exports = router;