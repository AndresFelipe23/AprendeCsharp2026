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

    // Ajustar URL base según el entorno (Vercel proporciona VERCEL_URL)
    const vercelUrl = process.env.VERCEL_URL 
      ? `https://${process.env.VERCEL_URL}` 
      : null;
    
    const baseUrl = vercelUrl || `http://localhost:${process.env.PORT || 3000}`;

    console.log(`📝 URL base configurada: ${baseUrl}`);

    // Configuración de Swagger/OpenAPI
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
      .addServer(baseUrl, vercelUrl ? 'Producción' : 'Desarrollo')
      .build();

    const document = SwaggerModule.createDocument(app, config);

    // Exponer el JSON de Swagger
    app.getHttpAdapter().get('/swagger-json', (req, res) => {
      res.setHeader('Content-Type', 'application/json');
      res.json(document);
    });

    // Scalar como vista principal
    try {
      const { apiReference } = await import('@scalar/express-api-reference');
      app.use(
        '/docs',
        apiReference({
          theme: 'default',
          layout: 'modern',
          spec: {
            url: `${baseUrl}/swagger-json`,
          },
          withDefaultFonts: true,
        } as any),
      );
    } catch (error) {
      console.warn('⚠️ Error al cargar Scalar:', error);
    }

    // Redirigir la raíz a /docs
    app.getHttpAdapter().get('/', (req, res) => res.redirect('/docs'));

    // Swagger UI disponible en /swagger
    SwaggerModule.setup('swagger', app, document);

    console.log('✅ Inicializando módulos de NestJS...');
    await app.init();
    
    console.log('✅ Aplicación NestJS inicializada correctamente');
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
