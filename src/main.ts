import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { apiReference } from '@scalar/express-api-reference';

// Configurar zona horaria para Colombia (UTC-5)
process.env.TZ = 'America/Bogota';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Habilitar CORS para que Scalar pueda hacer peticiones
  app.enableCors({
    origin: true, // Permitir todos los orígenes en desarrollo
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  });

  // Habilitar validación global para DTOs
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // Eliminar propiedades que no estén en el DTO
      forbidNonWhitelisted: true, // Lanzar error si hay propiedades no permitidas
      transform: true, // Transformar automáticamente los tipos
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
    .addServer('http://localhost:3000', 'Servidor de desarrollo')
    .build();

  const document = SwaggerModule.createDocument(app, config);

  const port = process.env.PORT ?? 3000;
  const baseUrl = `http://localhost:${port}`;

  // Asegurar que el documento tenga el servidor correcto
  if (!document.servers || document.servers.length === 0) {
    document.servers = [{ url: baseUrl, description: 'Servidor de desarrollo' }];
  } else {
    document.servers[0].url = baseUrl;
  }

  // Exponer el JSON de Swagger para que Scalar lo consuma
  app.getHttpAdapter().get('/swagger-json', (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.json(document);
  });

  // Scalar como vista principal en la raíz
  // Usar import dinámico para evitar problemas de tipos
  const { apiReference } = await import('@scalar/express-api-reference');
  
  // Montar Scalar en /docs para no interceptar otros endpoints (POST, etc.)
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

  // Redirigir la raíz a /docs (solo GET) para no afectar POST/PUT
  app.getHttpAdapter().get('/', (req, res) => res.redirect('/docs'));

  // Swagger UI disponible en /swagger
  SwaggerModule.setup('swagger', app, document);
  await app.listen(port);

  console.log(`🚀 Aplicación corriendo en: http://localhost:${port}`);
  console.log(`📚 Scalar disponible en: http://localhost:${port}`);
  console.log(`📖 Swagger UI disponible en: http://localhost:${port}/swagger`);
}
bootstrap();
