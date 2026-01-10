# Solución de Problemas de Conexión a Base de Datos

## Error: Failed to connect to localhost:13026

Este error indica que la aplicación está intentando conectarse a un puerto incorrecto. El puerto `13026` es un puerto dinámico de SQL Server que puede aparecer cuando hay problemas de configuración.

## Solución

### 1. Crear archivo `.env`

Crea un archivo `.env` en la raíz del proyecto `lenguaje_backend` con el siguiente contenido:

```env
# Configuración de Base de Datos SQL Server
DB_HOST=localhost
DB_PORT=1433
DB_USERNAME=sa
DB_PASSWORD=tu_password_aqui
DB_DATABASE=LenguajeCsharp
DB_ENCRYPT=false

# Configuración JWT
JWT_SECRET=tu-secret-key-super-seguro-cambiar-en-produccion
JWT_EXPIRES_IN=7d

# Configuración de la aplicación
PORT=3000
NODE_ENV=development
```

**⚠️ IMPORTANTE:** Reemplaza `tu_password_aqui` con la contraseña real de tu SQL Server.

### 2. Verificar que SQL Server esté corriendo

Asegúrate de que SQL Server esté ejecutándose:

- **Windows:** Abre "Servicios" y verifica que "SQL Server (MSSQLSERVER)" o tu instancia esté "En ejecución"
- **SQL Server Management Studio:** Intenta conectarte manualmente con las mismas credenciales

### 3. Verificar el puerto de SQL Server

El puerto por defecto de SQL Server es `1433`. Si tu SQL Server usa un puerto diferente:

1. Abre **SQL Server Configuration Manager**
2. Ve a **SQL Server Network Configuration** > **Protocols for [tu instancia]**
3. Haz clic derecho en **TCP/IP** > **Properties**
4. Ve a la pestaña **IP Addresses**
5. Busca **IPAll** y verifica el puerto en **TCP Dynamic Ports** o **TCP Port**

### 4. Verificar la autenticación

Asegúrate de que la autenticación SQL esté habilitada:

1. Abre **SQL Server Management Studio**
2. Conecta al servidor
3. Click derecho en el servidor > **Properties** > **Security**
4. Asegúrate de que **SQL Server and Windows Authentication mode** esté seleccionado

### 5. Verificar firewall

Asegúrate de que el puerto de SQL Server no esté bloqueado por el firewall:

```powershell
# Verificar reglas de firewall
Get-NetFirewallRule | Where-Object {$_.DisplayName -like "*SQL*"}
```

### 6. Si usas una instancia nombrada

Si tu SQL Server tiene una instancia nombrada (por ejemplo: `localhost\SQLEXPRESS`), puedes:

**Opción A:** Usar el nombre de la instancia en lugar del puerto:
```env
DB_HOST=localhost\\SQLEXPRESS
DB_PORT=1433
```

**Opción B:** Especificar el puerto específico de la instancia (puede ser diferente a 1433)

### 7. Si usas SQL Server Express

Para SQL Server Express, el puerto puede ser dinámico. Verifica el puerto en:

1. **SQL Server Configuration Manager**
2. O usa la conexión con nombre de instancia:
   ```env
   DB_HOST=localhost\\SQLEXPRESS
   ```

### 8. Probar la conexión manualmente

Puedes probar la conexión usando `sqlcmd`:

```bash
sqlcmd -S localhost,1433 -U sa -P tu_password
```

O usando Node.js:

```javascript
const sql = require('mssql');

const config = {
  server: 'localhost',
  port: 1433,
  user: 'sa',
  password: 'tu_password',
  database: 'LenguajeCsharp',
  options: {
    encrypt: false,
    trustServerCertificate: true,
  }
};

sql.connect(config).then(() => {
  console.log('Conexión exitosa!');
}).catch(err => {
  console.error('Error de conexión:', err);
});
```

## Configuración para Azure SQL Database

Si estás usando Azure SQL Database:

```env
DB_HOST=tu-servidor.database.windows.net
DB_PORT=1433
DB_USERNAME=tu_usuario@tu_servidor
DB_PASSWORD=tu_password
DB_DATABASE=LenguajeCsharp
DB_ENCRYPT=true
```

## Logs de Depuración

Si el problema persiste, la aplicación mostrará logs de depuración. Verifica:

1. Que el host sea correcto
2. Que el puerto sea correcto
3. Que las credenciales sean correctas
4. Que la base de datos exista

## Comandos Útiles

```bash
# Verificar que SQL Server está corriendo (Windows)
Get-Service | Where-Object {$_.Name -like "*SQL*"}

# Verificar puertos abiertos
netstat -an | findstr 1433

# Probar conexión con telnet
telnet localhost 1433
```

