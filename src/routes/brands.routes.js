const router = require('express').Router();
const brandsController = require('../controllers/brands.controller');
const requireAuth = require('../middlewares/auth.middleware');
const requireRole = require('../middlewares/role.middleware');

router.get('/', brandsController.list);
router.post('/', requireAuth, requireRole('admin'), brandsController.create);
router.put('/:id', requireAuth, requireRole('admin'), brandsController.update);
router.delete('/:id', requireAuth, requireRole('admin'), brandsController.remove);

module.exports = router;
