import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { EstadisticasUsuarioDto } from './estadisticas-usuario.dto';
import { ProgresoRutaDto } from './progreso-ruta.dto';
import { ProgresoCursoDto } from './progreso-curso.dto';
import { ContinuarLeccionDto } from './continuar-leccion.dto';

export class ProgresoCompletoDto {
  @ApiProperty({
    description: 'Estadísticas generales del usuario',
    type: EstadisticasUsuarioDto,
  })
  estadisticas: EstadisticasUsuarioDto;

  @ApiProperty({
    description: 'Progreso de todas las rutas',
    type: [ProgresoRutaDto],
  })
  progresoRutas: ProgresoRutaDto[];

  @ApiProperty({
    description: 'Progreso de todos los cursos',
    type: [ProgresoCursoDto],
  })
  progresoCursos: ProgresoCursoDto[];

  @ApiPropertyOptional({
    description:
      'Sugerencia para continuar (última lección visitada o siguiente pendiente en ese curso)',
    type: ContinuarLeccionDto,
    nullable: true,
  })
  continuarLeccion?: ContinuarLeccionDto | null;
}

