const router = require('express').Router();
const requireAuth = require('../middlewares/auth.middleware');
const ctrl = require('../controllers/messages.controller');

/**
 * @swagger
 * tags:
 *   name: Mensajes
 *   description: Sistema de mensajería interna
 */

/**
 * @swagger
 * /api/messages/conversations:
 *   get:
 *     summary: Listar conversaciones del usuario autenticado
 *     tags: [Mensajes]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de conversaciones con último mensaje y mensajes no leídos
 */
router.get('/conversations', requireAuth, ctrl.getConversations);

/**
 * @swagger
 * /api/messages/inbox:
 *   get:
 *     summary: Mensajes recibidos por el usuario autenticado
 *     tags: [Mensajes]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de mensajes recibidos
 */
router.get('/inbox', requireAuth, ctrl.getInbox);

/**
 * @swagger
 * /api/messages/chat/{itemId}/{userId}:
 *   get:
 *     summary: Historial de chat con otro usuario sobre un artículo
 *     tags: [Mensajes]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: itemId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de mensajes del chat
 */
router.get('/chat/:itemId/:userId', requireAuth, ctrl.getChatHistory);

/**
 * @swagger
 * /api/messages:
 *   post:
 *     summary: Enviar un mensaje
 *     tags: [Mensajes]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [item_id, receiver_id, message_text]
 *             properties:
 *               item_id:
 *                 type: integer
 *               receiver_id:
 *                 type: integer
 *               message_text:
 *                 type: string
 *     responses:
 *       201:
 *         description: Mensaje enviado
 *       400:
 *         description: Campos faltantes
 *       404:
 *         description: Artículo no encontrado
 */
router.post('/', requireAuth, ctrl.sendMessage);

/**
 * @swagger
 * /api/messages/{id}/read:
 *   patch:
 *     summary: Marcar un mensaje como leído
 *     tags: [Mensajes]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Mensaje marcado como leído
 *       404:
 *         description: Mensaje no encontrado o sin permisos
 */
router.patch('/:id/read', requireAuth, ctrl.markAsRead);

module.exports = router;
