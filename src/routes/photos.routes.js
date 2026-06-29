const express = require('express');
const router = express.Router();

const photosController = require('../controllers/photos.controller');
const upload = require('../middlewares/upload.middleware');

// Endpoints modulares para la gestión de archivos multimedia
// Nota: Se omite temporalmente el middleware de autenticación para facilitar las pruebas locales

// POST /api/items/:id/photos -> Recibe un archivo binario en el campo 'image'
router.post('/:id/photos', upload.single('image'), photosController.uploadPhoto);

// DELETE /api/items/:id/photos/:photoId -> Elimina una imagen del servidor
router.delete('/:id/photos/:photoId', photosController.deletePhoto);

module.exports = router;