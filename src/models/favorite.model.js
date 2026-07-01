const pool = require('../config/db');

async function findAllByUser(userId) {
  const [rows] = await pool.query(
    `SELECT f.item_id, i.title, i.model, i.price, i.item_condition, i.specs, i.status
     FROM favorites f
     JOIN items i ON i.id = f.item_id
     WHERE f.user_id = ?`,
    [userId]
  );
  return rows;
}

async function findByUserAndItem(userId, itemId) {
  const [rows] = await pool.query(
    'SELECT user_id, item_id FROM favorites WHERE user_id = ? AND item_id = ?',
    [userId, itemId]
  );
  return rows[0] || null;
}

async function create({ userId, itemId }) {
  const [result] = await pool.query(
    'INSERT INTO favorites (user_id, item_id) VALUES (?, ?)',
    [userId, itemId]
  );
  return result.affectedRows > 0;
}

async function remove(userId, itemId) {
  const [result] = await pool.query(
    'DELETE FROM favorites WHERE user_id = ? AND item_id = ?',
    [userId, itemId]
  );
  return result.affectedRows > 0;
}

async function itemExists(itemId) {
  const [rows] = await pool.query(
    'SELECT id FROM items WHERE id = ? LIMIT 1',
    [itemId]
  );
  return Boolean(rows[0]);
}

module.exports = {
  findAllByUser,
  findByUserAndItem,
  create,
  remove,
  itemExists,
};
