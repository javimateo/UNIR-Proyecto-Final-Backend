const ItemModel = require("../models/item.model");

// Público: todos los artículos publicados con filtros opcionales por query string
async function getItems(req, res, next) {
  try {
    // 1. Extraemos los nombres EXACTOS que envía tu Angular, añadiendo paginación
    const {
      category_id,
      brand_id,
      min_price,
      max_price,
      item_condition,
      status,
      search,
      page = 1,
      per_page = 6,
    } = req.query;

    // 2. Se los pasamos al modelo
    const data = await ItemModel.findAll({
      category_id,
      brand_id,
      min_price,
      max_price,
      item_condition,
      status,
      search,
      page,
      per_page,
    });

    // 3. Calculamos el total de páginas
    const total_pages = Math.ceil(data.total / data.per_page) || 1;

    // 4. Devolvemos el formato exacto que espera Angular
    res.json({
      results: data.results,
      total: data.total,
      page: data.page,
      total_pages: total_pages,
    });
  } catch (error) {
    console.error("Error en getItems:", error);
    res.status(500).json({ error: "Error al obtener los artículos" });
  }
}

// Público: detalle completo de un artículo incluyendo sus fotos
async function getItem(req, res, next) {
  const item = await ItemModel.findById(req.params.id);
  if (!item) return res.status(404).json({ error: "Artículo no encontrado" });
  res.json(item);
}

// Público: todos los artículos de un usuario concreto
async function getUserItems(req, res, next) {
  const items = await ItemModel.findAll({ userId: req.params.id });
  res.json(items);
}

async function createItem(req, res, next) {
  const {
    category_id,
    brand_id,
    title,
    model,
    description,
    specs,
    price,
    item_condition,
    status,
  } = req.body;

  if (!category_id || !title || !price || !item_condition) {
    return res
      .status(400)
      .json({
        error: "category_id, title, price e item_condition son obligatorios",
      });
  }

  // Verificar que las FK existen antes de insertar para evitar errores de BD poco descriptivos
  const categoryOk = await ItemModel.categoryExists(category_id);
  if (!categoryOk)
    return res.status(400).json({ error: "La categoría indicada no existe" });

  if (brand_id) {
    const brandOk = await ItemModel.brandExists(brand_id);
    if (!brandOk)
      return res.status(400).json({ error: "La marca indicada no existe" });
  }

  const id = await ItemModel.create({
    user_id: req.user.id, // propietario = usuario autenticado
    category_id,
    brand_id,
    title,
    model,
    description,
    specs,
    price,
    item_condition,
    status,
  });

  res.status(201).json({ id });
}

async function updateItem(req, res, next) {
  const item = await ItemModel.findById(req.params.id);
  if (!item) return res.status(404).json({ error: "Artículo no encontrado" });

  // Solo el propietario o un admin pueden editar
  if (item.user_id !== req.user.id && req.user.role !== "admin") {
    const err = new Error("No tienes permiso para editar este artículo");
    err.status = 403;
    return next(err);
  }

  const {
    category_id,
    brand_id,
    title,
    model,
    description,
    specs,
    price,
    item_condition,
    status,
  } = req.body;

  if (!category_id || !title || !price || !item_condition) {
    return res
      .status(400)
      .json({
        error: "category_id, title, price e item_condition son obligatorios",
      });
  }

  const categoryOk = await ItemModel.categoryExists(category_id);
  if (!categoryOk)
    return res.status(400).json({ error: "La categoría indicada no existe" });

  if (brand_id) {
    const brandOk = await ItemModel.brandExists(brand_id);
    if (!brandOk)
      return res.status(400).json({ error: "La marca indicada no existe" });
  }

  await ItemModel.update(req.params.id, {
    category_id,
    brand_id,
    title,
    model,
    description,
    specs,
    price,
    item_condition,
    status,
  });
  res.json({ message: "Artículo actualizado correctamente" });
}

async function deleteItem(req, res, next) {
  const item = await ItemModel.findById(req.params.id);
  if (!item) return res.status(404).json({ error: "Artículo no encontrado" });

  // Solo el propietario o un admin pueden eliminar
  if (item.user_id !== req.user.id && req.user.role !== "admin") {
    const err = new Error("No tienes permiso para eliminar este artículo");
    err.status = 403;
    return next(err);
  }

  await ItemModel.remove(req.params.id);
  res.json({ message: "Artículo eliminado correctamente" });
}

async function sellItem(req, res, next) {
  const item = await ItemModel.findById(req.params.id);
  if (!item) return res.status(404).json({ error: "Artículo no encontrado" });

  // Solo el propietario puede marcar su artículo como vendido (ni siquiera el admin)
  if (item.user_id !== req.user.id) {
    const err = new Error("No tienes permiso para realizar esta acción");
    err.status = 403;
    return next(err);
  }

  // Solo tiene sentido marcar como vendido si está publicado
  if (item.status !== "published") {
    return res
      .status(400)
      .json({
        error: "Solo se pueden marcar como vendidos los artículos publicados",
      });
  }

  await ItemModel.updateStatus(req.params.id, "sold");
  res.json({ message: "Artículo marcado como vendido" });
}

module.exports = {
  getItems,
  getItem,
  getUserItems,
  createItem,
  updateItem,
  deleteItem,
  sellItem,
};
