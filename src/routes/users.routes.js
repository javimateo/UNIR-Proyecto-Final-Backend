const router = require('express').Router();
const itemsController = require('../controllers/items.controller');
const usersController = require('../controllers/users.controller');
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Gestión de usuarios
 */

/**
 * @swagger
 * /api/users:
 *   get:
 *     summary: Listado de usuarios con filtros (solo admin)
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: search
 *         schema: { type: string }
 *         description: Buscar por username o email
 *       - in: query
 *         name: role
 *         schema: { type: string, enum: [user, moderator, admin] }
 *       - in: query
 *         name: status
 *         schema: { type: string, enum: [active, blocked, deleted] }
 *     responses:
 *       200:
 *         description: Lista de usuarios
 *       403:
 *         description: Acceso denegado
 */
router.get('/', requireAuth, requireRole('admin'), usersController.listUsers);

/**
 * @swagger
 * /api/users/{id}:
 *   get:
 *     summary: Perfil público de un usuario
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       200:
 *         description: Perfil del usuario
 *       404:
 *         description: Usuario no encontrado
 */
router.get('/:id', usersController.getUser);

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

/**
 * @swagger
 * /api/users/{id}:
 *   put:
 *     summary: Editar perfil (propietario o admin)
 *     tags: [Users]
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
 *             required: [username, email]
 *             properties:
 *               username: { type: string }
 *               email: { type: string }
 *               avatar_url: { type: string }
 *     responses:
 *       200:
 *         description: Usuario actualizado
 *       403:
 *         description: Acceso denegado
 *       404:
 *         description: Usuario no encontrado
 */
router.put('/:id', requireAuth, usersController.updateUser);

/**
 * @swagger
 * /api/users/{id}/role:
 *   patch:
 *     summary: Cambiar rol de un usuario (solo admin)
 *     tags: [Users]
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
 *             required: [role]
 *             properties:
 *               role: { type: string, enum: [user, moderator, admin] }
 *     responses:
 *       200:
 *         description: Rol actualizado
 *       404:
 *         description: Usuario no encontrado
 */
router.patch('/:id/role', requireAuth, requireRole('admin'), usersController.updateRole);

/**
 * @swagger
 * /api/users/{id}/status:
 *   patch:
 *     summary: Bloquear o desbloquear un usuario (admin o moderador)
 *     tags: [Users]
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
 *             required: [status]
 *             properties:
 *               status: { type: string, enum: [active, blocked] }
 *     responses:
 *       200:
 *         description: Estado actualizado
 *       404:
 *         description: Usuario no encontrado
 */
router.patch('/:id/status', requireAuth, requireRole('admin', 'moderator'), usersController.updateStatus);

/**
 * @swagger
 * /api/users/{id}:
 *   delete:
 *     summary: Eliminar cuenta (soft delete, propietario o admin)
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema: { type: integer }
 *     responses:
 *       204:
 *         description: Cuenta eliminada
 *       403:
 *         description: Acceso denegado
 *       404:
 *         description: Usuario no encontrado
 */
router.delete('/:id', requireAuth, usersController.deleteUser);

module.exports = router;
