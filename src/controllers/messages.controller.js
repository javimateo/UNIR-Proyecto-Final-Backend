// Importamos el modelo que acabamos de rellenar para poder usar sus funciones
const Message = require('../models/message.model');
const ItemModel = require('../models/item.model');

// ✉️ 1. Controlador para enviar un mensaje nuevo o responder en un chat
const sendMessage = async (req, res, next) => {
    try {
        const { item_id, receiver_id, message_text } = req.body;
        
        // El ID del emisor (tú) lo sacamos del token JWT de forma segura
        const senderId = req.user.id; 

        // Validación básica
        if (!item_id || !receiver_id || !message_text || message_text.trim() === '') {
            return res.status(400).json({
                success: false,
                message: 'Por favor, rellena todos los campos obligatorios. El mensaje no puede estar vacío.'
            });
        }

        const item = await ItemModel.findById(item_id);
        if (!item) {
            return res.status(404).json({ success: false, message: 'El artículo asociado no existe.' });
        }

        const itemOwnerId = item.user_id;
        let buyerId, sellerId;

        if (senderId === itemOwnerId) {
            // Si el que escribe es el dueño del producto, él es el vendedor y el otro es el comprador
            sellerId = senderId;
            buyerId = receiver_id;
        } else {
            // Si el que escribe no es el dueño, él es el comprador y el dueño es el vendedor
            buyerId = senderId;
            sellerId = itemOwnerId;
        }

        // 🔄 Obtener o crear el ID de la conversación única
        const conversationId = await Message.getOrCreateConversation(item_id, buyerId, sellerId);

        // 🚀 Llamamos al modelo para insertar el mensaje en la tabla real (Punto 1)
        const messageId = await Message.create(conversationId, senderId, message_text);

        // Respondemos a Angular
        res.status(201).json({
            success: true,
            message: 'Mensaje enviado correctamente y asociado a la conversación.',
            data: {
                id: messageId,
                conversation_id: conversationId,
                sender_id: senderId,
                content: message_text
            }
        });
    } catch (error) {
        next(error);
    }
};

// 📥 2. Controlador para listar los mensajes que ha recibido el usuario logueado
const getInbox = async (req, res, next) => {
    try {
        const userId = req.user.id; 
        const inbox = await Message.getInbox(userId);

        res.json({
            success: true,
            count: inbox.length,
            messages: inbox
        });
    } catch (error) {
        next(error);
    }
};

// 💬 3. Controlador para ver el historial completo de chat entre dos personas por un artículo
const getChatHistory = async (req, res, next) => {
    try {
        const itemId = req.params.itemId;       
        const alternativeUserId = req.params.userId; 
        const currentUserId = req.user.id;      

        const chat = await Message.getChat(itemId, currentUserId, alternativeUserId);

        res.json({
            success: true,
            messages: chat
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    sendMessage,
    getInbox,
    getChatHistory
};