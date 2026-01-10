import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './database/database.module';
import { AuthModule } from './auth/auth.module';
import { RutasModule } from './rutas/rutas.module';
import { CursosModule } from './cursos/cursos.module';
import { LeccionesModule } from './lecciones/lecciones.module';
import { ProgresoModule } from './progreso/progreso.module';
import { PracticasModule } from './practicas/practicas.module';

@Module({
  imports: [
    DatabaseModule,
    AuthModule,
    RutasModule,
    CursosModule,
    LeccionesModule,
    ProgresoModule,
    PracticasModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
