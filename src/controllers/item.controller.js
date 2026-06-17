const db = require('../config/db');

// 1. Crear un artículo
exports.createItem = async (req, res, next) => {
    try {
        const { title, description, price, categoryId } = req.body;
        const userId = req.user.id;

        const [result] = await db.query(
            'INSERT INTO items (user_id, title, description, price, category_id, status) VALUES (?, ?, ?, ?, ?, ?)',
            [userId, title, description, price, categoryId, 'Publicado']
        );

        res.status(201).json({ message: 'Artículo publicado con éxito', itemId: result.insertId });
    } catch (error) { next(error); }
};

// 2. Editar artículo (Solo propietario)
exports.updateItem = async (req, res, next) => {
    try {
        const { id } = req.params;
        const { title, description, price, status } = req.body;
        const userId = req.user.id;

        // Validamos que el ítem pertenezca al usuario antes de tocarlo
        const [result] = await db.query(
            'UPDATE items SET title = ?, description = ?, price = ?, status = ? WHERE id = ? AND user_id = ?',
            [title, description, price, status, id, userId]
        );

        if (result.affectedRows === 0) return res.status(403).json({ error: 'No tienes permiso o el artículo no existe.' });
        
        res.json({ message: 'Artículo actualizado correctamente' });
    } catch (error) { next(error); }
};

// 3. Eliminar artículo
exports.deleteItem = async (req, res, next) => {
    try {
        const { id } = req.params;
        const userId = req.user.id;

        const [result] = await db.query('DELETE FROM items WHERE id = ? AND user_id = ?', [id, userId]);

        if (result.affectedRows === 0) return res.status(403).json({ error: 'No autorizado para borrar este artículo.' });
        
        res.json({ message: 'Artículo eliminado' });
    } catch (error) { next(error); }
};

// 4. Listar artículos (Buscador con filtros para el Front-end)
exports.getItems = async (req, res, next) => {
    try {
        const { category, status } = req.query;
        let query = 'SELECT * FROM items WHERE 1=1';
        const params = [];

        if (category) { query += ' AND category_id = ?'; params.push(category); }
        if (status) { query += ' AND status = ?'; params.push(status); }

        const [items] = await db.query(query, params);
        res.json(items);
    } catch (error) { next(error); }
};