# Lenguaje C# Backend API

API REST desarrollada con NestJS para la aplicación de aprendizaje del lenguaje C#. Este backend proporciona servicios de autenticación, gestión de cursos, lecciones, prácticas y seguimiento del progreso de los usuarios.

## 🚀 Tecnologías

- **NestJS** - Framework Node.js progresivo para construir aplicaciones del lado del servidor eficientes y escalables
- **TypeORM** - ORM para TypeScript y JavaScript
- **SQL Server** - Base de datos relacional
- **JWT** - Autenticación basada en tokens
- **Passport** - Middleware de autenticación
- **Swagger/Scalar** - Documentación interactiva de la API
- **bcrypt** - Hashing de contraseñas

## 📋 Requisitos Previos

- Node.js (v18 o superior)
- npm, pnpm o yarn
- SQL Server (local o remoto)
- Git

## 🔧 Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd lenguaje_backend
   ```

2. **Instalar dependencias**
   ```bash
   pnpm install
   # o
   npm install
   # o
   yarn install
   ```

3. **Configurar variables de entorno**
   
   Crea un archivo `.env` en la raíz del proyecto con las siguientes variables:
   
   ```bash
   cp .env.example .env
   ```
   
   Luego edita el archivo `.env` con tus valores:
   ```env
   # Base de datos
   DB_HOST=localhost
   DB_PORT=1433
   DB_USERNAME=sa
   DB_PASSWORD=tu_password
   DB_DATABASE=LenguajeCsharp
   DB_ENCRYPT=false
   
   # JWT
   JWT_SECRET=tu-secret-key-super-segura-cambiar-en-produccion
   JWT_EXPIRES_IN=7d
   
   # Servidor
   PORT=3000
   NODE_ENV=development
   ```

4. **Configurar la base de datos**
   
   Ejecuta los scripts SQL ubicados en la carpeta `Database/` para crear las tablas necesarias:
   - `database_schema.sql` - Estructura de la base de datos
   - `insert_rutas.sql` - Datos iniciales de rutas
   - Otros scripts según sea necesario

## 🏃 Ejecución

### Modo desarrollo
```bash
pnpm run start:dev
# o
npm run start:dev
```

### Modo producción
```bash
# Compilar
pnpm run build

# Ejecutar
pnpm run start:prod
```

### Otros comandos disponibles
```bash
# Formatear código
pnpm run format

# Linter
pnpm run lint

