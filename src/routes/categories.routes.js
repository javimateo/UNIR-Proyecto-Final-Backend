const router = require('express').Router();
const categoriesController = require('../controllers/categories.controller');
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');

router.get('/', categoriesController.list);
router.post('/', requireAuth, requireRole('admin'), categoriesController.create);
router.put('/:id', requireAuth, requireRole('admin'), categoriesController.update);
router.delete('/:id', requireAuth, requireRole('admin'), categoriesController.remove);

module.exports = router;
