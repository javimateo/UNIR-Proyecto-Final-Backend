const express = require('express');
const router = express.Router();

// Importamos el controlador
const messagesController = require('../controllers/messages.controller');

// Importamos el middleware que acabamos de arreglar arriba
const verifyToken = require('../middlewares/auth.middleware');

// Definición de rutas asociadas a sus funciones del controlador
router.post('/', verifyToken, messagesController.sendMessage);
router.get('/inbox', verifyToken, messagesController.getInbox);
router.get('/chat/:itemId/:userId', verifyToken, messagesController.getChatHistory);

module.exports = router;