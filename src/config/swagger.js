const swaggerJsdoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Plataforma de Compraventa — API',
      version: '1.0.0',
      description: 'API REST para la plataforma de compraventa de tecnología de segunda mano (UNIR TFM)',
    },
    servers: [
      { url: process.env.API_URL || 'http://localhost:3000', description: 'Servidor activo' },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
    },
  },
  apis: ['./src/routes/*.js'],
};

module.exports = swaggerJsdoc(options);
