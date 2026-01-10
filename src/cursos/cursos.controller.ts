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
import { CursosService } from './cursos.service';
import { Curso } from '../entities/curso.entity';
import { CreateCursoDto } from './dto/create-curso.dto';
import { UpdateCursoDto } from './dto/update-curso.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('cursos')
@Controller('cursos')
export class CursosController {
  constructor(private readonly cursosService: CursosService) {}

  @Get('ruta/:rutaId')
  @ApiOperation({
    summary: 'Obtener cursos de una ruta',
    description: 'Retorna todos los cursos de una ruta específica. Por defecto solo muestra los activos.',
  })
  @ApiParam({
    name: 'rutaId',
    type: 'number',
    description: 'ID de la ruta',
    example: 1,
  })
  @ApiQuery({
    name: 'includeInactive',
    required: false,
    type: Boolean,
    description: 'Incluir cursos inactivos en los resultados',
    example: false,
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de cursos obtenida exitosamente',
    type: [Curso],
  })
  async findAllByRuta(
    @Param('rutaId', ParseIntPipe) rutaId: number,
    @Query('includeInactive') includeInactive?: string,
  ): Promise<Curso[]> {
    const include = includeInactive === 'true';
    return this.cursosService.findAllByRuta(rutaId, include);
  }

  @Get(':id')
  @ApiOperation({
    summary: 'Obtener un curso por ID',
    description: 'Retorna los detalles de un curso específico incluyendo sus lecciones',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID del curso',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Curso encontrado',
    type: Curso,
  })
  @ApiResponse({
    status: 404,
    description: 'Curso no encontrado',
  })
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<Curso> {
    return this.cursosService.findOne(id);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({
    summary: 'Crear un nuevo curso',
    description: 'Crea un nuevo curso dentro de una ruta. Requiere autenticación.',
  })
  @ApiResponse({
    status: 201,
    description: 'Curso creado exitosamente',
    type: Curso,
  })
  @ApiResponse({
    status: 400,
    description: 'Datos de curso inválidos',
  })
  @ApiResponse({
    status: 404,
    description: 'Ruta no encontrada',
  })
  @ApiResponse({
    status: 409,
    description: 'Ya existe un curso con ese orden en la ruta',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async create(@Body() createCursoDto: CreateCursoDto): Promise<Curso> {
    return this.cursosService.create(createCursoDto);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Actualizar un curso',
    description: 'Actualiza los datos de un curso existente. Requiere autenticación.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID del curso a actualizar',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Curso actualizado exitosamente',
    type: Curso,
  })
  @ApiResponse({
    status: 404,
    description: 'Curso no encontrado',
  })
  @ApiResponse({
    status: 409,
    description: 'Conflicto con el orden de otro curso en la ruta',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateCursoDto: UpdateCursoDto,
  ): Promise<Curso> {
    return this.cursosService.update(id, updateCursoDto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({
    summary: 'Desactivar un curso (Soft Delete)',
    description: 'Marca un curso como inactivo en lugar de eliminarlo. Requiere autenticación.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID del curso a desactivar',
    example: 1,
  })
  @ApiResponse({
    status: 204,
    description: 'Curso desactivado exitosamente',
  })
  @ApiResponse({
    status: 404,
    description: 'Curso no encontrado',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.cursosService.remove(id);
  }

  @Delete(':id/permanent')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({
    summary: 'Eliminar permanentemente un curso',
    description: 'Elimina permanentemente un curso de la base de datos. Requiere autenticación. ⚠️ CUIDADO: Esta acción no se puede deshacer.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID del curso a eliminar',
    example: 1,
  })
  @ApiResponse({
    status: 204,
    description: 'Curso eliminado permanentemente',
  })
  @ApiResponse({
    status: 404,
    description: 'Curso no encontrado',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async delete(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.cursosService.delete(id);
  }
}

