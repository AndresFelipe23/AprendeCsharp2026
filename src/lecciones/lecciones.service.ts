import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Leccion } from '../entities/leccion.entity';
import { Curso } from '../entities/curso.entity';
import { CreateLeccionDto } from './dto/create-leccion.dto';
import { UpdateLeccionDto } from './dto/update-leccion.dto';

@Injectable()
export class LeccionesService {
  constructor(
    @InjectRepository(Leccion)
    private leccionRepository: Repository<Leccion>,
    @InjectRepository(Curso)
    private cursoRepository: Repository<Curso>,
  ) {}

  async findAllByCurso(cursoId: number, includeInactive = false): Promise<Leccion[]> {
    const where: any = { CursoId: cursoId };
    if (!includeInactive) {
      where.Activo = true;
    }

    return this.leccionRepository.find({
      where,
      order: { Orden: 'ASC' },
      relations: ['Curso'],
    });
  }

  async findOne(id: number): Promise<Leccion> {
    const leccion = await this.leccionRepository.findOne({
      where: { LeccionId: id },
      relations: ['Curso'],
    });

    if (!leccion) {
      throw new NotFoundException(`Lección con ID ${id} no encontrada`);
    }

    return leccion;
  }

  async create(createLeccionDto: CreateLeccionDto): Promise<Leccion> {
    // Verificar que el curso existe
    const curso = await this.cursoRepository.findOne({
      where: { CursoId: createLeccionDto.cursoId },
    });

    if (!curso) {
      throw new NotFoundException(
        `Curso con ID ${createLeccionDto.cursoId} no encontrado`,
      );
    }

    // Verificar si ya existe una lección con el mismo orden en el mismo curso
    const existingLeccion = await this.leccionRepository.findOne({
      where: {
        CursoId: createLeccionDto.cursoId,
        Orden: createLeccionDto.orden,
      },
    });

    if (existingLeccion) {
      throw new ConflictException(
        `Ya existe una lección con el orden ${createLeccionDto.orden} en este curso`,
      );
    }

    const nuevaLeccion = this.leccionRepository.create({
      CursoId: createLeccionDto.cursoId,
      Titulo: createLeccionDto.titulo,
      DescripcionCorta: createLeccionDto.descripcionCorta,
      ContenidoBreve: createLeccionDto.contenidoBreve,
      CodigoEjemplo: createLeccionDto.codigoEjemplo,
      Orden: createLeccionDto.orden,
      Activo: true,
    });

    return this.leccionRepository.save(nuevaLeccion);
  }

  async update(id: number, updateLeccionDto: UpdateLeccionDto): Promise<Leccion> {
    const leccion = await this.findOne(id);

    // Si se está actualizando el orden, verificar que no exista otra lección con ese orden en el mismo curso
    if (updateLeccionDto.orden && updateLeccionDto.orden !== leccion.Orden) {
      const existingLeccion = await this.leccionRepository.findOne({
        where: {
          CursoId: leccion.CursoId,
          Orden: updateLeccionDto.orden,
        },
      });

      if (existingLeccion && existingLeccion.LeccionId !== id) {
        throw new ConflictException(
          `Ya existe una lección con el orden ${updateLeccionDto.orden} en este curso`,
        );
      }
    }

    // Actualizar campos
    if (updateLeccionDto.titulo !== undefined) {
      leccion.Titulo = updateLeccionDto.titulo;
    }
    if (updateLeccionDto.descripcionCorta !== undefined) {
      leccion.DescripcionCorta = updateLeccionDto.descripcionCorta;
    }
    if (updateLeccionDto.contenidoBreve !== undefined) {
      leccion.ContenidoBreve = updateLeccionDto.contenidoBreve;
    }
    if (updateLeccionDto.codigoEjemplo !== undefined) {
      leccion.CodigoEjemplo = updateLeccionDto.codigoEjemplo;
    }
    if (updateLeccionDto.orden !== undefined) {
      leccion.Orden = updateLeccionDto.orden;
    }
    if (updateLeccionDto.activo !== undefined) {
      leccion.Activo = updateLeccionDto.activo;
    }

    return this.leccionRepository.save(leccion);
  }

  async remove(id: number): Promise<void> {
    const leccion = await this.findOne(id);
    
    // Soft delete: marcar como inactivo
    leccion.Activo = false;
    await this.leccionRepository.save(leccion);
  }

  async delete(id: number): Promise<void> {
    const leccion = await this.findOne(id);
    await this.leccionRepository.remove(leccion);
  }
}

