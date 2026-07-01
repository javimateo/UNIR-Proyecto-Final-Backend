const express = require('express');
const router = express.Router();
const messagesController = require('../controllers/messages.controller');
const requireAuth = require('../middlewares/auth.middleware');

/**
 * @swagger
 * tags:
 *   name: Messages
 *   description: Mensajería entre compradores y vendedores
 */

/**
 * @swagger
 * /api/messages:
 *   post:
 *     summary: Enviar un mensaje (crea la conversación si no existe)
 *     tags: [Messages]
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
 *               item_id: { type: integer }
 *               receiver_id: { type: integer }
 *               message_text: { type: string }
 *     responses:
 *       201:
 *         description: Mensaje enviado
 *       404:
 *         description: Artículo no encontrado
 */
router.post('/', requireAuth, messagesController.sendMessage);

/**
 * @swagger
 * /api/messages/inbox:
 *   get:
 *     summary: Bandeja de entrada del usuario autenticado
 *     tags: [Messages]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de mensajes recibidos
 */
router.get('/inbox', requireAuth, messagesController.getInbox);

/**
 * @swagger
 * /api/messages/chat/{itemId}/{userId}:
 *   get:
 *     summary: Historial de chat entre dos usuarios sobre un artículo
 *     tags: [Messages]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: itemId
 *         required: true
 *         schema: { type: integer }
 *       - in: path
 *         name: userId
 *         required: true
 *         schema: { type: integer }
 *         description: ID del otro usuario
 *     responses:
 *       200:
 *         description: Historial de mensajes
 */
router.get('/chat/:itemId/:userId', requireAuth, messagesController.getChatHistory);

module.exports = router;
