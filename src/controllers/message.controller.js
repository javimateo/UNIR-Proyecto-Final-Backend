const db = require('../config/db');

// Enviar mensaje (Crea conversación si no existe)
exports.sendMessage = async (req, res, next) => {
    try {
        const { itemId, receiverId, text } = req.body;
        const senderId = req.user.id; // Obtenido del token

        if (!itemId || !receiverId || !text) return res.status(400).json({ error: 'Campos incompletos.' });
        if (senderId === receiverId) return res.status(400).json({ error: 'No puedes enviarte mensajes a ti mismo.' });

        // 1. Buscar si ya existe una conversación
        const checkQuery = `
            SELECT id FROM conversations 
            WHERE item_id = ? AND ((buyer_id = ? AND seller_id = ?) OR (buyer_id = ? AND seller_id = ?))
            LIMIT 1
        `;
        const [existingConv] = await db.query(checkQuery, [itemId, senderId, receiverId, receiverId, senderId]);
        let conversationId = existingConv.length > 0 ? existingConv[0].id : null;

        // 2. Si no existe, crearla
        if (!conversationId) {
            const [newConv] = await db.query('INSERT INTO conversations (item_id, buyer_id, seller_id) VALUES (?, ?, ?)', [itemId, senderId, receiverId]);
            conversationId = newConv.insertId;
        }

        // 3. Insertar el mensaje
        await db.query('INSERT INTO messages (conversation_id, sender_id, text) VALUES (?, ?, ?)', [conversationId, senderId, text]);
        
        res.status(201).json({ mensaje: 'Mensaje enviado.', conversationId });
    } catch (error) { next(error); }
};

// Obtener todas las conversaciones del usuario autenticado
exports.getConversations = async (req, res, next) => {
    try {
        const userId = req.user.id; // Obtenido del token

        const [conversaciones] = await db.query(`
            SELECT c.id AS conversation_id, c.item_id, i.title AS item_title, c.created_at
            FROM conversations c
            JOIN items i ON c.item_id = i.id
            WHERE c.buyer_id = ? OR c.seller_id = ?
            ORDER BY c.created_at DESC
        `, [userId, userId]);

        res.json({ conversaciones });
    } catch (error) { next(error); }
};

// Obtener historial de una conversación específica
exports.getMessagesByConversation = async (req, res, next) => {
    try {
        const [historial] = await db.query(
            'SELECT id, sender_id, text, created_at FROM messages WHERE conversation_id = ? ORDER BY created_at ASC', 
            [req.params.id]
        );
        
        if (historial.length === 0) return res.status(404).json({ error: 'Conversación vacía o inexistente.' });
        
        res.json({ conversationId: req.params.id, historial });
    } catch (error) { next(error); }
};