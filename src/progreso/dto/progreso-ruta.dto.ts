import { ApiProperty } from '@nestjs/swagger';

export class ProgresoRutaDto {
  @ApiProperty({
    description: 'ID de la ruta',
    example: 1,
  })
  rutaId: number;

  @ApiProperty({
    description: 'Nombre de la ruta',
    example: 'Fundamentos de C#',
  })
  nombre: string;

  @ApiProperty({
    description: 'Porcentaje completado',
    example: 45.5,
  })
  porcentajeCompletado: number;

  @ApiProperty({
    description: 'Cursos completados',
    example: 2,
  })
  cursosCompletados: number;

  @ApiProperty({
    description: 'Total de cursos',
    example: 5,
  })
  totalCursos: number;
}

