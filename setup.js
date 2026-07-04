const mysql = require('mysql2/promise');

async function inicializarBaseDeDatos() {
    // Configuramos la conexión exacta que usa tu servidor
    const db = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'tv_marketplace_db' // Asegúrate de que esta BD ya esté creada en tu MySQL
    });

    console.log('🔄 Conectando a MySQL para configurar las tablas...');

    try {
        // 1. Tabla de Artículos
        await db.query(`
            CREATE TABLE IF NOT EXISTS items (
                id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(255) NOT NULL,
                user_id INT NOT NULL
            );
        `);
        console.log('✅ Tabla "items" lista.');

        // 2. Tabla de Imágenes
        await db.query(`
            CREATE TABLE IF NOT EXISTS item_images (
                id INT AUTO_INCREMENT PRIMARY KEY,
                item_id INT NOT NULL,
                url VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
            );
        `);
        console.log('✅ Tabla "item_images" lista.');

        // 3. Tabla de Conversaciones
        await db.query(`
            CREATE TABLE IF NOT EXISTS conversations (
                id INT AUTO_INCREMENT PRIMARY KEY,
                item_id INT NOT NULL,
                buyer_id INT NOT NULL,
                seller_id INT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
                UNIQUE KEY unique_negotiation (item_id, buyer_id)
            );
        `);
        console.log('✅ Tabla "conversations" lista.');

        // 4. Tabla de Mensajes
        await db.query(`
            CREATE TABLE IF NOT EXISTS messages (
                id INT AUTO_INCREMENT PRIMARY KEY,
                conversation_id INT NOT NULL,
                sender_id INT NOT NULL,
                text TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE
            );
        `);
        console.log('✅ Tabla "messages" lista.');

        console.log('\n🚀 ¡Todo listo! Tu base de datos tiene la estructura perfecta para la Fase 3 y la Fase 5.');
    } catch (error) {
        console.error('❌ Error configurando las tablas:', error.message);
    } finally {
        await db.end();
    }
}

inicializarBaseDeDatos();