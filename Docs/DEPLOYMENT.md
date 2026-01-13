# Guía de Deployment - Lenguaje C# Backend

Esta guía explica cómo desplegar la aplicación backend NestJS en un servidor personal usando PM2 y Nginx.

## Requisitos Previos

- Node.js 18+ instalado
- PM2 instalado globalmente: `npm install -g pm2`
- Nginx instalado y configurado
- Certificado SSL (recomendado usar Let's Encrypt con Certbot)
- Acceso SSH al servidor
- Base de datos SQL Server configurada y accesible

**Nota sobre permisos:** Si trabajas como usuario root o tienes permisos suficientes, puedes omitir `sudo` de los comandos. Verifica con `whoami` si eres root.

## Paso 1: Preparar el Servidor

### 1.1 Instalar PM2 (si no está instalado)

```bash
npm install -g pm2
```

### 1.2 Crear estructura de directorios

```bash
mkdir -p /cloudclusters/lenguaje_backend/logs
cd /cloudclusters/lenguaje_backend
```

### 1.3 Clonar o subir el código

```bash
git clone <tu-repositorio> .
# O sube los archivos manualmente
```

## Paso 2: Configurar Variables de Entorno

### 2.1 Crear archivo .env

Crea un archivo `.env` en `/cloudclusters/lenguaje_backend/` con el siguiente contenido:

**Opción 1: Usando `vi` (editor de texto en terminal)**
```bash
cd /cloudclusters/lenguaje_backend
vi .env
```

Presiona `i` para entrar en modo inserción, pega el contenido, luego presiona `Esc` y escribe `:wq` para guardar y salir.

**Opción 2: Usando `cat` con redirección**
```bash
cat > /cloudclusters/lenguaje_backend/.env << 'EOF'
# Configuración de Base de Datos SQL Server
DB_HOST=localhost
DB_PORT=1433
DB_USERNAME=sa
DB_PASSWORD=tu_password_seguro_aqui
DB_DATABASE=LenguajeCsharp
DB_ENCRYPT=false

# Configuración JWT
JWT_SECRET=tu-secret-key-super-seguro-cambiar-en-produccion-minimo-32-caracteres
JWT_EXPIRES_IN=7d

# Configuración de la aplicación
PORT=3000
NODE_ENV=production
TZ=America/Bogota
EOF
```

**Opción 3: Ver contenido existente con `cat`**
```bash
cat /cloudclusters/lenguaje_backend/.env
```

**⚠️ IMPORTANTE:** 
- Nunca subas el archivo `.env` al repositorio (debe estar en `.gitignore`)
- Usa un `JWT_SECRET` fuerte y único en producción
- Ajusta las credenciales de base de datos según tu configuración

## Paso 3: Instalar Dependencias y Compilar

```bash
cd /cloudclusters/lenguaje_backend
npm install
npm run build
```

Esto generará la carpeta `dist/` con el código compilado.

## Paso 4: Configurar PM2

### 4.1 Ajustar ecosystem.config.js

Edita el archivo `ecosystem.config.js` y ajusta las rutas según tu servidor:

```javascript
cwd: '/cloudclusters/lenguaje_backend', // Ajusta esta ruta
```

### 4.2 Iniciar la aplicación con PM2

```bash
pm2 start ecosystem.config.js --env production
```

### 4.3 Verificar que está corriendo

```bash
pm2 status
pm2 logs lenguaje-csharp-api
```

### 4.4 Configurar PM2 para iniciar al arrancar el servidor

```bash
pm2 startup
pm2 save
```

## Paso 5: Configurar Nginx

### 5.1 Copiar configuración de Nginx

**Si eres root o tienes permisos:**
```bash
cp nginx-aprendecsharp.conf /etc/nginx/sites-available/aprendecsharp.site
```

**Si necesitas sudo:**
```bash
sudo cp nginx-aprendecsharp.conf /etc/nginx/sites-available/aprendecsharp.site
```

**Alternativa: Usar `cat` y `vi` directamente**
```bash
# Ver la configuración primero
cat nginx-aprendecsharp.conf

# Copiar manualmente con vi
vi /etc/nginx/sites-available/aprendecsharp.site
# Presiona 'i' para insertar, pega el contenido, luego Esc y :wq para guardar
```

### 5.2 Habilitar el sitio

**Si eres root:**
```bash
ln -s /etc/nginx/sites-available/aprendecsharp.site /etc/nginx/sites-enabled/
```

**Si necesitas sudo:**
```bash
sudo ln -s /etc/nginx/sites-available/aprendecsharp.site /etc/nginx/sites-enabled/
```

### 5.3 Verificar configuración de Nginx

**Si eres root:**
```bash
nginx -t
```

**Si necesitas sudo:**
```bash
sudo nginx -t
```

### 5.4 Recargar Nginx

**Si eres root:**
```bash
systemctl reload nginx
# O alternativamente:
service nginx reload
```

**Si necesitas sudo:**
```bash
sudo systemctl reload nginx
```

**Verificar estado de Nginx:**
```bash
systemctl status nginx
# O
service nginx status
```

## Paso 6: Configurar SSL con Let's Encrypt (Recomendado)

### 6.1 Instalar Certbot

**Si eres root:**
```bash
apt-get update
apt-get install certbot python3-certbot-nginx
```

**Si necesitas sudo:**
```bash
sudo apt-get update
sudo apt-get install certbot python3-certbot-nginx
```

### 6.2 Obtener certificado SSL

**Si eres root:**
```bash
certbot --nginx -d aprendecsharp.site -d www.aprendecsharp.site
```

**Si necesitas sudo:**
```bash
sudo certbot --nginx -d aprendecsharp.site -d www.aprendecsharp.site
```

Certbot modificará automáticamente la configuración de Nginx para usar HTTPS.

### 6.3 Renovación automática

Certbot configura la renovación automática, pero puedes verificar:

**Si eres root:**
```bash
certbot renew --dry-run
```

**Si necesitas sudo:**
```bash
sudo certbot renew --dry-run
```

## Paso 7: Verificar el Deployment

### 7.1 Verificar que la API responde

```bash
curl http://localhost:3000
# O desde el navegador: https://aprendecsharp.site
```

### 7.2 Verificar logs

```bash
# Logs de PM2
pm2 logs lenguaje-csharp-api

# Logs de Nginx (si eres root)
tail -f /var/log/nginx/aprendecsharp-access.log
tail -f /var/log/nginx/aprendecsharp-error.log

# Logs de Nginx (si necesitas sudo)
sudo tail -f /var/log/nginx/aprendecsharp-access.log
sudo tail -f /var/log/nginx/aprendecsharp-error.log

# Ver últimas líneas con cat
cat /var/log/nginx/aprendecsharp-error.log | tail -20
```

## Comandos Útiles de PM2

```bash
# Ver estado de las aplicaciones
pm2 status

# Ver logs en tiempo real
pm2 logs lenguaje-csharp-api

# Reiniciar la aplicación
pm2 restart lenguaje-csharp-api

# Detener la aplicación
pm2 stop lenguaje-csharp-api

# Eliminar la aplicación de PM2
pm2 delete lenguaje-csharp-api

# Recargar sin downtime (zero-downtime)
pm2 reload lenguaje-csharp-api

# Monitoreo
pm2 monit
```

## Actualizar la Aplicación

Cuando necesites actualizar el código:

```bash
cd /cloudclusters/lenguaje_backend
git pull  # O sube los nuevos archivos
npm install
npm run build
pm2 reload ecosystem.config.js --env production
```

## Solución de Problemas

### La aplicación no inicia

1. Verifica los logs: `pm2 logs lenguaje-csharp-api`
2. Verifica que el puerto 3000 no esté ocupado: `netstat -tulpn | grep 3000`
3. Verifica las variables de entorno en el archivo `.env`
4. Verifica la conexión a la base de datos

### Nginx devuelve 502 Bad Gateway

1. Verifica que la aplicación esté corriendo: `pm2 status`
2. Verifica que el puerto en Nginx coincida con el de la aplicación (3000)
3. Verifica los logs de Nginx: `sudo tail -f /var/log/nginx/aprendecsharp-error.log`

### Problemas de CORS

Si tienes problemas de CORS desde el frontend, verifica que en `src/main.ts` la configuración de CORS permita tu dominio:

```typescript
app.enableCors({
  origin: ['https://aprendecsharp.site', 'https://www.aprendecsharp.site'],
  credentials: true,
  // ...
});
```

## Seguridad Adicional

1. **Firewall**: Configura un firewall (UFW) para permitir solo los puertos necesarios:
   ```bash
   # Si eres root
   ufw allow 22/tcp  # SSH
   ufw allow 80/tcp  # HTTP
   ufw allow 443/tcp # HTTPS
   ufw enable
   
   # Si necesitas sudo
   sudo ufw allow 22/tcp
   sudo ufw allow 80/tcp
   sudo ufw allow 443/tcp
   sudo ufw enable
   ```

2. **Actualizar sistema**: Mantén el sistema operativo actualizado:
   ```bash
   # Si eres root
   apt-get update && apt-get upgrade
   
   # Si necesitas sudo
   sudo apt-get update && sudo apt-get upgrade
   ```

3. **Backups**: Configura backups regulares de la base de datos y el código.

## Comandos Útiles para Ver Archivos

### Ver configuración de Nginx existente

```bash
# Ver todas las configuraciones disponibles
ls -la /etc/nginx/sites-available/

# Ver una configuración específica (ejemplo: otra app)
cat /etc/nginx/sites-available/afesdev.site

# Ver todas las configuraciones habilitadas
for file in /etc/nginx/sites-enabled/*; do 
  echo "=== $file ==="
  cat $file
  echo ""
done

# Ver la configuración de aprendecsharp.site
cat /etc/nginx/sites-available/aprendecsharp.site
```

### Editar archivos con vi

```bash
# Editar ecosystem.config.js
vi /cloudclusters/lenguaje_backend/ecosystem.config.js

# Editar configuración de Nginx
vi /etc/nginx/sites-available/aprendecsharp.site

# Comandos básicos de vi:
# - Presiona 'i' para entrar en modo inserción
# - Presiona 'Esc' para salir del modo inserción
# - Escribe ':w' para guardar
# - Escribe ':q' para salir
# - Escribe ':wq' para guardar y salir
# - Escribe ':q!' para salir sin guardar
```

## Notas Importantes

- El archivo `.env` contiene información sensible y NO debe estar en el repositorio
- Ajusta los límites de memoria en `ecosystem.config.js` según los recursos de tu servidor
- Considera usar un servicio de monitoreo como PM2 Plus o New Relic para producción
- Revisa regularmente los logs para detectar problemas
- Si trabajas como root, puedes omitir `sudo` de todos los comandos
- Usa `whoami` para verificar qué usuario eres
