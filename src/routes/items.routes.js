const router = require('express').Router();
const requireAuth = require('../middlewares/auth.middleware');
const itemsController = require('../controllers/items.controller');

router.get('/', itemsController.list);
router.get('/:id', itemsController.getById);
router.post('/', requireAuth, itemsController.create);
router.put('/:id', requireAuth, itemsController.update);
router.delete('/:id', requireAuth, itemsController.remove);

module.exports = router;