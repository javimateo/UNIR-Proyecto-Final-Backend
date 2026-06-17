const swaggerJSDoc = require('swagger-jsdoc');

const swaggerOptions = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Plataforma de Compraventa — API',
      version: '1.0.0',
      description: 'API REST para la plataforma de compraventa de tecnología de segunda mano (UNIR TFM)'
    },
    servers: [
      {
        url: 'http://localhost:3000',
        description: 'Servidor Local'
      }
    ],
    paths: {
      // Metemos aquí la ruta de subida de imágenes de forma segura
      '/api/uploads': {
        post: {
          summary: 'Subir una imagen y asociarla a un anuncio',
          tags: ['Imágenes'],
          requestBody: {
            required: true,
            content: {
              'multipart/form-data': {
                schema: {
                  type: 'object',
                  properties: {
                    itemId: {
                      type: 'integer',
                      description: 'ID del anuncio al que pertenece la foto'
                    },
                    image: {
                      type: 'string',
                      format: 'binary',
                      description: 'Archivo de imagen (jpg, jpeg, png)'
                    }
                  }
                }
              }
            }
          },
          responses: {
            201: { description: 'Imagen vinculada con éxito' },
            400: { description: 'Formato no válido' },
            404: { description: 'El anuncio no existe' },
            500: { description: 'Error interno' }
          }
        }
      }
    }
  },
  apis: ['./src/routes/*.js'] // Esto seguirá leyendo de forma automática tus otras rutas (auth, messages, etc.)
};

const swaggerSpec = swaggerJSDoc(swaggerOptions);

module.exports = swaggerSpec;