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
import { RutasService } from './rutas.service';
import { Ruta } from '../entities/ruta.entity';
import { CreateRutaDto } from './dto/create-ruta.dto';
import { UpdateRutaDto } from './dto/update-ruta.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('rutas')
@Controller('rutas')
export class RutasController {
  constructor(private readonly rutasService: RutasService) {}

  @Get()
  @ApiOperation({
    summary: 'Obtener todas las rutas',
    description: 'Retorna una lista de todas las rutas de aprendizaje. Por defecto solo muestra las activas.',
  })
  @ApiQuery({
    name: 'includeInactive',
    required: false,
    type: Boolean,
    description: 'Incluir rutas inactivas en los resultados',
    example: false,
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de rutas obtenida exitosamente',
    type: [Ruta],
  })
  async findAll(
    @Query('includeInactive') includeInactive?: string,
  ): Promise<Ruta[]> {
    const include = includeInactive === 'true';
    return this.rutasService.findAll(include);
  }

  @Get(':id')
  @ApiOperation({
    summary: 'Obtener una ruta por ID',
    description: 'Retorna los detalles de una ruta específica incluyendo sus cursos',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la ruta',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Ruta encontrada',
    type: Ruta,
  })
  @ApiResponse({
    status: 404,
    description: 'Ruta no encontrada',
  })
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<Ruta> {
    return this.rutasService.findOne(id);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({
    summary: 'Crear una nueva ruta',
    description: 'Crea una nueva ruta de aprendizaje. Requiere autenticación.',
  })
  @ApiResponse({
    status: 201,
    description: 'Ruta creada exitosamente',
    type: Ruta,
  })
  @ApiResponse({
    status: 400,
    description: 'Datos de ruta inválidos',
  })
  @ApiResponse({
    status: 409,
    description: 'Ya existe una ruta con ese orden',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async create(@Body() createRutaDto: CreateRutaDto): Promise<Ruta> {
    return this.rutasService.create(createRutaDto);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Actualizar una ruta',
    description: 'Actualiza los datos de una ruta existente. Requiere autenticación.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la ruta a actualizar',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Ruta actualizada exitosamente',
    type: Ruta,
  })
  @ApiResponse({
    status: 404,
    description: 'Ruta no encontrada',
  })
  @ApiResponse({
    status: 409,
    description: 'Conflicto con el orden de otra ruta',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateRutaDto: UpdateRutaDto,
  ): Promise<Ruta> {
    return this.rutasService.update(id, updateRutaDto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({
    summary: 'Desactivar una ruta (Soft Delete)',
    description: 'Marca una ruta como inactiva en lugar de eliminarla. Requiere autenticación.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la ruta a desactivar',
    example: 1,
  })
  @ApiResponse({
    status: 204,
    description: 'Ruta desactivada exitosamente',
  })
  @ApiResponse({
    status: 404,
    description: 'Ruta no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.rutasService.remove(id);
  }

  @Delete(':id/permanent')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({
    summary: 'Eliminar permanentemente una ruta',
    description: 'Elimina permanentemente una ruta de la base de datos. Requiere autenticación. ⚠️ CUIDADO: Esta acción no se puede deshacer.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la ruta a eliminar',
    example: 1,
  })
  @ApiResponse({
    status: 204,
    description: 'Ruta eliminada permanentemente',
  })
  @ApiResponse({
    status: 404,
    description: 'Ruta no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async delete(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.rutasService.delete(id);
  }
}

