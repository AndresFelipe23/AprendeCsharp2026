import { ApiProperty } from '@nestjs/swagger';

export class EstadisticasUsuarioDto {
  @ApiProperty({
    description: 'Total de lecciones completadas',
    example: 15,
  })
  leccionesCompletadas: number;

  @ApiProperty({
    description: 'Total de prácticas completadas',
    example: 8,
  })
  practicasCompletadas: number;

  @ApiProperty({
    description: 'Total de retos completados',
    example: 3,
  })
  retosCompletados: number;

  @ApiProperty({
    description: 'Puntos totales del usuario',
    example: 250,
  })
  puntosTotales: number;

  @ApiProperty({
    description: 'Nivel del usuario',
    example: 3,
  })
  nivel: number;
}

