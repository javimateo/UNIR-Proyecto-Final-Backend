const router = require('express').Router();
const requireAuth = require('../middlewares/auth.middleware');
const favoritesController = require('../controllers/favorites.controller');

router.use(requireAuth);

router.get('/', favoritesController.list);
router.post('/', favoritesController.create);
router.delete('/:id', favoritesController.remove);

module.exports = router;