// =========================================================================
// ZONA 1: IMPORTACIONES Y CONFIGURACIÓN INICIAL
// =========================================================================
const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

const app = express();
app.use(express.json()); // Habilita la lectura de payloads JSON

// Servir la carpeta de fotos físicas de manera pública
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Enrutamiento base para entregar la interfaz de usuario
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// =========================================================================
// ZONA 2: ALMACENES DE DATOS (BASE DE DATOS EN MEMORIA)
// =========================================================================
// Catálogo maestro de TVs de prueba
const listaAnunciosTV = [
    { id: 'tv-lg-4k', modelo: 'LG UHD 55"', precio: 400 },
    { id: 'tv-samsung-qled', modelo: 'Samsung QLED 65"', precio: 750 }
];

let imagenesDB = []; // Almacena registros de imágenes asociadas
let mensajesDB = []; // Almacena el histórico de mensajería entre usuarios

// =========================================================================
// ZONA 3: CONFIGURACIÓN FOTOS (FILTROS Y POLÍTICAS DE MULTER)
// =========================================================================
const almacenamientoDisco = multer.diskStorage({
    destination: (req, file, cb) => {
        const rutaUploads = './uploads';
        if (!fs.existsSync(rutaUploads)) {
            fs.mkdirSync(rutaUploads); // Crea la carpeta si no existe
        }
        cb(null, rutaUploads);
    },
    filename: (req, file, cb) => {
        const extension = path.extname(file.originalname);
        cb(null, `${uuidv4()}${extension}`); // Genera nombre único e irreversible
    }
});

const gestorMulter = multer({ 
    storage: almacenamientoDisco,
    limits: { 
        fileSize: 2 * 1024 * 1024 // Restricción: Máximo 2MB por archivo
    },
    fileFilter: (req, file, cb) => {
        const formatosPermitidos = ['image/jpeg', 'image/png', 'image/webp'];
        if (formatosPermitidos.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error('FORMATO_RECHAZADO'), false);
        }
    }
});

// =========================================================================
// ZONA 4: ENDPOINTS DEL MÓDULO DE IMÁGENES
// =========================================================================

// POST: Cargar imagen y asociarla a una TV existente
app.post('/api/uploads', gestorMulter.single('imagen'), (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: 'Operación fallida: Archivo no recibido.' });
        }

        const { anuncioId } = req.body;
        const anuncioExiste = listaAnunciosTV.some(tv => tv.id === anuncioId);

        // Validación de consistencia: Si el anuncio no existe, se borra el archivo
        if (!anuncioExiste) {
            fs.unlinkSync(req.file.path); 
            return res.status(404).json({ 
                error: `Asociación denegada: El anuncio ID '${anuncioId}' no existe.` 
            });
        }

        // Registro exitoso en base de datos
        const nuevoRegistroImagen = {
            id: uuidv4(),
            anuncioId: anuncioId,
            url: `/uploads/${req.file.filename}`,
            path: req.file.path
        };
        imagenesDB.push(nuevoRegistroImagen);

        res.status(201).json({
            mensaje: '¡Éxito! Imagen validada y vinculada correctamente.',
            imagen: nuevoRegistroImagen
        });

    } catch (error) {
        res.status(500).json({ error: 'Fallo crítico interno en procesamiento de imagen.' });
    }
});

// DELETE: Eliminación física y lógica de una imagen por ID
app.delete('/api/uploads/:id', (req, res) => {
    const { id } = req.params;
    const posicion = imagenesDB.findIndex(img => img.id === id);
    
    if (posicion === -1) {
        return res.status(404).json({ error: 'La imagen solicitada no existe en los registros.' });
    }

    const metadatosImagen = imagenesDB[posicion];

    // Destrucción física en el disco duro
    fs.unlink(metadatosImagen.path, (errorBorrado) => {
        if (errorBorrado) {
            return res.status(500).json({ error: 'Error del sistema al purgar el archivo físico.' });
        }
        
        // Destrucción lógica en la base de datos
        imagenesDB.splice(posicion, 1);
        res.json({ mensaje: 'Imagen eliminada con éxito del disco y del catálogo.' });
    });
});

// =========================================================================
// ZONA 5: ENDPOINTS DEL MÓDULO DE MENSAJERÍA
// =========================================================================

// POST: Crear nuevo hilo de conversación o responder en un chat activo
app.post('/api/messages', (req, res) => {
    const { anuncioId, remitente, destinatario, texto, conversacionId } = req.body;

    if (!anuncioId || !remitente || !destinatario || !texto) {
        return res.status(400).json({ error: 'Estructura inválida: Faltan parámetros mandatorios.' });
    }

    const anuncioExiste = listaAnunciosTV.some(tv => tv.id === anuncioId);
    if (!anuncioExiste) {
        return res.status(404).json({ error: `Envío rechazado: La TV ID '${anuncioId}' no existe.` });
    }

    // Si no proveen conversacionId significa que es un chat nuevo, se autogenera un ID de conversación corto
    const idConversacionFijado = conversacionId || `conv-${uuidv4().substring(0, 8)}`;

    const nuevoMensaje = {
        id: uuidv4(),
        conversacionId: idConversacionFijado,
        anuncioId,
        remitente,
        destinatario,
        texto,
        fecha: new Date()
    };

    mensajesDB.push(nuevoMensaje);
    res.status(201).json({ 
        mensaje: 'Mensaje transmitido y enrutado con éxito.', 
        datos: nuevoMensaje 
    });
});

// GET: Obtener el log completo histórico de mensajería (Auditoría global)
app.get('/api/messages', (req, res) => {
    res.json(mensajesDB);
});

// GET: Filtrar e incorporar los mensajes de un chat específico
app.get('/api/conversations/:id', (req, res) => {
    const { id } = req.params;
    const historialChat = mensajesDB.filter(msg => msg.conversacionId === id);

    if (historialChat.length === 0) {
        return res.status(404).json({ error: 'La conversación buscada no contiene registros o no existe.' });
    }

    res.json({
        conversacionId: id,
        anuncioId: historialChat[0].anuncioId,
        mensajes: historialChat
    });
});

// =========================================================================
// ZONA 6: CAPA MIDDLEWARE - CAPTURA GLOBAL DE ERRORES DE TRÁFICO
// =========================================================================
app.use((err, req, res, next) => {
    if (err instanceof multer.MulterError && err.code === 'LIMIT_FILE_SIZE') {
        return res.status(400).json({ error: 'Seguridad: El archivo supera el peso máximo de 2MB.' });
    }
    if (err.message === 'FORMATO_RECHAZADO') {
        return res.status(400).json({ error: 'Seguridad: Extensión denegada. Solo se admite .jpg, .png y .webp' });
    }
    res.status(500).json({ error: 'Excepción no controlada: ' + err.message });
});

// =========================================================================
// ZONA 7: IGNICIÓN DEL SERVIDOR
// =========================================================================
const PUERTO = 3000;
app.listen(PUERTO, () => {
    console.log(`🚀 SERVIDOR CORE ARRANCADO EN: http://localhost:${PUERTO}`);
});