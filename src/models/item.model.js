const db = require('../config/db');

const Item = {
    // 1. Obtener listado con filtros acumulativos (Categoría, Marca, Precios, Estado y Búsqueda por texto)
    findAll: async (filters) => {
        let sql = `
            SELECT i.*, u.username as owner_name, 
                   (SELECT photo_url FROM item_photos WHERE item_id = i.id LIMIT 1) as main_photo
            FROM items i
            JOIN users u ON i.user_id = u.id
            WHERE 1=1
        `;
        const params = [];

        if (filters.category) {
            sql += " AND i.category_id = ?";
            params.push(filters.category);
        }
        if (filters.brand) {
            sql += " AND i.brand_id = ?";
            params.push(filters.brand);
        }
        if (filters.minPrice) {
            sql += " AND i.price >= ?";
            params.push(filters.minPrice);
        }
        if (filters.maxPrice) {
            sql += " AND i.price <= ?";
            params.push(filters.maxPrice);
        }
        if (filters.condition) {
            sql += " AND i.item_condition = ?";
            params.push(filters.condition);
        }
        if (filters.status) {
            sql += " AND i.status = ?";
            params.push(filters.status);
        }
        if (filters.search) {
            sql += " AND i.title LIKE ?";
            params.push(`%${filters.search}%`);
        }

        const [rows] = await db.query(sql, params);
        return rows;
    },

    // 2. Obtener un único artículo con el detalle completo de sus fotos asociadas
    findById: async (id) => {
        const itemSql = `
            SELECT i.*, u.username as owner_name, u.email as owner_email 
            FROM items i
            JOIN users u ON i.user_id = u.id
            WHERE i.id = ?
        `;
        const [items] = await db.query(itemSql, [id]);
        if (items.length === 0) return null;

        const item = items[0];

        // Traemos también todas sus fotos asociadas de la Fase 3
        const [photos] = await db.query("SELECT id, photo_url FROM item_photos WHERE item_id = ?", [id]);
        item.photos = photos;

        return item;
    },

    // 3. Insertar un nuevo artículo (Almacenando 'specs' como texto JSON estructurado)
    create: async (itemData) => {
        const sql = `
            INSERT INTO items (title, description, price, item_condition, specs, category_id, brand_id, user_id, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'published')
        `;
        const [result] = await db.query(sql, [
            itemData.title,
            itemData.description,
            itemData.price,
            itemData.condition,
            JSON.stringify(itemData.specs || {}), // Conversión estricta a string JSON para MySQL
            itemData.category_id,
            itemData.brand_id,
            itemData.user_id
        ]);
        return result.insertId;
    },

    // 4. Modificar los datos de un anuncio existente
    update: async (id, itemData) => {
        const sql = `
            UPDATE items 
            SET title = ?, description = ?, price = ?, item_condition = ?, specs = ?, category_id = ?, brand_id = ?
            WHERE id = ?
        `;
        const [result] = await db.query(sql, [
            itemData.title,
            itemData.description,
            itemData.price,
            itemData.condition,
            JSON.stringify(itemData.specs || {}),
            itemData.category_id,
            itemData.brand_id,
            id
        ]);
        return result.affectedRows > 0;
    },

    // 5. Cambiar el estado a vendido ('sold')
    markAsSold: async (id) => {
        const sql = "UPDATE items SET status = 'sold' WHERE id = ?";
        const [result] = await db.query(sql, [id]);
        return result.affectedRows > 0;
    },

    // 6. Eliminar por completo el registro
    delete: async (id) => {
        const sql = "DELETE FROM items WHERE id = ?";
        const [result] = await db.query(sql, [id]);
        return result.affectedRows > 0;
    },

    // 7. Listar todos los artículos publicados por un usuario concreto
    findByUserId: async (userId) => {
        const sql = "SELECT * FROM items WHERE user_id = ?";
        const [rows] = await db.query(sql, [userId]);
        return rows;
    }
};

module.exports = Item;