# Tests
pnpm run test
pnpm run test:e2e
pnpm run test:cov
```

## 📚 Documentación de la API

Una vez que la aplicación esté ejecutándose, puedes acceder a la documentación interactiva:

- **Scalar UI**: http://localhost:3000/docs (Recomendado)
- **Swagger UI**: http://localhost:3000/swagger
- **Swagger JSON**: http://localhost:3000/swagger-json

## 🔐 Autenticación

La API utiliza autenticación basada en JWT (JSON Web Tokens). Para usar endpoints protegidos:

1. Registra un usuario o inicia sesión en `/auth/register` o `/auth/login`
2. Obtendrás un token JWT en la respuesta
3. Incluye el token en las peticiones como header:
   ```
   Authorization: Bearer <tu-token-jwt>
   ```

## 📁 Estructura del Proyecto

```
lenguaje_backend/
├── src/
│   ├── auth/              # Módulo de autenticación
│   │   ├── decorators/    # Decoradores personalizados
│   │   ├── dto/           # Data Transfer Objects
│   │   ├── guards/        # Guards de autenticación
│   │   └── strategies/    # Estrategias de Passport
│   ├── config/            # Configuraciones
│   ├── cursos/            # Módulo de cursos
│   ├── database/          # Módulo de base de datos
│   ├── entities/          # Entidades de TypeORM
│   ├── lecciones/         # Módulo de lecciones
│   ├── practicas/         # Módulo de prácticas
│   ├── progreso/          # Módulo de progreso
│   └── rutas/             # Módulo de rutas
├── Database/              # Scripts SQL
├── Docs/                  # Documentación adicional
├── test/                  # Tests
└── dist/                  # Build de producción
```

## 🗄️ Base de Datos

La aplicación utiliza SQL Server como base de datos. Las entidades principales son:

- **Usuario** - Información de usuarios
- **Ruta** - Rutas de aprendizaje
- **Curso** - Cursos dentro de las rutas
- **Leccion** - Lecciones dentro de los cursos
- **Practica** - Prácticas y ejercicios
- **ProgresoLeccion** - Progreso del usuario en lecciones
- **ProgresoPractica** - Progreso del usuario en prácticas

## 🌐 Endpoints Principales

### Autenticación
- `POST /auth/register` - Registro de nuevo usuario
- `POST /auth/login` - Inicio de sesión
- `GET /auth/profile` - Obtener perfil del usuario autenticado
- `PUT /auth/profile` - Actualizar perfil
- `PUT /auth/change-password` - Cambiar contraseña

### Rutas
- `GET /rutas` - Listar todas las rutas
- `GET /rutas/:id` - Obtener ruta por ID

### Cursos
- `GET /cursos` - Listar cursos
- `GET /cursos/:id` - Obtener curso por ID

### Lecciones
- `GET /lecciones` - Listar lecciones
- `GET /lecciones/:id` - Obtener lección por ID

### Prácticas
- `GET /practicas` - Listar prácticas
- `GET /practicas/:id` - Obtener práctica por ID
- `POST /practicas/:id/validar` - Validar respuesta de práctica

### Progreso
- `GET /progreso/completo` - Obtener progreso completo del usuario
- `GET /progreso/ruta/:rutaId` - Progreso en una ruta específica
- `GET /progreso/curso/:cursoId` - Progreso en un curso específico
- `POST /progreso/marcar-leccion` - Marcar lección como completada
- `GET /progreso/estadisticas` - Estadísticas del usuario

## 🚢 Despliegue

### Despliegue en Vercel

Este proyecto está configurado para desplegarse en Vercel usando funciones serverless. Sigue estos pasos:

#### 1. Preparación

Asegúrate de tener:
- Una cuenta en [Vercel](https://vercel.com)
- El proyecto conectado a un repositorio de GitHub
- Una base de datos SQL Server accesible desde internet (Azure SQL Database recomendado)

#### 2. Instalación de Vercel CLI (opcional)

```bash
npm i -g vercel
```

#### 3. Configurar Variables de Entorno en Vercel

Ve a tu proyecto en Vercel Dashboard → Settings → Environment Variables y agrega:

```
DB_HOST=tu-servidor-sql.database.windows.net
DB_PORT=1433
DB_USERNAME=tu-usuario
DB_PASSWORD=tu-password-segura
DB_DATABASE=LenguajeCsharp
DB_ENCRYPT=true
JWT_SECRET=tu-secret-key-super-segura-produccion
JWT_EXPIRES_IN=7d
NODE_ENV=production
TZ=America/Bogota
```

**⚠️ IMPORTANTE**: 
- Para Azure SQL Database, usa `DB_ENCRYPT=true`
- Usa un `JWT_SECRET` fuerte y único en producción
- Nunca compartas tus variables de entorno públicamente

#### 4. Desplegar

**Opción A: Desde GitHub (Recomendado)**
1. Conecta tu repositorio de GitHub a Vercel
2. Vercel detectará automáticamente el proyecto
3. Configura las variables de entorno
4. Haz push a la rama principal para desplegar automáticamente

**Opción B: Desde CLI**
```bash
vercel
```

**Opción C: Desde Dashboard**
1. Ve a [vercel.com/new](https://vercel.com/new)
2. Importa tu repositorio de GitHub
3. Configura las variables de entorno
4. Haz clic en "Deploy"

#### 5. Configuración Adicional

El archivo `vercel.json` está configurado para:
- Usar funciones serverless con Node.js
- Enrutar todas las peticiones a `/api`
- Configurar timeout y memoria apropiados

#### 6. Notas sobre SQL Server

**IMPORTANTE**: Vercel no puede alojar SQL Server directamente. Necesitas:

1. **Azure SQL Database** (Recomendado):
   - Crea una instancia en Azure Portal
   - Configura el firewall para permitir conexiones desde Vercel
   - Usa la cadena de conexión proporcionada por Azure

2. **Otra opción**: Base de datos SQL Server en la nube accesible públicamente
   - Asegúrate de que el firewall permita conexiones desde cualquier IP de Vercel
   - O configura una IP específica si es posible

3. **Configuración de Firewall**:
   - En Azure: Settings → Firewalls and virtual networks
   - Permite "Allow Azure services and resources to access this server"
   - O configura las IPs de Vercel si es necesario

#### 7. Verificar el Despliegue

Una vez desplegado, verifica:
- La API está disponible en `https://tu-proyecto.vercel.app`
- La documentación está en `https://tu-proyecto.vercel.app/docs`
- Las conexiones a la base de datos funcionan correctamente

