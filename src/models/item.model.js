const pool = require('../config/db');

async function findAll(filters = {}) {
  const { search, category, priceMin, priceMax, sort, page = 1, limit = 10 } = filters;
  
  let query = `
    SELECT i.id, i.title, i.model, i.description, i.price, i.item_condition, 
           i.status, i.created_at, i.category_id, i.brand_id, c.nombre_categoria, b.nombre_marca
    FROM items i
    LEFT JOIN category c ON i.category_id = c.id_categoria
    LEFT JOIN brand b ON i.brand_id = b.id_marca
    WHERE i.status = 'published'
  `;
  
  const params = [];

  if (search) {
    query += ` AND (i.title LIKE ? OR i.description LIKE ?)`;
    const searchTerm = `%${search}%`;
    params.push(searchTerm, searchTerm);
  }

  if (category) {
    query += ` AND i.category_id = ?`;
    params.push(category);
  }

  if (priceMin) {
    query += ` AND i.price >= ?`;
    params.push(priceMin);
  }

  if (priceMax) {
    query += ` AND i.price <= ?`;
    params.push(priceMax);
  }

  if (sort === 'price_asc') {
    query += ` ORDER BY i.price ASC`;
  } else if (sort === 'price_desc') {
    query += ` ORDER BY i.price DESC`;
  } else if (sort === 'newest') {
    query += ` ORDER BY i.created_at DESC`;
  } else {
    query += ` ORDER BY i.created_at DESC`;
  }

  const offset = (page - 1) * limit;
  query += ` LIMIT ? OFFSET ?`;
  params.push(limit, offset);

  const [rows] = await pool.query(query, params);
  return rows;
}

async function countAll(filters = {}) {
  const { search, category, priceMin, priceMax } = filters;
  
  let query = `SELECT COUNT(*) AS count FROM items WHERE status = 'published'`;
  const params = [];

  if (search) {
    query += ` AND (title LIKE ? OR description LIKE ?)`;
    const searchTerm = `%${search}%`;
    params.push(searchTerm, searchTerm);
  }

  if (category) {
    query += ` AND category_id = ?`;
    params.push(category);
  }

  if (priceMin) {
    query += ` AND price >= ?`;
    params.push(priceMin);
  }

  if (priceMax) {
    query += ` AND price <= ?`;
    params.push(priceMax);
  }

  const [rows] = await pool.query(query, params);
  return rows[0].count;
}

async function findById(id) {
  const [rows] = await pool.query(
    `SELECT i.*, c.nombre_categoria, b.nombre_marca
     FROM items i
     LEFT JOIN category c ON i.category_id = c.id_categoria
     LEFT JOIN brand b ON i.brand_id = b.id_marca
     WHERE i.id = ? LIMIT 1`,
    [id]
  );
  return rows[0] || null;
}

async function create({ userId, categoryId, brandId, title, model, description, specs, price, itemCondition }) {
  const [result] = await pool.query(
    `INSERT INTO items (user_id, category_id, brand_id, title, model, description, specs, price, item_condition, status)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'draft')`,
    [userId, categoryId, brandId, title, model, description, JSON.stringify(specs), price, itemCondition]
  );
  return result.insertId;
}

async function update(id, { title, model, description, specs, price, itemCondition, status }) {
  const [result] = await pool.query(
    `UPDATE items 
     SET title = ?, model = ?, description = ?, specs = ?, price = ?, item_condition = ?, status = ?
     WHERE id = ?`,
    [title, model, description, JSON.stringify(specs), price, itemCondition, status, id]
  );
  return result.affectedRows > 0;
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM items WHERE id = ?', [id]);
  return result.affectedRows > 0;
}

async function findByIdAndUser(id, userId) {
  const [rows] = await pool.query(
    'SELECT id FROM items WHERE id = ? AND user_id = ? LIMIT 1',
    [id, userId]
  );
  return rows[0] || null;
}

module.exports = {
  findAll,
  countAll,
  findById,
  create,
  update,
  remove,
  findByIdAndUser,
};