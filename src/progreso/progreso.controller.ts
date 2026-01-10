import {
  Controller,
  Get,
  Post,
  Put,
  Param,
  ParseIntPipe,
  UseGuards,
  BadRequestException,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { ProgresoService } from './progreso.service';
import { ProgresoLeccion } from '../entities/progreso-leccion.entity';
import { ProgresoPractica } from '../entities/progreso-practica.entity';
import { EstadisticasUsuarioDto } from './dto/estadisticas-usuario.dto';
import { ProgresoRutaDto } from './dto/progreso-ruta.dto';
import { ProgresoCursoDto } from './dto/progreso-curso.dto';
import { ProgresoCompletoDto } from './dto/progreso-completo.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';

@ApiTags('progreso')
@Controller('progreso')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class ProgresoController {
  constructor(private readonly progresoService: ProgresoService) {}

  @Post('lecciones/:leccionId/completar')
  @ApiOperation({
    summary: 'Marcar lección como completada',
    description: 'Marca una lección como completada para el usuario autenticado',
  })
  @ApiParam({
    name: 'leccionId',
    type: 'number',
    description: 'ID de la lección',
    example: 1,
  })
  @ApiResponse({
    status: 201,
    description: 'Lección marcada como completada exitosamente',
    type: ProgresoLeccion,
  })
  @ApiResponse({
    status: 404,
    description: 'Lección no encontrada',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async marcarLeccionCompletada(
    @Param('leccionId', ParseIntPipe) leccionId: number,
    @GetUser() user: any,
  ): Promise<ProgresoLeccion> {
    const usuarioId = user?.usuarioId || user?.sub;
    return this.progresoService.marcarLeccionCompletada(usuarioId, leccionId);
  }

  @Put('lecciones/:leccionId/acceso')
  @ApiOperation({
    summary: 'Actualizar último acceso a lección',
    description: 'Actualiza la fecha de último acceso a una lección',
  })
  @ApiParam({
    name: 'leccionId',
    type: 'number',
    description: 'ID de la lección',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Último acceso actualizado exitosamente',
    type: ProgresoLeccion,
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async actualizarUltimoAcceso(
    @Param('leccionId', ParseIntPipe) leccionId: number,
    @GetUser() user: any,
  ): Promise<ProgresoLeccion> {
    const usuarioId = user?.usuarioId || user?.sub;
    return this.progresoService.actualizarUltimoAcceso(usuarioId, leccionId);
  }

  @Get('lecciones/:leccionId')
  @ApiOperation({
    summary: 'Obtener progreso de una lección',
    description: 'Obtiene el progreso del usuario autenticado para una lección específica',
  })
  @ApiParam({
    name: 'leccionId',
    type: 'number',
    description: 'ID de la lección',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Progreso obtenido exitosamente',
    type: ProgresoLeccion,
  })
  @ApiResponse({
    status: 404,
    description: 'Progreso no encontrado',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerProgresoLeccion(
    @Param('leccionId', ParseIntPipe) leccionId: number,
    @GetUser() user: any,
  ): Promise<ProgresoLeccion | { message: string }> {
    const usuarioId = user?.usuarioId || user?.sub;
    const progreso = await this.progresoService.obtenerProgresoLeccion(usuarioId, leccionId);

    // Si no hay progreso, devolver un objeto JSON en lugar de null
    if (!progreso) {
      return { message: 'No hay progreso registrado para esta lección' };
    }

    return progreso;
  }

  @Get('lecciones/completadas')
  @ApiOperation({
    summary: 'Obtener lecciones completadas',
    description: 'Obtiene una lista de IDs de lecciones completadas por el usuario autenticado',
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de lecciones completadas obtenida exitosamente',
    schema: {
      type: 'array',
      items: {
        type: 'number',
      },
      example: [1, 2, 3],
    },
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerLeccionesCompletadas(
    @GetUser() user: any,
  ): Promise<number[]> {
    // Usar el mismo patrón que otros métodos
    const usuarioId = user?.usuarioId || user?.sub;
    
    // Validación básica sin lanzar error 400, simplemente retornar array vacío
    if (!usuarioId) {
      console.warn('obtenerLeccionesCompletadas: usuario no encontrado, retornando array vacío');
      return [];
    }
    
    // Convertir a número si es necesario
    const userId = typeof usuarioId === 'number' ? usuarioId : Number(usuarioId);
    
    if (isNaN(userId) || userId <= 0) {
      console.warn('obtenerLeccionesCompletadas: usuarioId inválido:', userId);
      return [];
    }
    
    return this.progresoService.obtenerLeccionesCompletadas(userId);
  }

  @Get('estadisticas')
  @ApiOperation({
    summary: 'Obtener estadísticas generales del usuario',
    description: 'Obtiene las estadísticas generales del usuario autenticado (lecciones, prácticas, retos, puntos, nivel)',
  })
  @ApiResponse({
    status: 200,
    description: 'Estadísticas obtenidas exitosamente',
    type: EstadisticasUsuarioDto,
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerEstadisticas(
    @GetUser() user: any,
  ): Promise<EstadisticasUsuarioDto> {
    const usuarioId = user?.usuarioId || user?.sub;
    
    if (!usuarioId) {
      console.warn('obtenerEstadisticas: usuario no encontrado');
      throw new BadRequestException('Usuario no válido o no encontrado. Por favor, inicia sesión nuevamente.');
    }
    
    const userId = typeof usuarioId === 'number' ? usuarioId : Number(usuarioId);
    
    if (isNaN(userId) || userId <= 0) {
      console.warn('obtenerEstadisticas: usuarioId inválido:', userId);
      throw new BadRequestException('Usuario no válido o no encontrado. Por favor, inicia sesión nuevamente.');
    }
    
    return this.progresoService.obtenerEstadisticasUsuario(userId);
  }

  @Get('rutas')
  @ApiOperation({
    summary: 'Obtener progreso de todas las rutas',
    description: 'Obtiene el progreso del usuario autenticado para todas las rutas',
  })
  @ApiResponse({
    status: 200,
    description: 'Progreso de rutas obtenido exitosamente',
    type: [ProgresoRutaDto],
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerProgresoRutas(
    @GetUser() user: any,
  ): Promise<ProgresoRutaDto[]> {
    const usuarioId = user?.usuarioId || user?.sub;
    return this.progresoService.obtenerProgresoRutas(usuarioId);
  }

  @Get('cursos')
  @ApiOperation({
    summary: 'Obtener progreso de todos los cursos',
    description: 'Obtiene el progreso del usuario autenticado para todos los cursos',
  })
  @ApiResponse({
    status: 200,
    description: 'Progreso de cursos obtenido exitosamente',
    type: [ProgresoCursoDto],
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerProgresoCursos(
    @GetUser() user: any,
  ): Promise<ProgresoCursoDto[]> {
    const usuarioId = user?.usuarioId || user?.sub;
    return this.progresoService.obtenerProgresoCursos(usuarioId);
  }

  @Get('practicas/:practicaId')
  @ApiOperation({
    summary: 'Obtener progreso de una práctica',
    description: 'Obtiene el progreso del usuario autenticado para una práctica específica',
  })
  @ApiParam({
    name: 'practicaId',
    type: 'number',
    description: 'ID de la práctica',
    example: 1,
  })
  @ApiResponse({
    status: 200,
    description: 'Progreso obtenido exitosamente',
    type: ProgresoPractica,
  })
  @ApiResponse({
    status: 404,
    description: 'Progreso no encontrado',
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerProgresoPractica(
    @Param('practicaId', ParseIntPipe) practicaId: number,
    @GetUser() user: any,
  ): Promise<ProgresoPractica | null> {
    const usuarioId = user?.usuarioId || user?.sub;
    return this.progresoService.obtenerProgresoPractica(usuarioId, practicaId);
  }

  @Get('completo')
  @ApiOperation({
    summary: 'Obtener progreso completo del usuario',
    description: 'Obtiene todas las estadísticas, progreso de rutas y cursos del usuario en una sola llamada usando procedimiento almacenado optimizado',
  })
  @ApiResponse({
    status: 200,
    description: 'Progreso completo obtenido exitosamente',
    type: ProgresoCompletoDto,
  })
  @ApiResponse({
    status: 401,
    description: 'No autorizado',
  })
  async obtenerProgresoCompleto(
    @GetUser() user: any,
  ): Promise<ProgresoCompletoDto> {
    const usuarioId = user?.usuarioId || user?.sub;
    
    if (!usuarioId) {
      throw new BadRequestException('Usuario no válido o no encontrado. Por favor, inicia sesión nuevamente.');
    }
    
    const userId = typeof usuarioId === 'number' ? usuarioId : Number(usuarioId);
    
    if (isNaN(userId) || userId <= 0) {
      throw new BadRequestException('Usuario no válido o no encontrado. Por favor, inicia sesión nuevamente.');
    }
    
    return this.progresoService.obtenerProgresoCompleto(userId);
  }
}

