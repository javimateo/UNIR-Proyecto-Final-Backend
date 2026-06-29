const db = require('../config/db');

const Photo = {
    // Buscar una foto por su ID único
    findById: async (id) => {
        const [rows] = await db.query("SELECT * FROM item_photos WHERE id = ?", [id]);
        return rows[0] || null;
    },

    // Buscar todas las fotos que pertenecen a un artículo concreto de la Fase 2
    findByItemId: async (itemId) => {
        const [rows] = await db.query("SELECT * FROM item_photos WHERE item_id = ?", [itemId]);
        return rows;
    },

    // Insertar el registro de la nueva imagen procesada por Multer
    create: async (itemId, photoUrl) => {
        const [result] = await db.query(
            "INSERT INTO item_photos (item_id, photo_url) VALUES (?, ?)",
            [itemId, photoUrl]
        );
        return result.insertId;
    },

    // Eliminar por completo el registro de la foto en MySQL
    delete: async (id) => {
        const [result] = await db.query("DELETE FROM item_photos WHERE id = ?", [id]);
        return result.affectedRows > 0;
    }
};

module.exports = Photo;