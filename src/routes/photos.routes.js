const express = require('express');
const router = express.Router();
const photosController = require('../controllers/photos.controller');
const upload = require('../middlewares/upload.middleware');
const requireAuth = require('../middlewares/auth.middleware');

/**
 * @swagger
 * tags:
 *   name: Photos
 *   description: Gestión de fotos de artículos
 */

/**
 * @swagger
 * /api/items/{id}/photos:
 *   post:
 *     summary: Subir una foto a un artículo (propietario)
 *     tags: [Photos]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *         description: ID del artículo
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               image:
 *                 type: string
 *                 format: binary
 *     responses:
 *       201:
 *         description: Foto subida y vinculada al artículo
 *       403:
 *         description: El artículo no pertenece al usuario
 *       404:
 *         description: Artículo no encontrado
 */
router.post('/:id/photos', requireAuth, upload.single('image'), photosController.uploadPhoto);

/**
 * @swagger
 * /api/items/{id}/photos/{photoId}:
 *   delete:
 *     summary: Eliminar una foto de un artículo (propietario)
 *     tags: [Photos]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *         description: ID del artículo
 *       - in: path
 *         name: photoId
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Foto eliminada del servidor y la base de datos
 *       403:
 *         description: El artículo no pertenece al usuario
 *       404:
 *         description: Foto no encontrada
 */
router.delete('/:id/photos/:photoId', requireAuth, photosController.deletePhoto);

module.exports = router;
