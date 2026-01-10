import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Ruta } from '../entities/ruta.entity';
import { CreateRutaDto } from './dto/create-ruta.dto';
import { UpdateRutaDto } from './dto/update-ruta.dto';

@Injectable()
export class RutasService {
  constructor(
    @InjectRepository(Ruta)
    private rutaRepository: Repository<Ruta>,
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

