const pool = require('../config/db');

async function findAll() {
  const [rows] = await pool.query(
    'SELECT id_categoria AS id, nombre_categoria AS name FROM category ORDER BY nombre_categoria'
  );
  return rows;
}

async function findById(id) {
  const [rows] = await pool.query(
    'SELECT id_categoria AS id, nombre_categoria AS name FROM category WHERE id_categoria = ? LIMIT 1',
    [id]
  );
  return rows[0] || null;
}

async function create({ name }) {
  const [result] = await pool.query(
    'INSERT INTO category (nombre_categoria) VALUES (?)',
    [name]
  );
  return result.insertId;
}

async function update(id, { name }) {
  const [result] = await pool.query(
    'UPDATE category SET nombre_categoria = ? WHERE id_categoria = ?',
    [name, id]
  );
  return result.affectedRows > 0;
}

async function remove(id) {
  const [result] = await pool.query(
    'DELETE FROM category WHERE id_categoria = ?',
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