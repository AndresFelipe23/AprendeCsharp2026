// ecosystem.config.js - Configuración PM2 para Lenguaje C# Backend (NestJS)
// Este archivo configura PM2 para ejecutar la aplicación NestJS en producción

module.exports = {
  apps: [
    {
      name: 'lenguaje-csharp-api',
      script: 'dist/main.js', // Archivo compilado
      cwd: '/cloudclusters/AprendeCsharp2026', // Ruta del servidor
      instances: 2, // Usar 2 instancias para balanceo de carga (o 'max' para usar todos los CPUs)
      exec_mode: 'cluster', // Modo cluster para aprovechar múltiples CPUs
      env: {
        NODE_ENV: 'development',
        PORT: 3000,
        TZ: 'America/Bogota',
        // Variables de base de datos - ajusta según tu configuración
        DB_HOST: 'localhost',
        DB_PORT: '1433',
        DB_USERNAME: 'sa',
        DB_PASSWORD: '', // Se recomienda usar archivo .env en lugar de aquí
        DB_DATABASE: 'LenguajeCsharp',
        DB_ENCRYPT: 'false',
        // Variables JWT
        JWT_SECRET: '', // Se recomienda usar archivo .env
        JWT_EXPIRES_IN: '7d',
      },
      env_production: {
        NODE_ENV: 'production',
        PORT: 3000,
        TZ: 'America/Bogota',
        // En producción, estas variables deben venir del archivo .env
        // No las definas aquí por seguridad
      },
      // Archivos de logs
      error_file: '/cloudclusters/AprendeCsharp2026/logs/pm2-error.log',
      out_file: '/cloudclusters/AprendeCsharp2026/logs/pm2-out.log',
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
      merge_logs: true,
      // Configuración de reinicio automático
      autorestart: true,
      watch: false, // Deshabilitar watch en producción
      max_memory_restart: '1G', // Reiniciar si usa más de 1GB de RAM
      // Configuración de tiempo de espera
      kill_timeout: 5000,
      wait_ready: true,
      listen_timeout: 10000,
      // Configuración de expiración de logs (opcional)
      exp_backoff_restart_delay: 100,
      // Variables de entorno adicionales
      instance_var: 'INSTANCE_ID',
    },
  ],

  // Configuración de deployment (opcional - para despliegue automático)
  deploy: {
    production: {
      user: 'root',
      host: 'aprendecsharp.site', // Tu dominio
      ref: 'origin/main',
      repo: 'git@github.com:tu-usuario/lenguaje-backend.git', // Ajusta tu repositorio
      path: '/cloudclusters/AprendeCsharp2026',
      'pre-deploy-local': '',
      'post-deploy': 'npm install && npm run build && pm2 reload ecosystem.config.js --env production',
      'pre-setup': 'mkdir -p logs',
      'ssh_options': 'StrictHostKeyChecking=no',
    },
  },
};
