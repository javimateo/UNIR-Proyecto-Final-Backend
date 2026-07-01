const pool = require('../config/db');

async function findAll({ status } = {}) {
  const where = status ? 'WHERE r.status = ?' : "WHERE r.status = 'pending'";
  const params = status ? [status] : [];

  const [rows] = await pool.query(
    `SELECT r.id, r.reason, r.status, r.created_at, r.resolved_at,
            r.item_id, i.title AS item_title,
            r.reporter_id, u.username AS reporter_username,
            r.moderator_id, m.username AS moderator_username
     FROM reports r
     JOIN items i ON i.id = r.item_id
     JOIN users u ON u.id = r.reporter_id
     LEFT JOIN users m ON m.id = r.moderator_id
     ${where}
     ORDER BY r.created_at DESC`,
    params
  );
  return rows;
}

async function findById(id) {
  const [rows] = await pool.query(
    `SELECT r.id, r.reason, r.status, r.moderator_note, r.created_at, r.resolved_at,
            r.item_id, i.title AS item_title, i.status AS item_status,
            r.reporter_id, u.username AS reporter_username,
            r.moderator_id, m.username AS moderator_username
     FROM reports r
     JOIN items i ON i.id = r.item_id
     JOIN users u ON u.id = r.reporter_id
     LEFT JOIN users m ON m.id = r.moderator_id
     WHERE r.id = ?`,
    [id]
  );
  return rows[0] || null;
}

async function create({ item_id, reporter_id, reason }) {
  const [result] = await pool.query(
    'INSERT INTO reports (item_id, reporter_id, reason) VALUES (?, ?, ?)',
    [item_id, reporter_id, reason]
  );
  return result.insertId;
}

async function resolve(id, { moderator_id, moderator_note, status }) {
  const [result] = await pool.query(
    'UPDATE reports SET moderator_id = ?, moderator_note = ?, status = ?, resolved_at = NOW() WHERE id = ?',
    [moderator_id, moderator_note || null, status, id]
  );
  return result.affectedRows > 0;
}

async function existsByReporterAndItem(reporter_id, item_id) {
  const [rows] = await pool.query(
    "SELECT id FROM reports WHERE reporter_id = ? AND item_id = ? AND status = 'pending'",
    [reporter_id, item_id]
  );
  return rows.length > 0;
}

module.exports = { findAll, findById, create, resolve, existsByReporterAndItem };
