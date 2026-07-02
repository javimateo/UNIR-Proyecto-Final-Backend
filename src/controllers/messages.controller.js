const Message = require('../models/message.model');
const ItemModel = require('../models/item.model');

async function sendMessage(req, res, next) {
  const { item_id, receiver_id, message_text } = req.body;
  const senderId = req.user.id;

  if (!item_id || !receiver_id || !message_text?.trim()) {
    return res.status(400).json({ error: 'Faltan campos obligatorios o el mensaje está vacío' });
  }

  const item = await ItemModel.findById(item_id);
  if (!item) return res.status(404).json({ error: 'Artículo no encontrado' });

  const isOwner = senderId === item.user_id;
  const buyerId  = isOwner ? receiver_id : senderId;
  const sellerId = isOwner ? senderId    : item.user_id;

  const conversationId = await Message.getOrCreateConversation(item_id, buyerId, sellerId);
  const messageId = await Message.create(conversationId, senderId, message_text.trim());

  res.status(201).json({
    id: messageId,
    conversation_id: conversationId,
    sender_id: senderId,
    content: message_text.trim(),
  });
}

async function getConversations(req, res, next) {
  const conversations = await Message.getConversations(req.user.id);
  res.json(conversations);
}

async function getInbox(req, res, next) {
  const inbox = await Message.getInbox(req.user.id);
  res.json({ count: inbox.length, messages: inbox });
}

async function getChatHistory(req, res, next) {
  const { itemId, userId } = req.params;
  const messages = await Message.getChat(itemId, req.user.id, userId);
  res.json(messages);
}

async function markAsRead(req, res, next) {
  const updated = await Message.markAsRead(req.params.id, req.user.id);
  if (!updated) return res.status(404).json({ error: 'Mensaje no encontrado o no tienes permiso' });
  res.json({ ok: true });
}

module.exports = { sendMessage, getConversations, getInbox, getChatHistory, markAsRead };
