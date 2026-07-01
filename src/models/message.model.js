// Importamos la conexión que acabas de crear en config
const db = require('../config/db');

const Message = {
    // ✨ NUEVO MÉTODO PARA PUNTO 2: Obtener o crear una conversación agrupada
    getOrCreateConversation: async (itemId, buyerId, sellerId) => {
        // Buscamos si ya existe la conversación entre este comprador y vendedor para este artículo
        const [rows] = await db.query(
            "SELECT id FROM conversations WHERE item_id = ? AND buyer_id = ? AND seller_id = ?",
            [itemId, buyerId, sellerId]
        );

        if (rows.length > 0) {
            return rows[0].id; // Si ya existe, devolvemos su ID
        }

        // Si no existe, la creamos de cero
        const [result] = await db.query(
            "INSERT INTO conversations (item_id, buyer_id, seller_id) VALUES (?, ?, ?)",
            [itemId, buyerId, sellerId]
        );
        return result.insertId; // Devolvemos el ID de la nueva conversación
    },

    // ✨ CORREGIDO: Guarda el mensaje usando las columnas reales de vuestra BD
    create: async (conversationId, senderId, messageText) => {
        const [result] = await db.query(
            'INSERT INTO messages (conversation_id, sender_id, content) VALUES (?, ?, ?)',
            [conversationId, senderId, messageText]
        );
        return result.insertId;
    },

    getInbox: async (userId) => {
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
    },

    getChat: async (itemId, user1Id, user2Id) => {
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
};

module.exports = Message;