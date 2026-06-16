const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

const app = express();
app.use(express.json());

// ==========================================
// 1. ARCHIVOS ESTÁTICOS Y RUTA DEL FRONTEND
// ==========================================
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// ==========================================
// 2. BASE DE DATOS SIMULADA
// ==========================================
const listaAnunciosTV = [
    { id: 'tv-lg-4k', modelo: 'LG UHD 55"', precio: 400 },
    { id: 'tv-samsung-qled', modelo: 'Samsung QLED 65"', precio: 750 }
];
let imagenesDB = []; 

// ==========================================
// 3. CONFIGURACIÓN DE ALMACENAMIENTO (MULTER)
// ==========================================
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadDir = './uploads';
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir);
        }
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const ext = path.extname(file.originalname);
        cb(null, `${uuidv4()}${ext}`);
    }
});

const upload = multer({ 
    storage: storage,
    limits: { 
        fileSize: 2 * 1024 * 1024 
    },
    fileFilter: (req, file, cb) => {
        const formatosValidos = ['image/jpeg', 'image/png', 'image/webp'];
        if (formatosValidos.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error('FORMATO_INVALIDO'), false);
        }
    }
});

// ==========================================
// 4. ENDPOINT: SUBIR Y ASOCIAR IMAGEN (POST)
// ==========================================
app.post('/api/uploads', upload.single('imagen'), (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: 'Debes seleccionar una imagen.' });
        }

        const { anuncioId } = req.body;

        const anuncioExiste = listaAnunciosTV.some(tv => tv.id === anuncioId);

        if (!anuncioExiste) {
            fs.unlinkSync(req.file.path); 
            return res.status(404).json({ 
                error: `Asociación fallida: El anuncio con ID '${anuncioId}' no existe en nuestro catálogo.` 
            });
        }

        const nuevaImagen = {
            id: uuidv4(),
            anuncioId: anuncioId,
            url: `/uploads/${req.file.filename}`,
            path: req.file.path
        };
        imagenesDB.push(nuevaImagen);

        res.status(201).json({
            mensaje: '¡Validaciones superadas! Imagen asociada con éxito.',
            imagen: nuevaImagen
        });

    } catch (error) {
        res.status(500).json({ error: 'Error interno en el servidor.' });
    }
});

// ==========================================
// 5. ENDPOINT: BORRADO SEGURO (DELETE)
// ==========================================
app.delete('/api/uploads/:id', (req, res) => {
    const { id } = req.params;
    const imagenIndex = imagenesDB.findIndex(img => img.id === id);
    
    if (imagenIndex === -1) {
        return res.status(404).json({ error: 'La imagen no existe en el catálogo.' });
    }

    const imagen = imagenesDB[imagenIndex];

    fs.unlink(imagen.path, (err) => {
        if (err) {
            return res.status(500).json({ error: 'No se pudo eliminar el archivo físico del servidor.' });
        }
        
        imagenesDB.splice(imagenIndex, 1);
        res.json({ mensaje: 'Imagen eliminada correctamente del disco y del catálogo.' });
    });
});

// ==========================================
// 6. GESTIÓN GLOBAL DE ERRORES
// ==========================================
app.use((err, req, res, next) => {
    if (err instanceof multer.MulterError && err.code === 'LIMIT_FILE_SIZE') {
        return res.status(400).json({ error: 'Tamaño máximo excedido (Límite: 2MB).' });
    }
    if (err.message === 'FORMATO_INVALIDO') {
        return res.status(400).json({ error: 'Formato no permitido. Solo se aceptan .jpg, .jpeg, .png y .webp' });
    }
    res.status(500).json({ error: 'Error inesperado: ' + err.message });
});

// ==========================================
// 7. ARRANQUE DEL SERVIDOR
// ==========================================
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor listo en http://localhost:${PORT}`);
});