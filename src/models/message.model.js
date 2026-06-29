// Importamos la conexión que acabas de crear en config
const db = require('../config/db');

const Message = {
<<<<<<< HEAD
    // 1. Guardar un nuevo mensaje en la base de datos (cuando alguien envía un texto)
    create: async (itemId, senderId, receiverId, messageText) => {
        const sql = `
            INSERT INTO messages (item_id, sender_id, receiver_id, message_text) 
            VALUES (?, ?, ?, ?)
        `;
        const [result] = await db.query(sql, [itemId, senderId, receiverId, messageText]);
        return result.insertId; // Nos devuelve el ID del mensaje que se acaba de crear
    },

    // 2. Obtener los mensajes recibidos por un usuario (para montar la Bandeja de Entrada)
    getInbox: async (userId) => {
        const sql = `
            SELECT m.*, u.username AS sender_name, i.title AS item_title 
            FROM messages m
            JOIN users u ON m.sender_id = u.id
            JOIN items i ON m.item_id = i.id
            WHERE m.receiver_id = ?
            ORDER BY m.created_at DESC
        `;
        const [rows] = await db.query(sql, [userId]);
        return rows; // Devuelve la lista de mensajes con el nombre de quien lo envía y el título del artículo
    },

    // 3. Obtener todo el chat entre dos usuarios sobre un artículo concreto (el historial de la conversación)
=======
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
        const sql = `
            INSERT INTO messages (conversation_id, sender_id, text) 
            VALUES (?, ?, ?)
        `;
        const [result] = await db.query(sql, [conversationId, senderId, messageText]);
        return result.insertId;
    },

    // ✨ CORREGIDO: Monta la bandeja de entrada usando la tabla 'conversations'
    getInbox: async (userId) => {
        const sql = `
            SELECT m.*, c.item_id, u.username AS sender_name, i.title AS item_title 
            FROM messages m
            JOIN conversations c ON m.conversation_id = c.id
            JOIN users u ON m.sender_id = u.id
            JOIN items i ON c.item_id = i.id
            WHERE (c.buyer_id = ? OR c.seller_id = ?) AND m.sender_id != ?
            ORDER BY m.created_at DESC
        `;
        const [rows] = await db.query(sql, [userId, userId, userId]);
        return rows;
    },

    // ✨ CORREGIDO: Trae el chat completo basándose en la conversación activa
>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)
    getChat: async (itemId, user1Id, user2Id) => {
        const sql = `
            SELECT m.*, u.username AS sender_name 
            FROM messages m
<<<<<<< HEAD
            JOIN users u ON m.sender_id = u.id
            WHERE m.item_id = ? 
              AND ((m.sender_id = ? AND m.receiver_id = ?) OR (m.sender_id = ? AND m.receiver_id = ?))
            ORDER BY m.created_at ASC
        `;
        const [rows] = await db.query(sql, [itemId, user1Id, user2Id, user1Id, user2Id]);
        return rows; // Devuelve toda la conversación ordenada por fecha de la más vieja a la más nueva
=======
            JOIN conversations c ON m.conversation_id = c.id
            JOIN users u ON m.sender_id = u.id
            WHERE c.item_id = ? 
              AND ((c.buyer_id = ? AND c.seller_id = ?) OR (c.buyer_id = ? AND c.seller_id = ?))
            ORDER BY m.created_at ASC
        `;
        const [rows] = await db.query(sql, [itemId, user1Id, user2Id, user2Id, user1Id]);
        return rows;
>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)
    }
};

module.exports = Message;