#### 8. Logs y Debugging

Para ver los logs en Vercel:
```bash
vercel logs
```

O desde el Dashboard: Deployments → Selecciona un deployment → Functions → Ver logs

### Variables de Entorno en Producción

Asegúrate de configurar todas las variables de entorno en tu plataforma de despliegue. **Nunca** subas archivos `.env` al repositorio.

**Variables requeridas para Vercel:**
- `DB_HOST` - Host de tu base de datos SQL Server
- `DB_PORT` - Puerto (generalmente 1433)
- `DB_USERNAME` - Usuario de la base de datos
- `DB_PASSWORD` - Contraseña de la base de datos
- `DB_DATABASE` - Nombre de la base de datos
- `DB_ENCRYPT` - `true` para Azure SQL, `false` para local
- `JWT_SECRET` - Clave secreta para JWT (debe ser segura y única)
- `JWT_EXPIRES_IN` - Tiempo de expiración del token (ej: `7d`)
- `NODE_ENV` - Debe ser `production` en producción
- `TZ` - Zona horaria (ej: `America/Bogota`)

### Despliegue en Otros Servicios

Este proyecto también puede desplegarse en:
- **Railway** - Similar a Vercel, con soporte para contenedores
- **Heroku** - Requiere configuración de buildpacks
- **AWS** - Usando Elastic Beanstalk o EC2
- **DigitalOcean** - Usando App Platform o Droplets

Cada servicio tiene sus propias instrucciones específicas.

## 📝 Scripts SQL

En la carpeta `Database/` encontrarás varios scripts SQL:

- `database_schema.sql` - Esquema completo de la base de datos
- `fix_timezone.sql` - Ajustes de zona horaria
- Scripts de inserción de datos iniciales para cursos, lecciones, etc.

## 🔒 Seguridad

- Las contraseñas se hashean con bcrypt antes de almacenarse
- Los tokens JWT tienen fecha de expiración
- Validación de entrada con class-validator
- CORS configurado para desarrollo (ajustar en producción)

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es privado y está bajo licencia UNLICENSED.

## 👥 Autor

[Tu nombre/equipo]

## 📞 Soporte

Para soporte, envía un email a [tu-email] o abre un issue en el repositorio.

---

**Nota importante**: Recuerda cambiar todas las claves secretas y configuraciones por defecto antes de desplegar en producción.

## ✅ Verificación Post-Despliegue

Después de desplegar en Vercel, verifica:

1. **Conexión a la base de datos**:
   - Los logs no deben mostrar errores de conexión
   - Las peticiones a endpoints que requieren BD deben funcionar

2. **Documentación**:
   - Visita `https://tu-proyecto.vercel.app/docs`
   - Debe cargar Scalar correctamente
   - Los endpoints deben estar documentados

3. **Autenticación**:
   - Prueba crear un usuario en `/auth/register`
   - Prueba iniciar sesión en `/auth/login`
   - Verifica que obtengas un token JWT

