const router = require('express').Router();
const requireAuth = require('../middlewares/auth.middleware');
const favoritesController = require('../controllers/favorites.controller');

/**
 * @swagger
 * tags:
 *   name: Favorites
 *   description: Gestión de favoritos del usuario
 */

router.use(requireAuth);

/**
 * @swagger
 * /api/favorites:
 *   get:
 *     summary: Listar mis favoritos
 *     tags: [Favorites]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de artículos favoritos del usuario
 */
router.get('/', favoritesController.list);

/**
 * @swagger
 * /api/favorites:
 *   post:
 *     summary: Añadir artículo a favoritos
 *     tags: [Favorites]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [item_id]
 *             properties:
 *               item_id: { type: integer }
 *     responses:
 *       201:
 *         description: Artículo añadido a favoritos
 *       404:
 *         description: Artículo no encontrado
 *       409:
 *         description: El artículo ya está en favoritos
 */
router.post('/', favoritesController.create);

/**
 * @swagger
 * /api/favorites/{id}:
 *   delete:
 *     summary: Quitar artículo de favoritos
 *     tags: [Favorites]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *         description: ID del artículo
 *     responses:
 *       204:
 *         description: Artículo eliminado de favoritos
 *       404:
 *         description: Favorito no encontrado
 */
router.delete('/:id', favoritesController.remove);

module.exports = router;
