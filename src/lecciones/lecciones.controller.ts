import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  ParseIntPipe,
  Query,
  HttpCode,
  HttpStatus,
  UseGuards,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiQuery,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { LeccionesService } from './lecciones.service';
import { Leccion } from '../entities/leccion.entity';
import { CreateLeccionDto } from './dto/create-leccion.dto';
import { UpdateLeccionDto } from './dto/update-leccion.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('lecciones')
@Controller('lecciones')
export class LeccionesController {
  constructor(private readonly leccionesService: LeccionesService) {}

  @Get('curso/:cursoId')
  @ApiOperation({
    summary: 'Obtener lecciones de un curso',
    description: 'Retorna todas las lecciones de un curso específico. Por defecto solo muestra las activas.',
  })
  @ApiParam({
    name: 'cursoId',
    type: 'number',
    description: 'ID del curso',
    example: 1,
  })
  @ApiQuery({
    name: 'includeInactive',
    required: false,
    type: Boolean,
    description: 'Incluir lecciones inactivas en los resultados',
    example: false,
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de lecciones obtenida exitosamente',
    type: [Leccion],
  })
  async findAllByCurso(
    @Param('cursoId', ParseIntPipe) cursoId: number,
    @Query('includeInactive') includeInactive?: string,
  ): Promise<Leccion[]> {
    const include = includeInactive === 'true';
    return this.leccionesService.findAllByCurso(cursoId, include);
  }

  @Get(':id')
  @ApiOperation({
    summary: 'Obtener una lección por ID',
    description: 'Retorna los detalles de una lección específica',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la lección',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Lección encontrada',
    type: Leccion,
  })
  @ApiResponse({
    status: 404,
    description: 'Lección no encontrada',
  })
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<Leccion> {
    return this.leccionesService.findOne(id);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({
    summary: 'Crear una nueva lección',
    description: 'Crea una nueva lección dentro de un curso. Requiere autenticación.',
  })
  @ApiResponse({
    status: 201,
    description: 'Lección creada exitosamente',
    type: Leccion,
  })
  @ApiResponse({
    status: 400,
    description: 'Datos de lección inválidos',
  })
  @ApiResponse({
    status: 404,
    description: 'Curso no encontrado',
  })
  @ApiResponse({
    status: 409,
    description: 'Ya existe una lección con ese orden en el curso',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async create(@Body() createLeccionDto: CreateLeccionDto): Promise<Leccion> {
    return this.leccionesService.create(createLeccionDto);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Actualizar una lección',
    description: 'Actualiza los datos de una lección existente. Requiere autenticación.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la lección a actualizar',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Lección actualizada exitosamente',
    type: Leccion,
  })
  @ApiResponse({
    status: 404,
    description: 'Lección no encontrada',
  })
  @ApiResponse({
    status: 409,
    description: 'Conflicto con el orden de otra lección en el curso',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateLeccionDto: UpdateLeccionDto,
  ): Promise<Leccion> {
    return this.leccionesService.update(id, updateLeccionDto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({
    summary: 'Desactivar una lección (Soft Delete)',
    description: 'Marca una lección como inactiva en lugar de eliminarla. Requiere autenticación.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la lección a desactivar',
    example: 1,
  })
  @ApiResponse({
    status: 204,
    description: 'Lección desactivada exitosamente',
  })
  @ApiResponse({
    status: 404,
    description: 'Lección no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.leccionesService.remove(id);
  }

  @Delete(':id/permanent')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({
    summary: 'Eliminar permanentemente una lección',
    description: 'Elimina permanentemente una lección de la base de datos. Requiere autenticación. ⚠️ CUIDADO: Esta acción no se puede deshacer.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la lección a eliminar',
    example: 1,
  })
  @ApiResponse({
    status: 204,
    description: 'Lección eliminada permanentemente',
  })
  @ApiResponse({
    status: 404,
    description: 'Lección no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async delete(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.leccionesService.delete(id);
  }
}

