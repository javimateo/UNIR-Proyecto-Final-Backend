// Importamos la conexión que acabas de crear en config
const db = require('../config/db');

const Message = {
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
    getChat: async (itemId, user1Id, user2Id) => {
        const sql = `
            SELECT m.*, u.username AS sender_name 
            FROM messages m
            JOIN users u ON m.sender_id = u.id
            WHERE m.item_id = ? 
              AND ((m.sender_id = ? AND m.receiver_id = ?) OR (m.sender_id = ? AND m.receiver_id = ?))
            ORDER BY m.created_at ASC
        `;
        const [rows] = await db.query(sql, [itemId, user1Id, user2Id, user1Id, user2Id]);
        return rows; // Devuelve toda la conversación ordenada por fecha de la más vieja a la más nueva
    }
};

module.exports = Message;