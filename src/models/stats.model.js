const db = require('../config/db');

async function getStats() {
  const [[users]] = await db.query(
    `SELECT
       SUM(status = 'active')  AS active,
       SUM(status = 'blocked') AS blocked,
       SUM(status = 'deleted') AS deleted,
       COUNT(*)                AS total
     FROM users`
  );

  const [[items]] = await db.query(
    `SELECT
       SUM(status = 'published')    AS published,
       SUM(status = 'draft')        AS draft,
       SUM(status = 'under_review') AS under_review,
       SUM(status = 'sold')         AS sold,
       SUM(status = 'removed')      AS removed,
       COUNT(*)                     AS total
     FROM items`
  );

  const [[reports]] = await db.query(
    `SELECT
       SUM(status = 'pending')          AS pending,
       SUM(status = 'resolved_active')  AS resolved_active,
       SUM(status = 'resolved_removed') AS resolved_removed,
       COUNT(*)                         AS total
     FROM reports`
  );

  const [[recent]] = await db.query(
    `SELECT COUNT(*) AS published_last_30d
     FROM items
     WHERE status = 'published' AND created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)`
  );

  return { users, items, reports, recent };
}

module.exports = { getStats };
