const CategoryModel = require('../models/category.model');

async function list(req, res) {
  const categories = await CategoryModel.findAll();
  res.json(categories);
}

async function create(req, res) {
  const { name } = req.body;

  if (!name) {
    return res.status(400).json({ error: 'name es obligatorio' });
  }

  const categoryId = await CategoryModel.create({ name });
  res.status(201).json({ id: categoryId, name });
}

async function update(req, res) {
  const { id } = req.params;
  const { name } = req.body;

  if (!name) {
    return res.status(400).json({ error: 'name es obligatorio' });
  }

  const category = await CategoryModel.findById(id);
  if (!category) {
    return res.status(404).json({ error: 'Categoría no encontrada' });
  }

  const updated = await CategoryModel.update(id, { name });
  if (!updated) {
    return res.status(500).json({ error: 'No se pudo actualizar la categoría' });
  }

  res.json({ id: Number(id), name });
}

async function remove(req, res) {
  const { id } = req.params;

  const category = await CategoryModel.findById(id);
  if (!category) {
    return res.status(404).json({ error: 'Categoría no encontrada' });
  }

  const used = await CategoryModel.hasItems(id);
  if (used) {
    return res.status(400).json({ error: 'No se puede eliminar una categoría usada por artículos' });
  }

  const deleted = await CategoryModel.remove(id);
  if (!deleted) {
    return res.status(500).json({ error: 'No se pudo eliminar la categoría' });
  }

  res.status(204).send();
}

module.exports = { list, create, update, remove };