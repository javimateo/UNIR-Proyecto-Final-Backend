const Photo = require('../models/photo.model');
const db = require('../config/db');
const fs = require('fs');
const path = require('path');

const uploadPhoto = async (req, res, next) => {
    try {
        const itemId = req.params.id;

        if (!req.file) {
            return res.status(400).json({ 
                success: false, 
                message: 'Por favor, selecciona una imagen válida (Formatos aceptados: JPG, JPEG, PNG).' 
            });
        }

        const photoUrl = `/uploads-imagen/${req.file.filename}`;
        
        // Llamamos al modelo seguro interno de src
        const photoId = await Photo.create(itemId, photoUrl);

        res.status(201).json({
            success: true,
            message: 'Imagen subida y vinculada al artículo con éxito.',
            photo: {
                id: photoId,
                item_id: itemId,
                photo_url: photoUrl
            }
        });
    } catch (error) {
        next(error);
    }
};

const deletePhoto = async (req, res, next) => {
    try {
        const { photoId } = req.params;
        const photo = await Photo.findById(photoId);
        
        if (!photo) {
            return res.status(404).json({ success: false, message: 'La imagen solicitada no existe.' });
        }

        const filename = photo.photo_url.replace('/uploads-imagen/', '');
        // Ruta exacta para salir de src/controllers y llegar a la carpeta raíz uploads-imagen
        const filePath = path.join(__dirname, '../../uploads-imagen', filename);

        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }

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