const router = require('express').Router();
const requireAuth = require('../middlewares/auth.middleware');
const itemsController = require('../controllers/items.controller');

/**
 * @swagger
 * tags:
 *   name: Items
 *   description: CRUD de artículos
 */

/**
 * @swagger
 * /api/items:
 *   get:
 *     summary: Listado de artículos publicados con filtros opcionales
 *     tags: [Items]
 *     parameters:
 *       - in: query
 *         name: category
 *         schema: { type: string }
 *         description: Slug de categoría
 *       - in: query
 *         name: brand
 *         schema: { type: string }
 *         description: Slug de marca
 *       - in: query
 *         name: minPrice
 *         schema: { type: number }
 *       - in: query
 *         name: maxPrice
 *         schema: { type: number }
 *       - in: query
 *         name: condition
 *         schema: { type: string, enum: [new, like_new, good, fair, poor] }
 *       - in: query
 *         name: search
 *         schema: { type: string }
 *         description: Búsqueda por título
 *     responses:
 *       200:
 *         description: Lista de artículos
 */
router.get('/', itemsController.getItems);

/**
 * @swagger
 * /api/items/{id}:
 *   get:
 *     summary: Detalle de un artículo
 *     tags: [Items]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Datos del artículo
 *       404:
 *         description: Artículo no encontrado
 */
router.get('/:id', itemsController.getItem);

/**
 * @swagger
 * /api/items:
 *   post:
 *     summary: Crear un nuevo artículo
 *     tags: [Items]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [category_id, title, price, item_condition]
 *             properties:
 *               category_id:  { type: integer }
 *               brand_id:     { type: integer }
 *               title:        { type: string }
 *               model:        { type: string }
 *               description:  { type: string }
 *               specs:        { type: object }
 *               price:        { type: number }
 *               item_condition:
 *                 type: string
 *                 enum: [new, like_new, good, fair, poor]
 *               status:
 *                 type: string
 *                 enum: [draft, published]
 *     responses:
 *       201:
 *         description: Artículo creado
 *       400:
 *         description: Datos inválidos o categoría/marca inexistente
 */
router.post('/', requireAuth, itemsController.createItem);

/**
 * @swagger
 * /api/items/{id}:
 *   put:
 *     summary: Editar un artículo (solo propietario o admin)
 *     tags: [Items]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Artículo actualizado
 *       403:
 *         description: Sin permiso
 *       404:
 *         description: Artículo no encontrado
 */
router.put('/:id', requireAuth, itemsController.updateItem);

/**
 * @swagger
 * /api/items/{id}:
 *   delete:
 *     summary: Eliminar un artículo (solo propietario o admin)
 *     tags: [Items]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Artículo eliminado
 *       403:
 *         description: Sin permiso
 *       404:
 *         description: Artículo no encontrado
 */
router.delete('/:id', requireAuth, itemsController.deleteItem);

/**
 * @swagger
 * /api/items/{id}/sell:
 *   patch:
 *     summary: Marcar artículo como vendido (solo propietario)
 *     tags: [Items]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Artículo marcado como vendido
 *       400:
 *         description: El artículo no está publicado
 *       403:
 *         description: Sin permiso
 *       404:
 *         description: Artículo no encontrado
 */
router.patch('/:id/sell', requireAuth, itemsController.sellItem);

module.exports = router;
