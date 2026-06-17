const express = require('express');
const router = express.Router();
const imageController = require('../controllers/image.controller');
const uploadMiddleware = require('../middlewares/upload.middleware');

// La documentación de esta ruta ahora se gestiona de forma segura en config/swagger.js
router.post('/', uploadMiddleware.single('image'), imageController.uploadImage);

module.exports = router;