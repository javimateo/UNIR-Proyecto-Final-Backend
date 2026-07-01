const router = require('express').Router();
const categoriesController = require('../controllers/categories.controller');
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');

/**
 * @swagger
 * tags:
 *   name: Categories
 *   description: Gestión de categorías
 */

/**
 * @swagger
 * /api/categories:
 *   get:
 *     summary: Listado de categorías
 *     tags: [Categories]
 *     responses:
 *       200:
 *         description: Lista de categorías
 */
router.get('/', categoriesController.list);

/**
 * @swagger
 * /api/categories:
 *   post:
 *     summary: Crear categoría (solo admin)
 *     tags: [Categories]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [name]
 *             properties:
 *               name: { type: string }
 *     responses:
 *       201:
 *         description: Categoría creada
 */
router.post('/', requireAuth, requireRole('admin'), categoriesController.create);

/**
 * @swagger
 * /api/categories/{id}:
 *   put:
 *     summary: Editar categoría (solo admin)
 *     tags: [Categories]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [name]
 *             properties:
 *               name: { type: string }
 *     responses:
 *       200:
 *         description: Categoría actualizada
 *       404:
 *         description: Categoría no encontrada
 */
router.put('/:id', requireAuth, requireRole('admin'), categoriesController.update);

/**
 * @swagger
 * /api/categories/{id}:
 *   delete:
 *     summary: Eliminar categoría (solo admin)
 *     tags: [Categories]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       204:
 *         description: Categoría eliminada
 *       400:
 *         description: La categoría tiene artículos asociados
 *       404:
 *         description: Categoría no encontrada
 */
router.delete('/:id', requireAuth, requireRole('admin'), categoriesController.remove);

module.exports = router;
