"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = handler;
const core_1 = require("@nestjs/core");
const app_module_1 = require("../src/app.module");
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
let cachedServer;
async function bootstrap() {
    if (cachedServer) {
        return cachedServer;
    }
    try {
        console.log('🚀 Inicializando aplicación NestJS...');
        const app = await core_1.NestFactory.create(app_module_1.AppModule, {
            logger: ['error', 'warn', 'log'],
            bodyParser: true,
        });
        const expressApp = app.getHttpAdapter().getInstance();
        process.env.TZ = 'America/Bogota';
        app.enableCors({
            origin: true,
            credentials: true,
            methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
            allowedHeaders: ['Content-Type', 'Authorization'],
        });
        app.useGlobalPipes(new common_1.ValidationPipe({
            whitelist: true,
            forbidNonWhitelisted: true,
            transform: true,
            transformOptions: {
                enableImplicitConversion: true,
            },
        }));
        let swaggerDocument = null;
        const swaggerJsonHandler = (req, res) => {
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
            res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
            res.setHeader('Content-Type', 'application/json');
            if (swaggerDocument) {
                res.json(swaggerDocument);
            }
            else {
                res.status(503).json({ error: 'Swagger document not ready yet' });
            }
        };
        const config = new swagger_1.DocumentBuilder()
            .setTitle('Lenguaje C# API')
            .setDescription('API para la aplicación de aprendizaje del lenguaje C#')
            .setVersion('1.0')
            .addTag('rutas', 'Endpoints relacionados con rutas de aprendizaje')
            .addTag('cursos', 'Endpoints relacionados con cursos')
            .addTag('lecciones', 'Endpoints relacionados con lecciones')
            .addTag('practicas', 'Endpoints relacionados con prácticas y ejercicios')
            .addTag('usuarios', 'Endpoints relacionados con usuarios')
            .addTag('progreso', 'Endpoints relacionados con el progreso del usuario')
            .addTag('auth', 'Endpoints de autenticación')
            .addBearerAuth()
            .addServer('/', 'Producción')
            .build();
        console.log('✅ Inicializando módulos de NestJS...');
        await app.init();
        swaggerDocument = swagger_1.SwaggerModule.createDocument(app, config);
        expressApp.get('/swagger-json', swaggerJsonHandler);
        expressApp.options('/swagger-json', (req, res) => {
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
            res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
            res.sendStatus(200);
        });
        expressApp.get('/docs', (req, res) => {
            res.setHeader('Content-Type', 'text/html');
            res.send(`
<!DOCTYPE html>
<html>
  <head>
    <title>API Documentation - Lenguaje C#</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </head>
  <body>
    <script
      id="api-reference"
      data-url="/swagger-json"></script>
    <script src="https://cdn.jsdelivr.net/npm/@scalar/api-reference"></script>
  </body>
</html>
      `);
        });
        console.log('✅ Scalar configurado en /docs');
        swagger_1.SwaggerModule.setup('swagger', app, swaggerDocument);
        console.log('✅ Swagger UI configurado en /swagger');
        console.log('✅ Rutas registradas: /docs, /swagger, /swagger-json');
        console.log('✅ Aplicación NestJS inicializada correctamente');
        console.log('✅ Rutas de documentación configuradas: /docs, /swagger, /swagger-json');
        console.log('✅ Redirección de / a /docs configurada');
        cachedServer = expressApp;
        return expressApp;
    }
    catch (error) {
        console.error('❌ Error al inicializar la aplicación:', error);
        console.error('Error message:', error?.message);
        if (error?.stack) {
            console.error('Stack trace:', error.stack);
        }
        throw error;
    }
}
async function handler(req, res) {
    try {
        console.log(`📥 Petición recibida: ${req.method} ${req.url}`);
        const server = await bootstrap();
        return new Promise((resolve) => {
            res.on('finish', () => {
                console.log(`✅ Petición completada: ${req.method} ${req.url} - ${res.statusCode}`);
                resolve();
            });
            res.on('error', (err) => {
                console.error('❌ Error en la respuesta:', err);
                resolve();
            });
            server(req, res);
        });
    }
    catch (error) {
        console.error('❌ Error en el handler:', error);
        console.error('Stack trace:', error?.stack);
        if (!res.headersSent) {
            res.status(500).json({
                statusCode: 500,
                message: 'Error interno del servidor',
                error: process.env.NODE_ENV === 'development' || process.env.VERCEL_ENV === 'development'
                    ? error?.message || String(error)
                    : 'Internal Server Error',
                ...(process.env.NODE_ENV === 'development' && { stack: error?.stack }),
            });
        }
    }
}
//# sourceMappingURL=index.js.map