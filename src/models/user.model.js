const pool = require('../config/db');

async function findByUsername(username) {
  const [rows] = await pool.query(
    'SELECT id, username, email, password_hash, role, status FROM users WHERE username = ?',
    [username]
  );
  return rows[0] || null;
}

async function findByEmail(email) {
  const [rows] = await pool.query(
    'SELECT id, username, email, password_hash, role, status FROM users WHERE email = ?',
    [email]
  );
  return rows[0] || null;
}

async function findById(id) {
  const [rows] = await pool.query(
    'SELECT id, username, email, role, status, avatar_url, created_at FROM users WHERE id = ?',
    [id]
  );
  return rows[0] || null;
}

async function create({ username, email, password_hash }) {
  const [result] = await pool.query(
    'INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)',
    [username, email, password_hash]
  );
  return result.insertId;
}

module.exports = { findByUsername, findByEmail, findById, create };
