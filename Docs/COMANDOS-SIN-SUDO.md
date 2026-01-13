# Guía Rápida: Comandos sin sudo

Esta guía muestra los comandos comunes sin usar `sudo`, útil cuando trabajas como usuario root o con permisos suficientes.

## Verificar tu usuario actual

```bash
whoami
# Si muestra "root", puedes omitir sudo de todos los comandos
```

## Comandos de Nginx (sin sudo)

```bash
# Ver configuración
cat /etc/nginx/sites-available/aprendecsharp.site

# Editar configuración con vi
vi /etc/nginx/sites-available/aprendecsharp.site

# Verificar configuración
nginx -t

# Recargar Nginx
systemctl reload nginx
# O alternativamente:
service nginx reload

# Ver estado de Nginx
systemctl status nginx
service nginx status

# Ver logs
tail -f /var/log/nginx/aprendecsharp-access.log
tail -f /var/log/nginx/aprendecsharp-error.log

# Ver últimas líneas de logs
cat /var/log/nginx/aprendecsharp-error.log | tail -20
```

## Comandos de sistema (sin sudo)

```bash
# Actualizar sistema
apt-get update
apt-get upgrade

# Instalar paquetes
apt-get install certbot python3-certbot-nginx

# Firewall (UFW)
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable
```

## Comandos de archivos

```bash
# Ver contenido de archivo
cat archivo.txt

# Ver últimas líneas
tail -20 archivo.txt

# Ver primeras líneas
head -20 archivo.txt

# Editar con vi
vi archivo.txt

# Crear archivo con cat
cat > archivo.txt << 'EOF'
contenido aquí
EOF

# Copiar archivo
cp origen.txt destino.txt

# Crear enlace simbólico
ln -s /ruta/origen /ruta/destino
```

## Comandos útiles de vi

```bash
# Abrir archivo
vi archivo.txt

# Comandos dentro de vi:
# - Presiona 'i' para entrar en modo inserción
# - Presiona 'Esc' para salir del modo inserción
# - Escribe ':w' para guardar
# - Escribe ':q' para salir
# - Escribe ':wq' para guardar y salir
# - Escribe ':q!' para salir sin guardar cambios
# - Escribe '/texto' para buscar texto
# - Presiona 'n' para siguiente resultado de búsqueda
```

## Ver configuraciones de Nginx de otras apps

```bash
# Ver todas las configuraciones disponibles
ls -la /etc/nginx/sites-available/

# Ver configuración de otra app (ejemplo: afesdev)
cat /etc/nginx/sites-available/afesdev.site

# Ver todas las configuraciones habilitadas
for file in /etc/nginx/sites-enabled/*; do 
  echo "=== $file ==="
  cat "$file"
  echo ""
done

# Usar el script de ayuda
chmod +x ver-nginx-config.sh
./ver-nginx-config.sh
```

## Comandos de PM2 (no requieren sudo)

```bash
# Ver estado
pm2 status

# Ver logs
pm2 logs lenguaje-csharp-api

# Reiniciar
pm2 restart lenguaje-csharp-api

# Recargar
pm2 reload lenguaje-csharp-api

# Detener
pm2 stop lenguaje-csharp-api

# Monitoreo
pm2 monit
```

## Notas

- Si `whoami` muestra "root", puedes omitir `sudo` de todos los comandos
- Si necesitas usar `sudo` pero no está disponible, verifica que tengas los permisos necesarios
- Algunos sistemas pueden requerir usar `su` en lugar de `sudo` para cambiar a root
