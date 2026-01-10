# Configuración de Scalar API Documentation

## Instalación

Ejecuta el siguiente comando para instalar las dependencias necesarias:

```bash
pnpm add @nestjs/swagger @scalar/express-api-reference
```

O si usas npm:

```bash
npm install @nestjs/swagger @scalar/express-api-reference
```

## Configuración

Scalar está configurado para mostrarse automáticamente en la ruta raíz (`/`) cuando inicies la aplicación.

### Archivos Configurados

- **`src/main.ts`** - Configuración principal de Scalar y Swagger
- **`src/app.controller.ts`** - Ejemplo de controlador con decoradores de Swagger

## Uso

### Iniciar la aplicación

```bash
pnpm run start:dev
```

### Acceder a la documentación

Una vez que la aplicación esté corriendo:

- **Scalar UI**: http://localhost:3000 (ruta raíz)
- **Swagger UI**: http://localhost:3000/swagger (alternativa)

## Agregar Documentación a tus Endpoints

### Ejemplo básico

```typescript
import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBody } from '@nestjs/swagger';

@ApiTags('rutas')
@Controller('rutas')
export class RutasController {
  @Get()
  @ApiOperation({ summary: 'Obtener todas las rutas' })
  @ApiResponse({ status: 200, description: 'Lista de rutas obtenida exitosamente' })
  findAll() {
    // Tu lógica aquí
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una ruta por ID' })
  @ApiParam({ name: 'id', type: 'number', description: 'ID de la ruta' })
  @ApiResponse({ status: 200, description: 'Ruta encontrada' })
  @ApiResponse({ status: 404, description: 'Ruta no encontrada' })
  findOne(@Param('id') id: number) {
    // Tu lógica aquí
  }

  @Post()
  @ApiOperation({ summary: 'Crear una nueva ruta' })
  @ApiBody({ 
    schema: {
      type: 'object',
      properties: {
        nombre: { type: 'string', example: 'Fundamentos de C#' },
        descripcionCorta: { type: 'string', example: 'Aprende los conceptos básicos' },
        orden: { type: 'number', example: 1 }
      }
    }
  })
  @ApiResponse({ status: 201, description: 'Ruta creada exitosamente' })
  create(@Body() createRutaDto: any) {
    // Tu lógica aquí
  }
}
```

### Usar DTOs con decoradores

Para una mejor documentación, crea DTOs con decoradores de Swagger:

```typescript
import { ApiProperty } from '@nestjs/swagger';

export class CreateRutaDto {
  @ApiProperty({ 
    description: 'Nombre de la ruta',
    example: 'Fundamentos de C#',
    maxLength: 100
  })
  nombre: string;

  @ApiProperty({ 
    description: 'Descripción corta de la ruta',
    example: 'Aprende los conceptos básicos del lenguaje C#',
    required: false,
    maxLength: 255
  })
  descripcionCorta?: string;

  @ApiProperty({ 
    description: 'Orden de visualización',
    example: 1,
    minimum: 1
  })
  orden: number;
}
```

## Personalización

### Cambiar el tema

En `src/main.ts`, puedes cambiar el tema de Scalar:

```typescript
app.use(
  '/',
  apiReference({
    theme: 'purple', // 'default', 'purple', 'blue', 'green', etc.
    layout: 'modern',
    spec: {
      content: document,
    },
  }),
);
```

### Cambiar la ruta

Si quieres que Scalar esté en una ruta diferente (por ejemplo `/api-docs`):

```typescript
app.use(
  '/api-docs',
  apiReference({
    // ... configuración
  }),
);
```

## Características

✅ Documentación automática desde decoradores de Swagger
✅ Interfaz moderna y fácil de usar
✅ Ejemplos de requests y responses
✅ Prueba de endpoints directamente desde la UI
✅ Soporte para múltiples servidores
✅ Temas personalizables

## Notas

- Scalar usa el spec de OpenAPI generado por Swagger
- Todos los decoradores de `@nestjs/swagger` funcionan con Scalar
- La documentación se actualiza automáticamente cuando cambias los endpoints

