import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Curso } from '../entities/curso.entity';
import { Ruta } from '../entities/ruta.entity';
import { CreateCursoDto } from './dto/create-curso.dto';
import { UpdateCursoDto } from './dto/update-curso.dto';

@Injectable()
export class CursosService {
  constructor(
    @InjectRepository(Curso)
    private cursoRepository: Repository<Curso>,
    @InjectRepository(Ruta)
    private rutaRepository: Repository<Ruta>,
  ) {}

  async findAllByRuta(rutaId: number, includeInactive = false): Promise<Curso[]> {
    const where: any = { RutaId: rutaId };
    if (!includeInactive) {
      where.Activo = true;
    }

    return this.cursoRepository.find({
      where,
      order: { Orden: 'ASC' },
      relations: ['Lecciones'],
    });
  }

  async findOne(id: number): Promise<Curso> {
    const curso = await this.cursoRepository.findOne({
      where: { CursoId: id },
      relations: ['Lecciones', 'Ruta'],
    });

    if (!curso) {
      throw new NotFoundException(`Curso con ID ${id} no encontrado`);
    }

    return curso;
  }

  async create(createCursoDto: CreateCursoDto): Promise<Curso> {
    // Verificar que la ruta existe
    const ruta = await this.rutaRepository.findOne({
      where: { RutaId: createCursoDto.rutaId },
    });

    if (!ruta) {
      throw new NotFoundException(
        `Ruta con ID ${createCursoDto.rutaId} no encontrada`,
      );
    }

    // Verificar si ya existe un curso con el mismo orden en la misma ruta
    const existingCurso = await this.cursoRepository.findOne({
      where: {
        RutaId: createCursoDto.rutaId,
        Orden: createCursoDto.orden,
      },
    });

    if (existingCurso) {
      throw new ConflictException(
        `Ya existe un curso con el orden ${createCursoDto.orden} en esta ruta`,
      );
    }

    const nuevoCurso = this.cursoRepository.create({
      RutaId: createCursoDto.rutaId,
      Nombre: createCursoDto.nombre,
      DescripcionCorta: createCursoDto.descripcionCorta,
      Orden: createCursoDto.orden,
      Activo: true,
    });

    return this.cursoRepository.save(nuevoCurso);
  }

  async update(id: number, updateCursoDto: UpdateCursoDto): Promise<Curso> {
    const curso = await this.findOne(id);

    // Si se está actualizando el orden, verificar que no exista otro curso con ese orden en la misma ruta
    if (updateCursoDto.orden && updateCursoDto.orden !== curso.Orden) {
      const existingCurso = await this.cursoRepository.findOne({
        where: {
          RutaId: curso.RutaId,
          Orden: updateCursoDto.orden,
        },
      });

      if (existingCurso && existingCurso.CursoId !== id) {
        throw new ConflictException(
          `Ya existe un curso con el orden ${updateCursoDto.orden} en esta ruta`,
        );
      }
    }

    // Actualizar campos
    if (updateCursoDto.nombre !== undefined) {
      curso.Nombre = updateCursoDto.nombre;
    }
    if (updateCursoDto.descripcionCorta !== undefined) {
      curso.DescripcionCorta = updateCursoDto.descripcionCorta;
    }
    if (updateCursoDto.orden !== undefined) {
      curso.Orden = updateCursoDto.orden;
    }
    if (updateCursoDto.activo !== undefined) {
      curso.Activo = updateCursoDto.activo;
    }

    return this.cursoRepository.save(curso);
  }

  async remove(id: number): Promise<void> {
    const curso = await this.findOne(id);
    
    // Soft delete: marcar como inactivo
    curso.Activo = false;
    await this.cursoRepository.save(curso);
  }

  async delete(id: number): Promise<void> {
    const curso = await this.findOne(id);
    await this.cursoRepository.remove(curso);
  }
}

