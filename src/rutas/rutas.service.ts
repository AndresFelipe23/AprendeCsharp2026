import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Ruta } from '../entities/ruta.entity';
import { Curso } from '../entities/curso.entity';
import { Leccion } from '../entities/leccion.entity';
import { CreateRutaDto } from './dto/create-ruta.dto';
import { UpdateRutaDto } from './dto/update-ruta.dto';
import {
  CatalogoCursoDto,
  CatalogoLeccionDto,
  CatalogoRutaDto,
} from './dto/catalogo.dto';

@Injectable()
export class RutasService {
  constructor(
    @InjectRepository(Ruta)
    private rutaRepository: Repository<Ruta>,
    @InjectRepository(Leccion)
    private leccionRepository: Repository<Leccion>,
  ) {}

  async findAll(includeInactive = false): Promise<Ruta[]> {
    const where: any = {};
    if (!includeInactive) {
      where.Activo = true;
    }

    return this.rutaRepository.find({
      where,
      order: { Orden: 'ASC' },
      relations: ['Cursos'],
    });
  }

  /**
   * Catálogo para inicio: rutas → cursos → lecciones.
   * Las lecciones se cargan en una segunda consulta con columnas mínimas
   * (sin ContenidoBreve/CodigoEjemplo ni FechaCreacion) para reducir I/O y tiempo.
   */
  async findCatalogo(includeInactive = false): Promise<CatalogoRutaDto[]> {
    const where: Record<string, unknown> = {};
    if (!includeInactive) {
      where.Activo = true;
    }

    const rutas = await this.rutaRepository.find({
      where,
      relations: ['Cursos'],
      order: { Orden: 'ASC' },
    });

    for (const ruta of rutas) {
      let cursos = ruta.Cursos ?? [];
      cursos.sort((a, b) => a.Orden - b.Orden);
      if (!includeInactive) {
        cursos = cursos.filter((c) => c.Activo);
      }
      ruta.Cursos = cursos;
    }

    const cursoIds = [
      ...new Set(
        rutas.flatMap((r) => (r.Cursos ?? []).map((c) => c.CursoId)),
      ),
    ];

    const byCurso = new Map<number, Leccion[]>();
    if (cursoIds.length > 0) {
      const chunkSize = 2000;
      for (let i = 0; i < cursoIds.length; i += chunkSize) {
        const slice = cursoIds.slice(i, i + chunkSize);
        const qb = this.leccionRepository
          .createQueryBuilder('l')
          .select([
            'l.LeccionId',
            'l.CursoId',
            'l.Titulo',
            'l.DescripcionCorta',
            'l.Orden',
            'l.Activo',
          ])
          .where('l.CursoId IN (:...ids)', { ids: slice });
        if (!includeInactive) {
          qb.andWhere('l.Activo = :active', { active: true });
        }
        qb.orderBy('l.CursoId', 'ASC').addOrderBy('l.Orden', 'ASC');

        const lecciones = await qb.getMany();
        for (const leccion of lecciones) {
          const list = byCurso.get(leccion.CursoId) ?? [];
          list.push(leccion);
          byCurso.set(leccion.CursoId, list);
        }
      }
    }

    for (const ruta of rutas) {
      for (const curso of ruta.Cursos ?? []) {
        curso.Lecciones = byCurso.get(curso.CursoId) ?? [];
      }
    }

    return rutas.map((ruta) => this.mapRutaToCatalogo(ruta));
  }

  private mapRutaToCatalogo(ruta: Ruta): CatalogoRutaDto {
    const cursos = (ruta.Cursos ?? []).map((curso) =>
      this.mapCursoToCatalogo(curso),
    );
    return {
      RutaId: ruta.RutaId,
      Nombre: ruta.Nombre,
      DescripcionCorta: ruta.DescripcionCorta,
      Orden: ruta.Orden,
      Activo: ruta.Activo,
      Cursos: cursos,
    };
  }

  private mapCursoToCatalogo(curso: Curso): CatalogoCursoDto {
    const lecciones = (curso.Lecciones ?? []).map((l) =>
      this.mapLeccionToCatalogo(l),
    );
    return {
      CursoId: curso.CursoId,
      RutaId: curso.RutaId,
      Nombre: curso.Nombre,
      DescripcionCorta: curso.DescripcionCorta,
      Orden: curso.Orden,
      Activo: curso.Activo,
      Lecciones: lecciones,
    };
  }

  private mapLeccionToCatalogo(leccion: Leccion): CatalogoLeccionDto {
    return {
      LeccionId: leccion.LeccionId,
      CursoId: leccion.CursoId,
      Titulo: leccion.Titulo,
      DescripcionCorta: leccion.DescripcionCorta,
      Orden: leccion.Orden,
      Activo: leccion.Activo,
    };
  }

  async findOne(id: number): Promise<Ruta> {
    const ruta = await this.rutaRepository.findOne({
      where: { RutaId: id },
      relations: ['Cursos'],
    });

    if (!ruta) {
      throw new NotFoundException(`Ruta con ID ${id} no encontrada`);
    }

    return ruta;
  }

  async create(createRutaDto: CreateRutaDto): Promise<Ruta> {
    // Verificar si ya existe una ruta con el mismo orden
    const existingRuta = await this.rutaRepository.findOne({
      where: { Orden: createRutaDto.orden },
    });

    if (existingRuta) {
      throw new ConflictException(
        `Ya existe una ruta con el orden ${createRutaDto.orden}`,
      );
    }

    const nuevaRuta = this.rutaRepository.create({
      Nombre: createRutaDto.nombre,
      DescripcionCorta: createRutaDto.descripcionCorta,
      Orden: createRutaDto.orden,
      Activo: true,
    });

    return this.rutaRepository.save(nuevaRuta);
  }

  async update(id: number, updateRutaDto: UpdateRutaDto): Promise<Ruta> {
    const ruta = await this.findOne(id);

    // Si se está actualizando el orden, verificar que no exista otra ruta con ese orden
    if (updateRutaDto.orden && updateRutaDto.orden !== ruta.Orden) {
      const existingRuta = await this.rutaRepository.findOne({
        where: { Orden: updateRutaDto.orden },
      });

      if (existingRuta && existingRuta.RutaId !== id) {
        throw new ConflictException(
          `Ya existe una ruta con el orden ${updateRutaDto.orden}`,
        );
      }
    }

    // Actualizar campos
    if (updateRutaDto.nombre !== undefined) {
      ruta.Nombre = updateRutaDto.nombre;
    }
    if (updateRutaDto.descripcionCorta !== undefined) {
      ruta.DescripcionCorta = updateRutaDto.descripcionCorta;
    }
    if (updateRutaDto.orden !== undefined) {
      ruta.Orden = updateRutaDto.orden;
    }
    if (updateRutaDto.activo !== undefined) {
      ruta.Activo = updateRutaDto.activo;
    }

    return this.rutaRepository.save(ruta);
  }

  async remove(id: number): Promise<void> {
    const ruta = await this.findOne(id);
    
    // Soft delete: marcar como inactivo en lugar de eliminar
    ruta.Activo = false;
    await this.rutaRepository.save(ruta);
  }

  async delete(id: number): Promise<void> {
    const ruta = await this.findOne(id);
    await this.rutaRepository.remove(ruta);
  }
}

