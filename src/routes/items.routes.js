const express = require('express');
const router = express.Router();
const itemController = require('../controllers/item.controller');
const authMiddleware = require('../middlewares/auth.middleware');

// Rutas públicas (Búsqueda)
router.get('/', itemController.getItems);

// Rutas protegidas (Gestión de inventario)
router.post('/', authMiddleware, itemController.createItem);
router.put('/:id', authMiddleware, itemController.updateItem);
router.delete('/:id', authMiddleware, itemController.deleteItem);

module.exports = router;