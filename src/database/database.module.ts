import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import databaseConfig from '../config/database.config';
import jwtConfig from '../config/jwt.config';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [databaseConfig, jwtConfig],
      isGlobal: true,
      envFilePath: '.env',
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => {
        const host = configService.get<string>('database.host') || 'localhost';
        const port = configService.get<number>('database.port') || 1433;
        const username = configService.get<string>('database.username') || 'sa';
        const password = configService.get<string>('database.password');
        const database = configService.get<string>('database.database') || 'LenguajeCsharp';
        
        // Determinar si synchronize debe estar activo
        // IMPORTANTE: synchronize está deshabilitado para evitar conflictos con constraints
        const synchronize = configService.get<boolean>('database.synchronize') ?? false;
        const nodeEnv = process.env.NODE_ENV || 'development';
        const logging = configService.get<boolean>('database.logging') ?? (nodeEnv === 'development');
        
        console.log('📊 Configuración de Base de Datos:');
        console.log(`   Synchronize: ${synchronize}`);
        console.log(`   Logging: ${logging}`);
        console.log(`   NODE_ENV: ${nodeEnv}`);
        
        return {
          type: 'mssql',
          host,
          port,
          username,
          password,
          database,
          synchronize,
          logging,
          options: {
            encrypt: configService.get<boolean>('database.options.encrypt') ?? false,
            trustServerCertificate: configService.get<boolean>('database.options.trustServerCertificate') ?? true,
            enableArithAbort: configService.get<boolean>('database.options.enableArithAbort') ?? true,
          },
          entities: [__dirname + '/../**/*.entity{.ts,.js}'],
          migrations: [__dirname + '/../migrations/**/*{.ts,.js}'],
          migrationsRun: false,
          autoLoadEntities: true,
          connectionTimeout: 30000,
          requestTimeout: 30000,
        };
      },
      inject: [ConfigService],
    }),
  ],
})
export class DatabaseModule {}

