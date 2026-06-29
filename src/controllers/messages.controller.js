// Importamos el modelo que acabamos de rellenar para poder usar sus funciones
const Message = require('../models/message.model');
<<<<<<< HEAD
=======
const db = require('../config/db'); // Necesario para comprobar el dueño del artículo
>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)

// ✉️ 1. Controlador para enviar un mensaje nuevo o responder en un chat
const sendMessage = async (req, res, next) => {
    try {
        const { item_id, receiver_id, message_text } = req.body;
        
        // El ID del emisor (tú) lo sacamos del token JWT de forma segura
        const senderId = req.user.id; 

<<<<<<< HEAD
        // Validación: Si falta algún dato o el texto está vacío, paramos y avisamos
=======
        // Validación básica
>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)
        if (!item_id || !receiver_id || !message_text || message_text.trim() === '') {
            return res.status(400).json({
                success: false,
                message: 'Por favor, rellena todos los campos obligatorios. El mensaje no puede estar vacío.'
            });
        }

<<<<<<< HEAD
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
=======
        // 📝 RESOLVER ARQUITECTURA (Punto 2): Determinar roles de la conversación
        // Buscamos quién es el propietario real del artículo
        const [items] = await db.query("SELECT user_id FROM items WHERE id = ?", [item_id]);
        if (items.length === 0) {
            return res.status(404).json({ success: false, message: 'El artículo asociado no existe.' });
        }

        const itemOwnerId = items[0].user_id;
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
                text: message_text
            }
        });
    } catch (error) {
>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)
        next(error);
    }
};

// 📥 2. Controlador para listar los mensajes que ha recibido el usuario logueado
const getInbox = async (req, res, next) => {
    try {
<<<<<<< HEAD
        const userId = req.user.id; // Sacamos quién es el usuario desde su Token
=======
        const userId = req.user.id; 
>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)
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
<<<<<<< HEAD
        const itemId = req.params.itemId;       // ID del artículo que viene en la URL
        const alternativeUserId = req.params.userId; // ID del otro usuario que viene en la URL
        const currentUserId = req.user.id;      // Tu ID sacado del Token

        // Pedimos al modelo que nos traiga la conversación limpia
=======
        const itemId = req.params.itemId;       
        const alternativeUserId = req.params.userId; 
        const currentUserId = req.user.id;      

>>>>>>> ca715f2 (Fix: adaptar modulo de mensajes a la tabla conversations y mapear sus columnas de BD)
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