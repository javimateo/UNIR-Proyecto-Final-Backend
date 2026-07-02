const router = require('express').Router();
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');
const { getStats } = require('../controllers/stats.controller');

/**
 * @swagger
 * tags:
 *   name: Estadísticas
 *   description: Panel de administración — estadísticas globales
 */

/**
 * @swagger
 * /api/admin/stats:
 *   get:
 *     summary: Estadísticas globales de la plataforma
 *     tags: [Estadísticas]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Contadores de usuarios, artículos, reportes y actividad reciente
 *         content:
 *           application/json:
 *             example:
 *               users:
 *                 active: 42
 *                 blocked: 3
 *                 deleted: 1
 *                 total: 46
 *               items:
 *                 published: 120
 *                 draft: 15
 *                 under_review: 4
 *                 sold: 30
 *                 removed: 2
 *                 total: 171
 *               reports:
 *                 pending: 4
 *                 resolved_active: 10
 *                 resolved_removed: 2
 *                 total: 16
 *               recent:
 *                 published_last_30d: 25
 */
router.get('/', requireAuth, requireRole('admin'), getStats);

module.exports = router;
