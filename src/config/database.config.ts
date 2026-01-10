import { registerAs } from '@nestjs/config';

export default registerAs('database', () => ({
  type: 'mssql',
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 1433,
  username: process.env.DB_USERNAME || 'sa',
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE || 'LenguajeCsharp',
  synchronize: false, // Deshabilitado - usar migraciones o scripts SQL manuales
  logging: process.env.NODE_ENV === 'development',
  options: {
    encrypt: process.env.DB_ENCRYPT === 'true', // false para SQL Server local, true para Azure SQL
    trustServerCertificate: true, // true para desarrollo local
    enableArithAbort: true,
  },
  entities: [__dirname + '/../**/*.entity{.ts,.js}'],
  migrations: [__dirname + '/../migrations/**/*{.ts,.js}'],
  migrationsRun: false,
}));

