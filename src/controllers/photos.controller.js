const Photo = require('../models/photo.model');
const db = require('../config/db');
const fs = require('fs');
const path = require('path');

const uploadPhoto = async (req, res, next) => {
    try {
        const itemId = req.params.id;

        // 📝 CORRECCIÓN PUNTO 2: Validar autenticación
        if (!req.user || !req.user.id) {
            return res.status(401).json({ 
                success: false, 
                message: 'No autorizado. Debes iniciar sesión para subir fotos.' 
            });
        }
        const userId = req.user.id;

        // Validar que venga el archivo
        if (!req.file) {
            return res.status(400).json({ 
                success: false, 
                message: 'Por favor, selecciona una imagen válida (Formatos aceptados: JPG, JPEG, PNG).' 
            });
        }

        // 📝 CORRECCIÓN PUNTO 3: Verificar que el artículo existe y te pertenece
        const [items] = await db.query("SELECT user_id FROM items WHERE id = ?", [itemId]);
        if (items.length === 0) {
            return res.status(404).json({ success: false, message: 'El artículo especificado no existe.' });
        }
        if (items[0].user_id !== userId) {
            return res.status(403).json({ 
                success: false, 
                message: 'Permiso denegado. No puedes añadir fotos a un artículo que no es tuyo.' 
            });
        }

        const photoUrl = `/uploads-imagen/${req.file.filename}`;
        
        // Guardamos usando el modelo (que ya inserta en la columna 'url')
        const photoId = await Photo.create(itemId, photoUrl);

        res.status(201).json({
            success: true,
            message: 'Imagen subida y vinculada al artículo con éxito.',
            photo: {
                id: photoId,
                item_id: itemId,
                url: photoUrl // Cambiado a 'url' para mantener coherencia con la BD
            }
        });
    } catch (error) {
        next(error);
    }
};

const deletePhoto = async (req, res, next) => {
    try {
        const { id: itemId, photoId } = req.params;

        // 📝 CORRECCIÓN PUNTO 2: Validar autenticación
        if (!req.user || !req.user.id) {
            return res.status(401).json({ 
                success: false, 
                message: 'No autorizado. Debes iniciar sesión para borrar fotos.' 
            });
        }
        const userId = req.user.id;

        // Comprobar si la foto existe
        const photo = await Photo.findById(photoId);
        if (!photo) {
            return res.status(404).json({ success: false, message: 'La imagen solicitada no existe.' });
        }

        // 📝 CORRECCIÓN PUNTO 3: Verificar que la foto pertenece al artículo indicado y al usuario logueado
        const [items] = await db.query("SELECT user_id FROM items WHERE id = ?", [itemId]);
        if (items.length === 0 || items[0].user_id !== userId) {
            return res.status(403).json({ 
                success: false,
                message: 'Permiso denegado. No puedes borrar fotos de un artículo que no te pertenece.'
            });
        }

        if (photo.item_id !== Number(itemId)) {
            return res.status(403).json({ 
                success: false, 
                message: 'Permiso denegado. No puedes borrar fotos de un artículo que no te pertenece.' 
            });
        }

        // Tratar de obtener el nombre del archivo para borrarlo del disco duro
        // Soportamos tanto si guardó la ruta con '/uploads-imagen/' como si no
        const filename = photo.url ? photo.url.replace('/uploads-imagen/', '') : photo.photo_url.replace('/uploads-imagen/', '');
        const filePath = path.join(__dirname, '../../uploads-imagen', filename);

        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }

        // Eliminar de la base de datos
        await Photo.delete(photoId);

        res.json({
            success: true,
            message: 'La imagen ha sido eliminada por completo del servidor.'
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    uploadPhoto,
    deletePhoto
};