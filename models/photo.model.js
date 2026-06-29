// Ajusta esta ruta si tu archivo de conexión 'db.js' se encuentra en otro lugar
const db = require('../config/db'); 

const Photo = {
    // 1. Contar cuántas fotos tiene asignadas un artículo (máximo de 8 por plan de desarrollo)
    countByItemId: async (itemId) => {
        const sql = "SELECT COUNT(*) as total FROM item_photos WHERE item_id = ?";
        const [rows] = await db.query(sql, [itemId]);
        return rows[0].total;
    },

    // 2. Guardar la ruta local de la foto en la base de datos
    create: async (itemId, photoUrl) => {
        const sql = "INSERT INTO item_photos (item_id, photo_url) VALUES (?, ?)";
        const [result] = await db.query(sql, [itemId, photoUrl]);
        return result.insertId;
    },

    // 3. Obtener los datos de una foto por su ID antes de borrarla
    findById: async (photoId) => {
        const sql = "SELECT * FROM item_photos WHERE id = ?";
        const [rows] = await db.query(sql, [photoId]);
        return rows[0];
    },

    // 4. Eliminar el registro de la foto de la tabla
    delete: async (photoId) => {
        const sql = "DELETE FROM item_photos WHERE id = ?";
        const [result] = await db.query(sql, [photoId]);
        return result.affectedRows > 0;
    }
};

module.exports = Photo;