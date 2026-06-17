const fs = require('fs');
const path = require('path');
const db = require('../config/db'); // Usamos el conector oficial de tu equipo

exports.uploadImage = async (req, res, next) => {
    try {
        const { itemId } = req.body;
        const file = req.file;

        if (!file) return res.status(400).json({ error: 'Selecciona una imagen válida.' });
        if (!itemId) {
            if (fs.existsSync(file.path)) fs.unlinkSync(file.path);
            return res.status(400).json({ error: 'Es obligatorio asociar la imagen a un itemId.' });
        }

        const [items] = await db.query('SELECT id FROM items WHERE id = ?', [itemId]);
        if (items.length === 0) {
            if (fs.existsSync(file.path)) fs.unlinkSync(file.path);
            return res.status(404).json({ error: 'El anuncio especificado no existe.' });
        }

        const fileUrl = `/uploads/${file.filename}`;
        await db.query('INSERT INTO item_images (item_id, url) VALUES (?, ?)', [itemId, fileUrl]);

        res.status(201).json({ mensaje: 'Imagen vinculada con éxito.', url: fileUrl });
    } catch (error) { next(error); }
};

exports.deleteImage = async (req, res, next) => {
    try {
        const imageId = req.params.id;
        const [images] = await db.query('SELECT url FROM item_images WHERE id = ?', [imageId]);
        if (images.length === 0) return res.status(404).json({ error: 'La imagen no existe.' });

        const fullPath = path.join(__dirname, '../../', images[0].url);
        await db.query('DELETE FROM item_images WHERE id = ?', [imageId]);

        if (fs.existsSync(fullPath)) fs.unlinkSync(fullPath);
        res.json({ mensaje: 'Imagen eliminada correctamente.' });
    } catch (error) { next(error); }
};