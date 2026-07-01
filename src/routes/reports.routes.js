const router = require('express').Router();
const reportsController = require('../controllers/reports.controller');
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');

/**
 * @swagger
 * tags:
 *   name: Reports
 *   description: Sistema de reportes y moderación
 */

/**
 * @swagger
 * /api/reports:
 *   get:
 *     summary: Listado de reportes (moderador o admin)
 *     tags: [Reports]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: status
 *         schema: { type: string, enum: [pending, resolved_active, resolved_removed] }
 *         description: Filtrar por estado (por defecto devuelve solo pendientes)
 *     responses:
 *       200:
 *         description: Lista de reportes
 */
router.get('/', requireAuth, requireRole('moderator', 'admin'), reportsController.listReports);

/**
 * @swagger
 * /api/reports/{id}:
 *   get:
 *     summary: Detalle de un reporte (moderador o admin)
 *     tags: [Reports]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Detalle del reporte
 *       404:
 *         description: Reporte no encontrado
 */
router.get('/:id', requireAuth, requireRole('moderator', 'admin'), reportsController.getReport);

/**
 * @swagger
 * /api/reports:
 *   post:
 *     summary: Reportar un artículo
 *     tags: [Reports]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [item_id, reason]
 *             properties:
 *               item_id: { type: integer }
 *               reason: { type: string }
 *     responses:
 *       201:
 *         description: Reporte creado, artículo pasa a under_review
 *       409:
 *         description: Ya existe un reporte pendiente del mismo usuario sobre este artículo
 */
router.post('/', requireAuth, reportsController.createReport);

/**
 * @swagger
 * /api/reports/{id}/resolve:
 *   patch:
 *     summary: Resolver un reporte (moderador o admin)
 *     tags: [Reports]
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
 *             required: [resolution]
 *             properties:
 *               resolution: { type: string, enum: [resolved_active, resolved_removed] }
 *               moderator_note: { type: string }
 *     responses:
 *       200:
 *         description: Reporte resuelto y artículo actualizado
 *       400:
 *         description: Reporte ya resuelto o resolución inválida
 */
router.patch('/:id/resolve', requireAuth, requireRole('moderator', 'admin'), reportsController.resolveReport);

module.exports = router;
