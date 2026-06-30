const CategoryModel = require('../models/category.model');

async function list(req, res, next) {
  try {
    const categories = await CategoryModel.findAll();
    res.json(categories);
  } catch (err) {
    next(err);
  }
}

async function create(req, res, next) {
  try {
    const { name } = req.body;

    if (!name) {
      return res.status(400).json({ error: 'name es obligatorio' });
    }

    const categoryId = await CategoryModel.create({ name });
    res.status(201).json({ id: categoryId, name });
  } catch (err) {
    next(err);
  }
}

async function update(req, res, next) {
  try {
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
  } catch (err) {
    next(err);
  }
}

async function remove(req, res, next) {
  try {
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
  } catch (err) {
    next(err);
  }
}

module.exports = { list, create, update, remove };
