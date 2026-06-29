const express = require('express');
const router = express.Router();
const itemsController = require('../controllers/items.controller');

// Endpoints de gestión integral de artículos (Fase 2)
router.get('/', itemsController.getItems);
router.get('/:id', itemsController.getItemById);
router.post('/', itemsController.createItem);
router.put('/:id', itemsController.updateItem);
router.delete('/:id', itemsController.deleteItem);
router.patch('/:id/sell', itemsController.sellItem);

module.exports = router;