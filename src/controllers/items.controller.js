const ItemModel = require('../models/item.model');

async function list(req, res) {
  const { search, category, priceMin, priceMax, sort, page = 1, limit = 10 } = req.query;

  const filters = {
    search,
    category: category ? parseInt(category) : null,
    priceMin: priceMin ? parseFloat(priceMin) : null,
    priceMax: priceMax ? parseFloat(priceMax) : null,
    sort,
    page: parseInt(page),
    limit: parseInt(limit),
  };

  const items = await ItemModel.findAll(filters);
  const total = await ItemModel.countAll(filters);
  const totalPages = Math.ceil(total / parseInt(limit));

  res.json({
    data: items,
    pagination: {
      page: parseInt(page),
      limit: parseInt(limit),
      total,
      totalPages,
    },
  });
}

async function getById(req, res) {
  const { id } = req.params;

  const item = await ItemModel.findById(id);
  if (!item) {
    return res.status(404).json({ error: 'Artículo no encontrado' });
  }

  res.json(item);
}

async function create(req, res) {
  const userId = req.user?.id;
  if (!userId) {
    return res.status(401).json({ error: 'Autenticación requerida' });
  }

  const { category_id, brand_id, title, model, description, specs, price, item_condition } = req.body;

  if (!title || !price || !category_id || !item_condition) {
    return res.status(400).json({ error: 'Campos obligatorios: title, price, category_id, item_condition' });
  }

  const itemId = await ItemModel.create({
    userId,
    categoryId: category_id,
    brandId: brand_id,
    title,
    model,
    description,
    specs: specs || {},
    price,
    itemCondition: item_condition,
  });

  res.status(201).json({ id: itemId, title, price });
}

async function update(req, res) {
  const userId = req.user?.id;
  if (!userId) {
    return res.status(401).json({ error: 'Autenticación requerida' });
  }

  const { id } = req.params;
  const { title, model, description, specs, price, item_condition, status } = req.body;

  const item = await ItemModel.findByIdAndUser(id, userId);
  if (!item) {
    return res.status(403).json({ error: 'No tienes permiso o el artículo no existe' });
  }

  await ItemModel.update(id, {
    title,
    model,
    description,
    specs: specs || {},
    price,
    itemCondition: item_condition,
    status: status || 'draft',
  });

  res.json({ id: Number(id), title, price });
}

async function remove(req, res) {
  const userId = req.user?.id;
  if (!userId) {
    return res.status(401).json({ error: 'Autenticación requerida' });
  }

  const { id } = req.params;

  const item = await ItemModel.findByIdAndUser(id, userId);
  if (!item) {
    return res.status(403).json({ error: 'No tienes permiso o el artículo no existe' });
  }

  await ItemModel.remove(id);
  res.status(204).send();
}

module.exports = { list, getById, create, update, remove };