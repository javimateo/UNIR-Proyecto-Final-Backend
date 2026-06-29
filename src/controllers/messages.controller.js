// Importamos el modelo que acabamos de rellenar para poder usar sus funciones
const Message = require('../models/message.model');

// ✉️ 1. Controlador para enviar un mensaje nuevo o responder en un chat
const sendMessage = async (req, res, next) => {
    try {
        const { item_id, receiver_id, message_text } = req.body;
        
        // El ID del emisor (tú) lo sacamos del token JWT de forma segura
        const senderId = req.user.id; 

        // Validación: Si falta algún dato o el texto está vacío, paramos y avisamos
        if (!item_id || !receiver_id || !message_text || message_text.trim() === '') {
            return res.status(400).json({
                success: false,
                message: 'Por favor, rellena todos los campos obligatorios. El mensaje no puede estar vacío.'
            });
        }

        // Llamamos al modelo para insertar el mensaje en la base de datos
        const messageId = await Message.create(item_id, senderId, receiver_id, message_text);

        // Respondemos a Angular que todo ha sido un éxito
        res.status(201).json({
            success: true,
            message: 'Mensaje enviado correctamente.',
            messageId
        });
    } catch (error) {
        // Si hay algún fallo imprevisto, se lo mandamos al gestor de errores
        next(error);
    }
};

// 📥 2. Controlador para listar los mensajes que ha recibido el usuario logueado
const getInbox = async (req, res, next) => {
    try {
        const userId = req.user.id; // Sacamos quién es el usuario desde su Token
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
        const itemId = req.params.itemId;       // ID del artículo que viene en la URL
        const alternativeUserId = req.params.userId; // ID del otro usuario que viene en la URL
        const currentUserId = req.user.id;      // Tu ID sacado del Token

        // Pedimos al modelo que nos traiga la conversación limpia
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