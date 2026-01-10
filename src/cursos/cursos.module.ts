import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CursosService } from './cursos.service';
import { CursosController } from './cursos.controller';
import { Curso } from '../entities/curso.entity';
import { Ruta } from '../entities/ruta.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Curso, Ruta])],
  controllers: [CursosController],
  providers: [CursosService],
  exports: [CursosService],
})
export class CursosModule {}

