const pool = require('../config/db');

async function findAll({ category, brand, minPrice, maxPrice, condition, status, search, userId, page = 1, perPage = 6 } = {}) {
  const conditions = [];
  const params = [];

  if (userId) {
    conditions.push('i.user_id = ?');
    params.push(userId);
    if (status) {
      conditions.push('i.status = ?');
      params.push(status);
    }
  } else {
    conditions.push("i.status = 'published'");
  }

  if (category) { conditions.push('c.slug = ?');        params.push(category); }
  if (brand)    { conditions.push('b.slug = ?');        params.push(brand); }
  if (minPrice) { conditions.push('i.price >= ?');      params.push(minPrice); }
  if (maxPrice) { conditions.push('i.price <= ?');      params.push(maxPrice); }
  if (condition){ conditions.push('i.item_condition = ?'); params.push(condition); }
  if (search)   { conditions.push('i.title LIKE ?');    params.push(`%${search}%`); }

  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const offset = (page - 1) * perPage;

  const [rows] = await pool.query(
    `SELECT i.id, i.title, i.model, i.price, i.item_condition, i.status, i.created_at,
            c.id AS category_id, c.name AS category_name,
            b.id AS brand_id, b.name AS brand_name,
            u.id AS user_id, u.username,
            (SELECT url FROM item_photos WHERE item_id = i.id ORDER BY sort_order LIMIT 1) AS cover_photo
     FROM items i
     JOIN categories c ON c.id = i.category_id
     LEFT JOIN brands b ON b.id = i.brand_id
     JOIN users u ON u.id = i.user_id
     ${where}
     ORDER BY i.created_at DESC
     LIMIT ? OFFSET ?`,
    [...params, perPage, offset]
  );
  return rows;
}

async function findById(id) {
  const [rows] = await pool.query(
    `SELECT i.id, i.title, i.model, i.description, i.specs, i.price, i.item_condition, i.status, i.created_at, i.updated_at,
            i.category_id, c.name AS category_name,
            i.brand_id, b.name AS brand_name,
            i.user_id, u.username, u.avatar_url
     FROM items i
     JOIN categories c ON c.id = i.category_id
     LEFT JOIN brands b ON b.id = i.brand_id
     JOIN users u ON u.id = i.user_id
     WHERE i.id = ?`,
    [id]
  );
  if (!rows[0]) return null;

  const [photos] = await pool.query(
    'SELECT id, url, sort_order FROM item_photos WHERE item_id = ? ORDER BY sort_order',
    [id]
  );

  return { ...rows[0], photos };
}

async function create({ user_id, category_id, brand_id, title, model, description, specs, price, item_condition, status }) {
  const [result] = await pool.query(
    `INSERT INTO items (user_id, category_id, brand_id, title, model, description, specs, price, item_condition, status)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [user_id, category_id, brand_id || null, title, model || null, description || null,
     specs ? JSON.stringify(specs) : null, price, item_condition, status || 'draft']
  );
  return result.insertId;
}

async function update(id, { category_id, brand_id, title, model, description, specs, price, item_condition, status }) {
  const [result] = await pool.query(
    `UPDATE items
     SET category_id = ?, brand_id = ?, title = ?, model = ?, description = ?, specs = ?,
         price = ?, item_condition = ?, status = ?
     WHERE id = ?`,
    [category_id, brand_id || null, title, model || null, description || null,
     specs ? JSON.stringify(specs) : null, price, item_condition, status, id]
  );
  return result.affectedRows;
}

async function updateStatus(id, status) {
  const [result] = await pool.query(
    'UPDATE items SET status = ? WHERE id = ?',
    [status, id]
  );
  return result.affectedRows;
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM items WHERE id = ?', [id]);
  return result.affectedRows;
}

async function categoryExists(id) {
  const [rows] = await pool.query('SELECT id FROM categories WHERE id = ?', [id]);
  return rows.length > 0;
}

async function brandExists(id) {
  const [rows] = await pool.query('SELECT id FROM brands WHERE id = ?', [id]);
  return rows.length > 0;
}

module.exports = { findAll, findById, create, update, updateStatus, remove, categoryExists, brandExists };
