const Item = require('../models/item.model');

const getItems = async (req, res, next) => {
    try {
        const { category, brand, minPrice, maxPrice, condition, status, search } = req.query;
        
        // Regla del Plan: Usuarios no autenticados ven cosas en 'published' por defecto
        const filterStatus = status || 'published';

        const items = await Item.findAll({
            category, brand, minPrice, maxPrice, condition, search,
            status: filterStatus
        });

        res.json({ success: true, count: items.length, data: items });
    } catch (error) {
        next(error);
    }
};

const getItemById = async (req, res, next) => {
    try {
        const item = await Item.findById(req.params.id);
        if (!item) {
            return res.status(404).json({ success: false, message: 'Artículo no encontrado.' });
        }
        res.json({ success: true, data: item });
    } catch (error) {
        next(error);
    }
};

const createItem = async (req, res, next) => {
    try {
        const { title, description, price, condition, specs, category_id, brand_id } = req.body;

        if (!title || !price || !category_id || !brand_id) {
            return res.status(400).json({ success: false, message: 'Faltan campos obligatorios para registrar el artículo.' });
        }

        // Mock temporal: Si no viene req.user (porque quitamos el auth), le asignamos el ID 1 temporalmente para pruebas
        const user_id = req.user ? req.user.id : 1; 

        const newItemId = await Item.create({
            title, description, price, condition, specs, category_id, brand_id, user_id
        });

        res.status(201).json({
            success: true,
            message: 'Artículo publicado con éxito.',
            itemId: newItemId
        });
    } catch (error) {
        next(error);
    }
};

const updateItem = async (req, res, next) => {
    try {
        const itemId = req.params.id;
        const item = await Item.findById(itemId);

        if (!item) {
            return res.status(404).json({ success: false, message: 'El artículo no existe.' });
        }

        await Item.update(itemId, req.body);
        res.json({ success: true, message: 'Artículo actualizado correctamente.' });
    } catch (error) {
        next(error);
    }
};

const sellItem = async (req, res, next) => {
    try {
        const itemId = req.params.id;
        const item = await Item.findById(itemId);

        if (!item) return res.status(404).json({ success: false, message: 'Artículo no encontrado.' });

        await Item.markAsSold(itemId);
        res.json({ success: true, message: 'Artículo marcado como vendido con éxito.' });
    } catch (error) {
        next(error);
    }
};

const deleteItem = async (req, res, next) => {
    try {
        const itemId = req.params.id;
        const item = await Item.findById(itemId);

        if (!item) return res.status(404).json({ success: false, message: 'El artículo no existe.' });

        await Item.delete(itemId);
        res.json({ success: true, message: 'Artículo eliminado de forma definitiva.' });
    } catch (error) {
        next(error);
    }
};

const getUserItems = async (req, res, next) => {
    try {
        const items = await Item.findByUserId(req.params.id);
        res.json({ success: true, data: items });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    getItems,
    getItemById,
    createItem,
    updateItem,
    sellItem,
    deleteItem,
    getUserItems
};