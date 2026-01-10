import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProgresoService } from './progreso.service';
import { ProgresoController } from './progreso.controller';
import { ProgresoLeccion } from '../entities/progreso-leccion.entity';
import { ProgresoPractica } from '../entities/progreso-practica.entity';
import { Leccion } from '../entities/leccion.entity';
import { Usuario } from '../entities/usuario.entity';
import { Ruta } from '../entities/ruta.entity';
import { Curso } from '../entities/curso.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      ProgresoLeccion,
      ProgresoPractica,
      Leccion,
      Usuario,
      Ruta,
      Curso,
    ]),
  ],
  controllers: [ProgresoController],
  providers: [ProgresoService],
  exports: [ProgresoService],
})
export class ProgresoModule {}

