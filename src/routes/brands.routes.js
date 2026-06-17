// src/routes/brands.routes.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => res.json({ message: 'Ruta de marcas activa' }));

module.exports = router;