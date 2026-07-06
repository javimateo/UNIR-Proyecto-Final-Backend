const express = require('express');
const router = express.Router();

// Apunta correctamente a tu carpeta de controladores (subiendo un nivel)
const photosController = require('../controllers/photos.controller');

// =========================================================================
// ENDPOINTS: Al unirse con /api/items, el contrato de la API se cumple
// =========================================================================

// POST /api/items/:id/photos
router.post('/:id/photos', photosController.uploadPhoto);

// DELETE /api/items/:id/photos/:photoId
router.delete('/:id/photos/:photoId', photosController.deletePhoto);

module.exports = router;