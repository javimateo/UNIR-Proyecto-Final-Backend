// Controlador temporal para comprobar que los parámetros llegan bien

exports.uploadPhoto = async (req, res) => {
    try {
        const itemId = req.params.id; // Captura el :id del artículo
        
        // Aquí irá tu lógica para subir la foto (Multer, Cloudinary, etc.)
        
        return res.status(201).json({
            status: "success",
            message: `Foto añadida correctamente al item ${itemId}`
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

exports.deletePhoto = async (req, res) => {
    try {
        const itemId = req.params.id;        // Captura el :id del artículo
        const photoId = req.params.photoId;  // Captura el :photoId de la foto
        
        // Aquí irá tu lógica para borrar el archivo del servidor/base de datos
        
        return res.status(200).json({
            status: "success",
            message: `Foto ${photoId} eliminada del item ${itemId}`
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};