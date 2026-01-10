import { NestFactory } from '@nestjs/core';
import { ExpressAdapter } from '@nestjs/platform-express';
import { AppModule } from '../src/app.module';
import express from 'express';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

let cachedApp: any;

async function createApp() {
  if (cachedApp) {
    return cachedApp;
  }

  const expressApp = express();
  const app = await NestFactory.create(AppModule, new ExpressAdapter(expressApp));

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
    .addServer(process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : 'http://localhost:3000', process.env.VERCEL_URL ? 'Producción' : 'Desarrollo')
    .build();

  const document = SwaggerModule.createDocument(app, config);

  // Ajustar URL base según el entorno (Vercel proporciona VERCEL_URL)
  const vercelUrl = process.env.VERCEL_URL 
    ? `https://${process.env.VERCEL_URL}` 
    : null;
  
  const baseUrl = vercelUrl || `http://localhost:${process.env.PORT || 3000}`;

  if (!document.servers || document.servers.length === 0) {
    document.servers = [{ url: baseUrl, description: vercelUrl ? 'Producción' : 'Desarrollo' }];
  } else {
    document.servers[0].url = baseUrl;
  }

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
    console.warn('Error al cargar Scalar:', error);
  }

  // Redirigir la raíz a /docs
  app.getHttpAdapter().get('/', (req, res) => res.redirect('/docs'));

  // Swagger UI disponible en /swagger
  SwaggerModule.setup('swagger', app, document);

  await app.init();
  cachedApp = app;
  return app;
}

export default async function handler(req: express.Request, res: express.Response) {
  const app = await createApp();
  const expressInstance = app.getHttpAdapter().getInstance();
  expressInstance(req, res);
}
