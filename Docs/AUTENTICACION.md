# Sistema de Autenticación

## Instalación de Dependencias

Ejecuta el siguiente comando para instalar las dependencias necesarias:

```bash
pnpm add @nestjs/jwt @nestjs/passport passport passport-jwt bcrypt
pnpm add -D @types/passport-jwt @types/bcrypt class-validator class-transformer
```

O si usas npm:

```bash
npm install @nestjs/jwt @nestjs/passport passport passport-jwt bcrypt
npm install -D @types/passport-jwt @types/bcrypt class-validator class-transformer
```

## Configuración del archivo .env

Agrega las siguientes variables a tu archivo `.env`:

```env
# JWT Configuration
JWT_SECRET=tu-secret-key-super-seguro-cambiar-en-produccion
JWT_EXPIRES_IN=7d
```

**⚠️ IMPORTANTE:** En producción, usa un `JWT_SECRET` fuerte y seguro. Puedes generarlo con:

```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

## Endpoints Disponibles

### 1. Registrar Usuario

**POST** `/auth/register`

**Body:**
```json
{
  "nombreUsuario": "juan123",
  "email": "juan@example.com",
  "contrasena": "MiPassword123!",
  "nombreCompleto": "Juan Pérez"
}
```

**Respuesta exitosa (201):**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "usuarioId": 1,
    "nombreUsuario": "juan123",
    "email": "juan@example.com",
    "nombreCompleto": "Juan Pérez",
    "puntosTotales": 0,
    "nivel": 1
  }
}
```

### 2. Iniciar Sesión

**POST** `/auth/login`

**Body:**
```json
{
  "emailOrUsername": "juan@example.com",
  "contrasena": "MiPassword123!"
}
```

**Respuesta exitosa (200):**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "usuarioId": 1,
    "nombreUsuario": "juan123",
    "email": "juan@example.com",
    "nombreCompleto": "Juan Pérez",
    "puntosTotales": 0,
    "nivel": 1
  }
}
```

## Uso del Token JWT

Una vez que obtengas el `accessToken`, úsalo en las peticiones protegidas:

**Header:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

## Proteger Endpoints

Para proteger un endpoint y requerir autenticación:

```typescript
import { Controller, Get, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from './auth/guards/jwt-auth.guard';
import { GetUser } from './auth/decorators/get-user.decorator';

@Controller('rutas')
@UseGuards(JwtAuthGuard) // Protege todos los endpoints del controlador
export class RutasController {
  @Get()
  findAll(@GetUser() user) {
    // user contiene: { usuarioId, email, nombreUsuario }
    console.log('Usuario autenticado:', user);
    // Tu lógica aquí
  }
}
```

### Endpoints Públicos

Si necesitas que un endpoint sea público (sin autenticación):

```typescript
import { Public } from './auth/decorators/public.decorator';

@Controller('rutas')
@UseGuards(JwtAuthGuard)
export class RutasController {
  @Public() // Este endpoint es público
  @Get('public')
  findPublic() {
    // No requiere autenticación
  }

  @Get('private')
  findPrivate(@GetUser() user) {
    // Requiere autenticación
  }
}
```

## Estructura de Archivos

```
src/auth/
├── dto/
│   ├── register.dto.ts       # DTO para registro
│   ├── login.dto.ts          # DTO para login
│   └── auth-response.dto.ts  # DTO para respuesta
├── decorators/
│   ├── public.decorator.ts   # Decorador para endpoints públicos
│   └── get-user.decorator.ts # Decorador para obtener usuario actual
├── guards/
│   └── jwt-auth.guard.ts     # Guard para proteger endpoints
├── strategies/
│   └── jwt.strategy.ts       # Estrategia JWT para Passport
├── auth.controller.ts        # Controlador de autenticación
├── auth.service.ts           # Servicio de autenticación
└── auth.module.ts           # Módulo de autenticación
```

## Validaciones

- **Registro:**
  - `nombreUsuario`: mínimo 3 caracteres, máximo 50
  - `email`: debe ser un email válido
  - `contrasena`: mínimo 6 caracteres
  - `nombreCompleto`: opcional, máximo 100 caracteres

- **Login:**
  - `emailOrUsername`: puede ser email o nombre de usuario
  - `contrasena`: mínimo 6 caracteres

## Seguridad

✅ Contraseñas hasheadas con bcrypt (10 salt rounds)
✅ Tokens JWT con expiración configurable
✅ Validación de credenciales
✅ Verificación de usuarios activos
✅ Protección de endpoints con guards
✅ Endpoints públicos marcados explícitamente

## Próximos Pasos

- [ ] Implementar refresh tokens
- [ ] Agregar rate limiting
- [ ] Implementar recuperación de contraseña
- [ ] Agregar verificación de email
- [ ] Implementar logout (blacklist de tokens)

