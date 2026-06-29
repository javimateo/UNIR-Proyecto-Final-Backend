const FavoriteModel = require('../models/favorite.model');

async function list(req, res, next) {
  try {
    const userId = req.user.id;
    const favorites = await FavoriteModel.findAllByUser(userId);
    res.json(favorites);
  } catch (err) {
    next(err);
  }
}

async function create(req, res, next) {
  try {
    const userId = req.user.id;
    const { item_id } = req.body;

    if (!item_id) {
      return res.status(400).json({ error: 'item_id es obligatorio' });
    }

    const exists = await FavoriteModel.itemExists(item_id);
    if (!exists) {
      return res.status(404).json({ error: 'Artículo no encontrado' });
    }

    const already = await FavoriteModel.findByUserAndItem(userId, item_id);
    if (already) {
      return res.status(409).json({ error: 'El artículo ya está en favoritos' });
    }

    await FavoriteModel.create({ userId, itemId: item_id });
    res.status(201).json({ user_id: userId, item_id });
  } catch (err) {
    next(err);
  }
}

async function remove(req, res, next) {
  try {
    const userId = req.user.id;
    const itemId = req.params.id;

    const favorite = await FavoriteModel.findByUserAndItem(userId, itemId);
    if (!favorite) {
      return res.status(404).json({ error: 'Favorito no encontrado' });
    }

    await FavoriteModel.remove(userId, itemId);
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}

module.exports = { list, create, remove };
