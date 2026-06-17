const FavoriteModel = require('../models/favorite.model');

async function list(req, res) {
  const userId = req.user?.id;
  if (!userId) {
    return res.status(401).json({ error: 'Autenticación requerida' });
  }

  const favorites = await FavoriteModel.findAllByUser(userId);
  res.json(favorites);
}

async function create(req, res) {
  const userId = req.user?.id;
  if (!userId) {
    return res.status(401).json({ error: 'Autenticación requerida' });
  }

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
    return res.status(409).json({ error: 'Artículo ya está en favoritos' });
  }

  await FavoriteModel.create({ userId, itemId: item_id });
  res.status(201).json({ user_id: userId, item_id });
}

async function remove(req, res) {
  const userId = req.user?.id;
  if (!userId) {
    return res.status(401).json({ error: 'Autenticación requerida' });
  }

  const itemId = req.params.id;

  const favorite = await FavoriteModel.findByUserAndItem(userId, itemId);
  if (!favorite) {
    return res.status(404).json({ error: 'Favorito no encontrado' });
  }

  await FavoriteModel.remove(userId, itemId);
  res.status(204).send();
}

module.exports = { list, create, remove };