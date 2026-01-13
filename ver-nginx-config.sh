#!/bin/bash
# Script para ver la configuración de Nginx de otras aplicaciones
# Útil para comparar y entender cómo están configuradas otras apps

echo "=== Verificando usuario actual ==="
whoami
echo ""

echo "=== Configuraciones de Nginx disponibles ==="
echo ""
ls -la /etc/nginx/sites-available/
echo ""

echo "=== Configuraciones habilitadas ==="
echo ""
ls -la /etc/nginx/sites-enabled/
echo ""

echo "=== Mostrando todas las configuraciones habilitadas ==="
echo ""
for file in /etc/nginx/sites-enabled/*; do 
  echo "=========================================="
  echo "Archivo: $file"
  echo "=========================================="
  cat "$file"
  echo ""
done

echo ""
echo "=== Comandos útiles ==="
echo ""
echo "Para ver una configuración específica:"
echo "  cat /etc/nginx/sites-available/nombre-del-sitio"
echo ""
echo "Para ver la configuración de aprendecsharp.site:"
echo "  cat /etc/nginx/sites-available/aprendecsharp.site"
echo ""
echo "Para editar una configuración con vi:"
echo "  vi /etc/nginx/sites-available/aprendecsharp.site"
echo ""
echo "Para verificar la configuración de Nginx:"
echo "  nginx -t"
echo ""
echo "Para recargar Nginx:"
echo "  systemctl reload nginx"
echo "  # O alternativamente:"
echo "  service nginx reload"
