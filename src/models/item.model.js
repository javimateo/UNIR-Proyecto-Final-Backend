const pool = require('../config/db');

async function findAll({ category_id, brand_id, min_price, max_price, item_condition, status, search, userId, page = 1, per_page = 6 } = {}) {
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

    // Filtros con los nombres que manda Angular
    if (category_id) { conditions.push('c.id = ?'); params.push(category_id); }
    if (brand_id)    { conditions.push('b.id = ?'); params.push(brand_id); }
    if (min_price)   { conditions.push('i.price >= ?'); params.push(min_price); }
    if (max_price)   { conditions.push('i.price <= ?'); params.push(max_price); }
    if (item_condition) { conditions.push('i.item_condition = ?'); params.push(item_condition); }
    if (search)      { conditions.push('i.title LIKE ?'); params.push(`%${search}%`); }

    let where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';

    // --- 1. Calcular el TOTAL de resultados para la paginación ---
    const [countResult] = await pool.query(`
        SELECT COUNT(*) as total 
        FROM items i 
        LEFT JOIN categories c ON c.id = i.category_id
        LEFT JOIN brands b ON b.id = i.brand_id
        LEFT JOIN users u ON u.id = i.user_id
        ${where}
    `, params);
    
    const total = countResult[0].total;

    // --- 2. Preparar el LIMIT y OFFSET ---
    const limit = Number(per_page);
    const offset = (Number(page) - 1) * limit;
    const queryParams = [...params, limit, offset];

    // --- 3. Consulta principal con paginación ---
    // NOTA: Cambiamos los JOIN por LEFT JOIN para que no se pierdan productos
    const [rows] = await pool.query(`
        SELECT i.id, i.title, i.model, i.price, i.item_condition, i.status, i.created_at,
               c.id AS category_id, c.name AS category_name,
               b.id AS brand_id, b.name AS brand_name,
               u.id AS user_id, u.username,
               (SELECT url FROM item_photos WHERE item_id = i.id ORDER BY sort_order LIMIT 1) AS cover_photo
        FROM items i
        LEFT JOIN categories c ON c.id = i.category_id
        LEFT JOIN brands b ON b.id = i.brand_id
        LEFT JOIN users u ON u.id = i.user_id
        ${where}
        ORDER BY i.created_at DESC
        LIMIT ? OFFSET ?
    `, queryParams);

    return {
        results: rows,
        total: total,
        page: Number(page),
        per_page: limit
    };
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
