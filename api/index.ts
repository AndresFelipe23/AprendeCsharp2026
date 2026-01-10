import { NestFactory } from '@nestjs/core';
import { ExpressAdapter } from '@nestjs/platform-express';
import { AppModule } from '../src/app.module';
import express from 'express';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

let cachedServer: express.Express;

async function bootstrap(): Promise<express.Express> {
  if (cachedServer) {
    return cachedServer;
  }

  try {
    console.log('🚀 Inicializando aplicación NestJS...');
    // Crear la aplicación NestJS - dejar que ExpressAdapter maneje Express internamente
    const app = await NestFactory.create(AppModule, {
      logger: ['error', 'warn', 'log'],
      bodyParser: true,
    });
    
    // Obtener la instancia de Express después de la creación
    const expressApp = app.getHttpAdapter().getInstance() as express.Express;

    // Configurar zona horaria para Colombia (UTC-5)
    process.env.TZ = 'America/Bogota';

    // Habilitar CORS
    app.enableCors({
      origin: true,
      credentials: true,
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
      allowedHeaders: ['Content-Type', 'Authorization'],
    });

    // Habilitar validación global para DTOs
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
        transformOptions: {
          enableImplicitConversion: true,
        },
      }),
    );

    // Variables para los handlers que se crearán después
    let swaggerDocument: any = null;
    
    // Handler para /swagger-json
    const swaggerJsonHandler = (req: express.Request, res: express.Response) => {
      // Asegurar que CORS esté habilitado para este endpoint
      res.setHeader('Access-Control-Allow-Origin', '*');
      res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
      res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
      res.setHeader('Content-Type', 'application/json');
      
      if (swaggerDocument) {
        res.json(swaggerDocument);
      } else {
        res.status(503).json({ error: 'Swagger document not ready yet' });
      }
    };

    // Configuración de Swagger/OpenAPI (usaremos URL relativa para evitar problemas con Vercel)
    const config = new DocumentBuilder()
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
      .addServer('/', 'Producción') // URL relativa funciona en cualquier entorno
      .build();

    console.log('✅ Inicializando módulos de NestJS...');
    await app.init();

    // Crear el documento de Swagger DESPUÉS de inicializar
    swaggerDocument = SwaggerModule.createDocument(app, config);

    // Registrar /swagger-json DESPUÉS de crear el documento
    expressApp.get('/swagger-json', swaggerJsonHandler);
    expressApp.options('/swagger-json', (req, res) => {
      res.setHeader('Access-Control-Allow-Origin', '*');
      res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
      res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
      res.sendStatus(200);
    });

    // Configurar Scalar manualmente como HTML en /docs
    // En Vercel serverless, app.use() no funciona correctamente después de init
    // Por eso servimos el HTML de Scalar directamente
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

    // Configurar Swagger UI en /swagger usando SwaggerModule
    // Esto registra automáticamente las rutas en /swagger DESPUÉS de Scalar
    SwaggerModule.setup('swagger', app, swaggerDocument);
    console.log('✅ Swagger UI configurado en /swagger');
    console.log('✅ Rutas registradas: /docs, /swagger, /swagger-json');

    // NO registrar la redirección aquí porque NestJS lo manejará a través del controlador
    
    console.log('✅ Aplicación NestJS inicializada correctamente');
    console.log('✅ Rutas de documentación configuradas: /docs, /swagger, /swagger-json');
    console.log('✅ Redirección de / a /docs configurada');
    cachedServer = expressApp;
    return expressApp;
  } catch (error: any) {
    console.error('❌ Error al inicializar la aplicación:', error);
    console.error('Error message:', error?.message);
    if (error?.stack) {
      console.error('Stack trace:', error.stack);
    }
    throw error;
  }
}

export default async function handler(req: express.Request, res: express.Response) {
  try {
    console.log(`📥 Petición recibida: ${req.method} ${req.url}`);
    const server = await bootstrap();
    
    // Envolver en una promesa para manejar correctamente el flujo asíncrono
    return new Promise<void>((resolve) => {
      // Manejar el fin de la respuesta
      res.on('finish', () => {
        console.log(`✅ Petición completada: ${req.method} ${req.url} - ${res.statusCode}`);
        resolve();
      });
      
      // Manejar errores en la respuesta
      res.on('error', (err) => {
        console.error('❌ Error en la respuesta:', err);
        resolve();
      });
      
      // Procesar la petición con Express
      server(req, res);
    });
  } catch (error: any) {
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
