const pool = require('../config/db');

async function findAll() {
  const [rows] = await pool.query(
    'SELECT id, name, slug, logo_url FROM brands ORDER BY name'
  );
  return rows;
}

async function findById(id) {
  const [rows] = await pool.query(
    'SELECT id, name, slug, logo_url FROM brands WHERE id = ? LIMIT 1',
    [id]
  );
  return rows[0] || null;
}

async function create({ name, logo_url }) {
  const slug = name.toLowerCase().replace(/\s+/g, '-');
  const [result] = await pool.query(
    'INSERT INTO brands (name, slug, logo_url) VALUES (?, ?, ?)',
    [name, slug, logo_url || null]
  );
  return result.insertId;
}

async function update(id, { name, logo_url }) {
  const slug = name.toLowerCase().replace(/\s+/g, '-');
  const [result] = await pool.query(
    'UPDATE brands SET name = ?, slug = ?, logo_url = ? WHERE id = ?',
    [name, slug, logo_url || null, id]
  );
  return result.affectedRows > 0;
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM brands WHERE id = ?', [id]);
  return result.affectedRows > 0;
}

async function hasItems(id) {
  const [rows] = await pool.query(
    'SELECT COUNT(*) AS count FROM items WHERE brand_id = ?',
    [id]
  );
  return rows[0].count > 0;
}

module.exports = { findAll, findById, create, update, remove, hasItems };
