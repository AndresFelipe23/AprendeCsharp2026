import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PracticasService } from './practicas.service';
import { PracticasController } from './practicas.controller';
import { Practica } from '../entities/practica.entity';
import { PracticaOpcion } from '../entities/practica-opcion.entity';
import { PracticaBloque } from '../entities/practica-bloque.entity';
import { PracticaCodigo } from '../entities/practica-codigo.entity';
import { Leccion } from '../entities/leccion.entity';
import { ProgresoPractica } from '../entities/progreso-practica.entity';
import { Usuario } from '../entities/usuario.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Practica,
      PracticaOpcion,
      PracticaBloque,
      PracticaCodigo,
      Leccion,
      ProgresoPractica,
      Usuario,
    ]),
  ],
  controllers: [PracticasController],
  providers: [PracticasService],
  exports: [PracticasService],
})
export class PracticasModule {}

