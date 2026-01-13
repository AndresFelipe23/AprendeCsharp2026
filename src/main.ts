import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { config } from 'dotenv';
import { resolve } from 'path';

// Cargar variables de entorno desde .env
// Usar ruta absoluta para asegurar que se encuentre el archivo
const envPath = resolve(process.cwd(), '.env');
config({ path: envPath });

// Log para verificar que se cargó (también en producción para debug)
console.log('📁 Archivo .env cargado desde:', envPath);
console.log('🔍 DB_HOST:', process.env.DB_HOST || 'NO DEFINIDO');
console.log('🔍 DB_PORT:', process.env.DB_PORT || 'NO DEFINIDO');
console.log('🔍 DB_USERNAME:', process.env.DB_USERNAME || 'NO DEFINIDO');
console.log('🔍 DB_DATABASE:', process.env.DB_DATABASE || 'NO DEFINIDO');
console.log('🔍 NODE_ENV:', process.env.NODE_ENV || 'NO DEFINIDO');

// Configurar zona horaria para Colombia (UTC-5)
process.env.TZ = 'America/Bogota';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Configurar CORS según el entorno
  const isProduction = process.env.NODE_ENV === 'production';
  const allowedOrigins = isProduction
    ? [
        'https://aprendecsharp.site',
        'https://www.aprendecsharp.site',
        // Agrega aquí otros dominios permitidos si es necesario
      ]
    : true; // Permitir todos los orígenes en desarrollo

  app.enableCors({
    origin: allowedOrigins,
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
  const host = isProduction ? '0.0.0.0' : 'localhost';
  
  // Configurar URL base según el entorno
  const baseUrl = isProduction
    ? 'https://aprendecsharp.site'
    : `http://localhost:${port}`;

  // Asegurar que el documento tenga el servidor correcto
  if (!document.servers || document.servers.length === 0) {
    document.servers = [{ 
      url: baseUrl, 
      description: isProduction ? 'Servidor de producción' : 'Servidor de desarrollo' 
    }];
  } else {
    document.servers[0].url = baseUrl;
  }

  // Exponer el JSON de Swagger para que Scalar lo consuma
  app.getHttpAdapter().get('/swagger-json', (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.json(document);
  });

  // Montar Scalar en /docs para no interceptar otros endpoints (POST, etc.)
  // Deshabilitado en producción debido a problemas con módulos ES Module
  if (!isProduction) {
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
      console.log('✅ Scalar configurado en /docs');
    } catch (error) {
      console.warn('⚠️  No se pudo cargar Scalar, usando Swagger UI en /docs');
      SwaggerModule.setup('docs', app, document);
      console.log('✅ Swagger UI configurado en /docs (fallback)');
    }
  } else {
    // En producción, usar Swagger UI en /docs
    console.log('📝 Configurando Swagger UI en /docs para producción...');
    SwaggerModule.setup('docs', app, document);
    console.log('✅ Swagger UI configurado en /docs');
  }

  // Swagger UI disponible en /swagger
  console.log('📝 Configurando Swagger UI en /swagger...');
  SwaggerModule.setup('swagger', app, document);
  console.log('✅ Swagger UI configurado en /swagger');
  
  // Escuchar en 0.0.0.0 en producción para permitir conexiones externas a través de Nginx
  console.log(`🔌 Iniciando servidor en ${host}:${port}...`);
  await app.listen(port, host);
  console.log(`✅ Servidor iniciado correctamente en ${host}:${port}`);

  const serverUrl = isProduction ? baseUrl : `http://${host}:${port}`;
  console.log(`🚀 Aplicación corriendo en: ${serverUrl}`);
  if (!isProduction) {
    console.log(`📚 Scalar disponible en: ${serverUrl}/docs`);
  }
  console.log(`📖 Swagger UI disponible en: ${serverUrl}/swagger`);
  console.log(`🌍 Entorno: ${isProduction ? 'Producción' : 'Desarrollo'}`);
}
bootstrap();
