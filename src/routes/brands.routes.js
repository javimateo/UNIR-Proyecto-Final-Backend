const router = require('express').Router();
const brandsController = require('../controllers/brands.controller');
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');

/**
 * @swagger
 * tags:
 *   name: Brands
 *   description: Gestión de marcas
 */

/**
 * @swagger
 * /api/brands:
 *   get:
 *     summary: Listado de marcas
 *     tags: [Brands]
 *     responses:
 *       200:
 *         description: Lista de marcas
 */
router.get('/', brandsController.list);

/**
 * @swagger
 * /api/brands:
 *   post:
 *     summary: Crear marca (solo admin)
 *     tags: [Brands]
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
 *               logo_url: { type: string }
 *     responses:
 *       201:
 *         description: Marca creada
 */
router.post('/', requireAuth, requireRole('admin'), brandsController.create);

/**
 * @swagger
 * /api/brands/{id}:
 *   put:
 *     summary: Editar marca (solo admin)
 *     tags: [Brands]
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
 *               logo_url: { type: string }
 *     responses:
 *       200:
 *         description: Marca actualizada
 *       404:
 *         description: Marca no encontrada
 */
router.put('/:id', requireAuth, requireRole('admin'), brandsController.update);

/**
 * @swagger
 * /api/brands/{id}:
 *   delete:
 *     summary: Eliminar marca (solo admin)
 *     tags: [Brands]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       204:
 *         description: Marca eliminada
 *       400:
 *         description: La marca tiene artículos asociados
 *       404:
 *         description: Marca no encontrada
 */
router.delete('/:id', requireAuth, requireRole('admin'), brandsController.remove);

module.exports = router;
