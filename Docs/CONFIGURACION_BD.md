# Configuración de Base de Datos SQL Server

## Instalación de Dependencias

Ejecuta el siguiente comando para instalar las dependencias necesarias:

```bash
pnpm add @nestjs/typeorm typeorm mssql @nestjs/config
```

O si usas npm:

```bash
npm install @nestjs/typeorm typeorm mssql @nestjs/config
```

## Configuración del archivo .env

Crea un archivo `.env` en la raíz del proyecto `lenguaje_backend` con la siguiente configuración:

```env
# Configuración de Base de Datos SQL Server
DB_HOST=localhost
DB_PORT=1433
DB_USERNAME=sa
DB_PASSWORD=tu_password_aqui
DB_DATABASE=LenguajeCsharp

# Configuración de la aplicación
PORT=3000
NODE_ENV=development
```

**Importante:** Reemplaza `tu_password_aqui` con la contraseña de tu SQL Server.

## Configuración para SQL Server Local

Si estás usando SQL Server local (no Azure), asegúrate de que:

1. SQL Server está corriendo
2. La autenticación SQL está habilitada
3. El puerto 1433 está abierto (o usa el puerto que tengas configurado)

## Configuración para Azure SQL

Si estás usando Azure SQL Database, cambia en `.env`:

```env
DB_HOST=tu-servidor.database.windows.net
DB_PORT=1433
DB_USERNAME=tu_usuario@tu_servidor
DB_PASSWORD=tu_password
DB_DATABASE=LenguajeCsharp
```

Y en `src/config/database.config.ts`, asegúrate de que:
- `encrypt: true` (ya está configurado)
- `trustServerCertificate: false` (cambia esto para producción)

## Verificar la Conexión

Una vez configurado, inicia el servidor:

```bash
pnpm run start:dev
```

Si la conexión es exitosa, verás el mensaje de que NestJS está corriendo. Si hay errores, revisa:

1. Que SQL Server esté corriendo
2. Que las credenciales en `.env` sean correctas
3. Que la base de datos `LenguajeCsharp` exista
4. Que el puerto no esté bloqueado por firewall

## Estructura de Archivos Creados

- `src/config/database.config.ts` - Configuración de la base de datos
- `src/database/database.module.ts` - Módulo de TypeORM
- `.env` - Variables de entorno (no se sube a git)
- `.env.example` - Ejemplo de configuración

