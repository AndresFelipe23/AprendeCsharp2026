import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RutasService } from './rutas.service';
import { RutasController } from './rutas.controller';
import { Ruta } from '../entities/ruta.entity';
import { Leccion } from '../entities/leccion.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Ruta, Leccion])],
  controllers: [RutasController],
  providers: [RutasService],
  exports: [RutasService],
})
export class RutasModule {}