4. **Logs de Vercel**:
   ```bash
   vercel logs
   ```
   O desde el Dashboard: Deployments → Ver logs

## 🔧 Solución de Problemas

### Error 500: FUNCTION_INVOCATION_FAILED en Vercel
**Síntomas**: La función serverless falla con error 500.

**Soluciones**:
1. **Verifica las variables de entorno en Vercel**:
   - Ve a tu proyecto en Vercel Dashboard → Settings → Environment Variables
   - Asegúrate de que todas las variables estén configuradas:
     - `DB_HOST`
     - `DB_PORT`
     - `DB_USERNAME`
     - `DB_PASSWORD`
     - `DB_DATABASE`
     - `DB_ENCRYPT`
     - `JWT_SECRET`
     - `JWT_EXPIRES_IN`
     - `NODE_ENV=production`

2. **Revisa los logs de Vercel**:
   ```bash
   vercel logs
   ```
   O desde el Dashboard: Deployments → Selecciona el deployment → Functions → Ver logs
   - Busca errores específicos en los logs
   - Verifica mensajes de error relacionados con la base de datos

3. **Verifica la conectividad de la base de datos**:
   - Asegúrate de que tu base de datos SQL Server esté accesible desde internet
   - Para Azure SQL Database:
     - Ve a Azure Portal → SQL Server → Firewall settings
     - Asegúrate de que "Allow Azure services and resources to access this server" esté habilitado
     - O configura las IPs de Vercel (esto cambia dinámicamente)

4. **Verifica las credenciales de la base de datos**:
   - Confirma que el usuario y contraseña sean correctos
   - Verifica que la base de datos especificada exista
   - Asegúrate de que `DB_ENCRYPT=true` esté configurado para Azure SQL

5. **Timeouts de conexión**:
   - Si tu base de datos tarda mucho en responder, aumenta los timeouts en `database.module.ts`
   - Verifica que la base de datos esté activa y funcionando

### Error: Cannot find module '@nestjs/core'
**Solución**: Asegúrate de que `node_modules` esté instalado. Vercel lo instala automáticamente durante el build.

### Error: Connection timeout con SQL Server
**Solución**: 
- Verifica que el firewall de Azure SQL permita conexiones desde Azure services
- Confirma que `DB_ENCRYPT=true` está configurado
- Verifica las credenciales de la base de datos
- Aumenta los valores de `connectionTimeout` y `requestTimeout` en `database.module.ts`

### Error: JWT secret no configurado
**Solución**: Configura `JWT_SECRET` en las variables de entorno de Vercel con un valor seguro y único.

### Error: pnpm-lock.yaml desactualizado
**Solución**: 
- Ejecuta `pnpm install` localmente para regenerar el lockfile
- Haz commit y push del `pnpm-lock.yaml` actualizado

### Documentación no carga en Vercel
**Solución**: Verifica que la URL en Swagger use `VERCEL_URL` correctamente. El archivo `api/index.ts` ya está configurado para esto.

### La aplicación funciona localmente pero falla en Vercel
**Posibles causas**:
1. Variables de entorno no configuradas en Vercel
2. Base de datos no accesible desde Vercel
3. Problemas con rutas de archivos (usar rutas relativas)
4. Timeouts en funciones serverless (máximo 30 segundos en plan Hobby)

## 📝 Notas Adicionales

- **Cold Starts**: Las funciones serverless pueden tener un "cold start" en la primera petición. Esto es normal.
- **Timeouts**: Vercel tiene un timeout máximo de 30 segundos en el plan Hobby. Para tiempos más largos, considera el plan Pro.
- **Base de Datos**: Considera usar un pool de conexiones para mejorar el rendimiento con funciones serverless.

## 🔗 Enlaces Útiles

- [Documentación de NestJS](https://docs.nestjs.com)
- [Documentación de Vercel](https://vercel.com/docs)
- [Azure SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/)
- [TypeORM con SQL Server](https://typeorm.io/#/sql-server)
