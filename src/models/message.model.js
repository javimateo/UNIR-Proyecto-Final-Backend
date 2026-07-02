const db = require('../config/db');

async function getOrCreateConversation(itemId, buyerId, sellerId) {
  const [rows] = await db.query(
    'SELECT id FROM conversations WHERE item_id = ? AND buyer_id = ? AND seller_id = ?',
    [itemId, buyerId, sellerId]
  );
  if (rows.length > 0) return rows[0].id;

  const [result] = await db.query(
    'INSERT INTO conversations (item_id, buyer_id, seller_id) VALUES (?, ?, ?)',
    [itemId, buyerId, sellerId]
  );
  return result.insertId;
}

async function create(conversationId, senderId, content) {
  const [result] = await db.query(
    'INSERT INTO messages (conversation_id, sender_id, content) VALUES (?, ?, ?)',
    [conversationId, senderId, content]
  );
  return result.insertId;
}

async function getConversations(userId) {
  const [rows] = await db.query(
    `SELECT c.id, c.item_id, i.title AS item_title,
            u_buyer.username AS buyer_name, u_seller.username AS seller_name,
            c.buyer_id, c.seller_id,
            last_msg.content AS last_message, last_msg.sent_at AS last_message_at,
            COUNT(CASE WHEN m.is_read = 0 AND m.sender_id != ? THEN 1 END) AS unread_count
     FROM conversations c
     JOIN items i ON c.item_id = i.id
     JOIN users u_buyer ON c.buyer_id = u_buyer.id
     JOIN users u_seller ON c.seller_id = u_seller.id
     LEFT JOIN messages m ON m.conversation_id = c.id
     LEFT JOIN (
       SELECT conversation_id, content, sent_at
       FROM messages
       WHERE id IN (SELECT MAX(id) FROM messages GROUP BY conversation_id)
     ) last_msg ON last_msg.conversation_id = c.id
     WHERE c.buyer_id = ? OR c.seller_id = ?
     GROUP BY c.id, c.item_id, i.title, u_buyer.username, u_seller.username,
              c.buyer_id, c.seller_id, last_msg.content, last_msg.sent_at
     ORDER BY last_msg.sent_at DESC`,
    [userId, userId, userId]
  );
  return rows;
}

async function getInbox(userId) {
  const [rows] = await db.query(
    `SELECT m.id, m.content, m.sent_at, m.is_read,
            c.item_id, u.username AS sender_name, i.title AS item_title
     FROM messages m
     JOIN conversations c ON m.conversation_id = c.id
     JOIN users u ON m.sender_id = u.id
     JOIN items i ON c.item_id = i.id
     WHERE (c.buyer_id = ? OR c.seller_id = ?) AND m.sender_id != ?
     ORDER BY m.sent_at DESC`,
    [userId, userId, userId]
  );
  return rows;
}

async function getChat(itemId, user1Id, user2Id) {
  const [rows] = await db.query(
    `SELECT m.id, m.content, m.sent_at, m.is_read, u.username AS sender_name
     FROM messages m
     JOIN conversations c ON m.conversation_id = c.id
     JOIN users u ON m.sender_id = u.id
     WHERE c.item_id = ?
       AND ((c.buyer_id = ? AND c.seller_id = ?) OR (c.buyer_id = ? AND c.seller_id = ?))
     ORDER BY m.sent_at ASC`,
    [itemId, user1Id, user2Id, user2Id, user1Id]
  );
  return rows;
}

async function markAsRead(messageId, userId) {
  const [result] = await db.query(
    `UPDATE messages m
     JOIN conversations c ON m.conversation_id = c.id
     SET m.is_read = 1
     WHERE m.id = ? AND m.sender_id != ?
       AND (c.buyer_id = ? OR c.seller_id = ?)`,
    [messageId, userId, userId, userId]
  );
  return result.affectedRows > 0;
}

module.exports = { getOrCreateConversation, create, getConversations, getInbox, getChat, markAsRead };
