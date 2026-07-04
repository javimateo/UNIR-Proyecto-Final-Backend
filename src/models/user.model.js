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

async function findAll({ search, role, status } = {}) {
  const conditions = [];
  const params = [];

  if (search)  { conditions.push('(username LIKE ? OR email LIKE ?)'); params.push(`%${search}%`, `%${search}%`); }
  if (role)    { conditions.push('role = ?');   params.push(role); }
  if (status)  { conditions.push('status = ?'); params.push(status); }

  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';

  const [rows] = await pool.query(
    `SELECT id, username, email, role, status, avatar_url, created_at FROM users ${where} ORDER BY created_at DESC`,
    params
  );
  return rows;
}

async function update(id, { username, email, avatar_url }) {
  const [result] = await pool.query(
    'UPDATE users SET username = ?, email = ?, avatar_url = ? WHERE id = ?',
    [username, email, avatar_url || null, id]
  );
  return result.affectedRows > 0;
}

async function updateRole(id, role) {
  const [result] = await pool.query(
    'UPDATE users SET role = ? WHERE id = ?',
    [role, id]
  );
  return result.affectedRows > 0;
}

async function updateStatus(id, status) {
  const [result] = await pool.query(
    'UPDATE users SET status = ? WHERE id = ?',
    [status, id]
  );
  return result.affectedRows > 0;
}

module.exports = { findByUsername, findByEmail, findById, findAll, create, update, updateRole, updateStatus };
