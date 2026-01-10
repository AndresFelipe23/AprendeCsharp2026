import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  Query,
  ParseIntPipe,
  UseGuards,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiQuery,
  ApiBearerAuth,
  ApiBody,
} from '@nestjs/swagger';
import { PracticasService } from './practicas.service';
import { CreatePracticaDto } from './dto/create-practica.dto';
import { UpdatePracticaDto } from './dto/update-practica.dto';
import {
  ValidarRespuestaDto,
  RespuestaValidacionDto,
} from './dto/validar-respuesta.dto';
import { Practica } from '../entities/practica.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';

@ApiTags('practicas')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('practicas')
export class PracticasController {
  constructor(private readonly practicasService: PracticasService) {}

  @Get('all')
  @ApiOperation({
    summary: 'Obtener todas las prácticas con información de lección y curso',
    description:
      'Retorna todas las prácticas activas con información de su lección, curso y ruta asociados, agrupadas por tipo de ejercicio.',
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de prácticas obtenida exitosamente',
    type: [Practica],
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async findAllWithLeccionAndCurso(): Promise<Practica[]> {
    return this.practicasService.findAllWithLeccionAndCurso();
  }

  @Get('leccion/:leccionId')
  @ApiOperation({
    summary: 'Obtener prácticas de una lección',
    description:
      'Retorna todas las prácticas de una lección específica. Por defecto solo muestra las activas.',
  })
  @ApiParam({
    name: 'leccionId',
    type: 'number',
    description: 'ID de la lección',
    example: 1,
  })
  @ApiQuery({
    name: 'includeInactive',
    required: false,
    type: Boolean,
    description: 'Incluir prácticas inactivas en los resultados',
    example: false,
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de prácticas obtenida exitosamente',
    type: [Practica],
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async findAllByLeccion(
    @Param('leccionId', ParseIntPipe) leccionId: number,
    @Query('includeInactive') includeInactive?: string,
  ): Promise<Practica[]> {
    const include = includeInactive === 'true';
    console.log(`📥 GET /practicas/leccion/${leccionId} - includeInactive: ${include}`);
    const practicas = await this.practicasService.findAllByLeccion(leccionId, include);
    console.log(`📤 Retornando ${practicas.length} prácticas`);
    return practicas;
  }

  @Get(':id')
  @ApiOperation({
    summary: 'Obtener una práctica por ID',
    description:
      'Retorna una práctica específica con todos sus datos relacionados según el tipo (opciones, bloques o código).',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la práctica',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Práctica obtenida exitosamente',
    type: Practica,
  })
  @ApiResponse({
    status: 404,
    description: 'Práctica no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<Practica> {
    return this.practicasService.findOne(id);
  }

  @Post()
  @ApiOperation({
    summary: 'Crear una nueva práctica',
    description:
      'Crea una nueva práctica. Debe incluir los datos específicos según el tipo (opciones, bloques o código).',
  })
  @ApiBody({ type: CreatePracticaDto })
  @ApiResponse({
    status: 201,
    description: 'Práctica creada exitosamente',
    type: Practica,
  })
  @ApiResponse({
    status: 400,
    description: 'Datos inválidos',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async create(@Body() createPracticaDto: CreatePracticaDto): Promise<Practica> {
    return this.practicasService.create(createPracticaDto);
  }

  @Put(':id')
  @ApiOperation({
    summary: 'Actualizar una práctica',
    description: 'Actualiza una práctica existente y sus datos relacionados.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la práctica',
    example: 1,
  })
  @ApiBody({ type: UpdatePracticaDto })
  @ApiResponse({
    status: 200,
    description: 'Práctica actualizada exitosamente',
    type: Practica,
  })
  @ApiResponse({
    status: 404,
    description: 'Práctica no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updatePracticaDto: UpdatePracticaDto,
  ): Promise<Practica> {
    return this.practicasService.update(id, updatePracticaDto);
  }

  @Delete(':id')
  @ApiOperation({
    summary: 'Eliminar una práctica',
    description:
      'Elimina una práctica (soft delete - marca como inactiva).',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la práctica',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Práctica eliminada exitosamente',
  })
  @ApiResponse({
    status: 404,
    description: 'Práctica no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.practicasService.remove(id);
  }

  @Post(':id/validar')
  @ApiOperation({
    summary: 'Validar respuesta de una práctica',
    description:
      'Valida la respuesta del usuario para una práctica específica. Retorna si es correcta, mensaje y puntos obtenidos.',
  })
  @ApiParam({
    name: 'id',
    type: 'number',
    description: 'ID de la práctica',
    example: 1,
  })
  @ApiBody({ type: ValidarRespuestaDto })
  @ApiResponse({
    status: 200,
    description: 'Respuesta validada exitosamente',
    type: RespuestaValidacionDto,
  })
  @ApiResponse({
    status: 400,
    description: 'Datos de respuesta inválidos',
  })
  @ApiResponse({
    status: 404,
    description: 'Práctica no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async validarRespuesta(
    @Param('id', ParseIntPipe) id: number,
    @Body() validarRespuestaDto: ValidarRespuestaDto,
    @GetUser() user: any,
  ): Promise<RespuestaValidacionDto> {
    return this.practicasService.validarRespuesta(
      id,
      validarRespuestaDto,
      user.usuarioId,
    );
  }
}

