const router = require('express').Router();
const itemsController = require('../controllers/items.controller');

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Recursos públicos de usuario
 */

/**
 * @swagger
 * /api/users/{id}/items:
 *   get:
 *     summary: Artículos publicados por un usuario
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Lista de artículos del usuario
 */
router.get('/:id/items', itemsController.getUserItems);

module.exports = router;
