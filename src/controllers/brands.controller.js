const BrandModel = require('../models/brand.model');

async function list(req, res, next) {
  try {
    const brands = await BrandModel.findAll();
    res.json(brands);
  } catch (err) {
    next(err);
  }
}

async function create(req, res, next) {
  try {
    const { name, logo_url } = req.body;
    if (!name) return res.status(400).json({ error: 'name es obligatorio' });
    const brandId = await BrandModel.create({ name, logo_url });
    res.status(201).json({ id: brandId, name, logo_url: logo_url || null });
  } catch (err) {
    next(err);
  }
}

async function update(req, res, next) {
  try {
    const { id } = req.params;
    const { name, logo_url } = req.body;
    if (!name) return res.status(400).json({ error: 'name es obligatorio' });
    const brand = await BrandModel.findById(id);
    if (!brand) return res.status(404).json({ error: 'Marca no encontrada' });
    await BrandModel.update(id, { name, logo_url });
    res.json({ id: Number(id), name, logo_url: logo_url || null });
  } catch (err) {
    next(err);
  }
}

async function remove(req, res, next) {
  try {
    const { id } = req.params;
    const brand = await BrandModel.findById(id);
    if (!brand) return res.status(404).json({ error: 'Marca no encontrada' });
    const used = await BrandModel.hasItems(id);
    if (used) return res.status(400).json({ error: 'No se puede eliminar una marca usada por artículos' });
    await BrandModel.remove(id);
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}

module.exports = { list, create, update, remove };
