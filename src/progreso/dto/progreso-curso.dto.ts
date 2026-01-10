import { ApiProperty } from '@nestjs/swagger';

export class ProgresoCursoDto {
  @ApiProperty({
    description: 'ID del curso',
    example: 1,
  })
  cursoId: number;

  @ApiProperty({
    description: 'Nombre del curso',
    example: 'Variables y Tipos de Datos',
  })
  nombre: string;

  @ApiProperty({
    description: 'ID de la ruta a la que pertenece',
    example: 1,
  })
  rutaId: number;

  @ApiProperty({
    description: 'Nombre de la ruta',
    example: 'Fundamentos de C#',
  })
  rutaNombre: string;

  @ApiProperty({
    description: 'Porcentaje completado',
    example: 66.67,
  })
  porcentajeCompletado: number;

  @ApiProperty({
    description: 'Lecciones completadas',
    example: 5,
  })
  leccionesCompletadas: number;

  @ApiProperty({
    description: 'Total de lecciones',
    example: 7,
  })
  totalLecciones: number;

  @ApiProperty({
    description: 'Prácticas completadas',
    example: 3,
  })
  practicasCompletadas: number;

  @ApiProperty({
    description: 'Total de prácticas',
    example: 5,
  })
  totalPracticas: number;
}

