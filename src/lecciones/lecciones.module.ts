import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LeccionesService } from './lecciones.service';
import { LeccionesController } from './lecciones.controller';
import { Leccion } from '../entities/leccion.entity';
import { Curso } from '../entities/curso.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Leccion, Curso])],
  controllers: [LeccionesController],
  providers: [LeccionesService],
  exports: [LeccionesService],
})
export class LeccionesModule {}

