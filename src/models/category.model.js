const pool = require('../config/db');

async function findAll() {
  const [rows] = await pool.query(
    'SELECT id, name FROM categories ORDER BY name'
  );
  return rows;
}

async function findById(id) {
  const [rows] = await pool.query(
    'SELECT id, name FROM categories WHERE id = ? LIMIT 1',
    [id]
  );
  return rows[0] || null;
}

async function create({ name }) {
  const [result] = await pool.query(
    'INSERT INTO categories (name, slug) VALUES (?, ?)',
    [name, name.toLowerCase().replace(/\s+/g, '-')]
  );
  return result.insertId;
}

async function update(id, { name }) {
  const [result] = await pool.query(
    'UPDATE categories SET name = ? WHERE id = ?',
    [name, id]
  );
  return result.affectedRows > 0;
}

async function remove(id) {
  const [result] = await pool.query(
    'DELETE FROM categories WHERE id = ?',
    [id]
  );
  return result.affectedRows > 0;
}

async function hasItems(id) {
  const [rows] = await pool.query(
    'SELECT COUNT(*) AS count FROM items WHERE category_id = ?',
    [id]
  );
  return rows[0].count > 0;
}

module.exports = {
  findAll,
  findById,
  create,
  update,
  remove,
  hasItems,
};