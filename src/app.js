const express = require('express');
const cors = require('cors');
const path = require('path');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./config/swagger');
const errorMiddleware = require('./middlewares/error.middleware');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/uploads-imagen', express.static(path.join(__dirname, '../uploads-imagen')));

app.use('/api/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use('/api/auth',       require('./routes/auth.routes'));
app.use('/api/items',      require('./routes/items.routes'));
app.use('/api/photos',     require('./routes/photos.routes'));
app.use('/api/users',      require('./routes/users.routes'));
app.use('/api/categories', require('./routes/categories.routes'));
app.use('/api/favorites',  require('./routes/favorites.routes'));
app.use('/api/messages',   require('./routes/messages.routes'));
app.use('/api/brands',        require('./routes/brands.routes'));
// app.use('/api/conversations', require('./routes/conversations.routes'));
app.use('/api/reports',       require('./routes/reports.routes'));
app.use('/api/admin/stats',   require('./routes/stats.routes'));
// app.use('/api/valuations',    require('./routes/valuations.routes'));

app.use(errorMiddleware);

module.exports = app;
