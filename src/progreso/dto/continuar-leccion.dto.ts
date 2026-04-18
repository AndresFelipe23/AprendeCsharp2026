import { ApiProperty } from '@nestjs/swagger';

export class ContinuarLeccionDto {
  @ApiProperty({ description: 'ID de la lección sugerida' })
  leccionId: number;

  @ApiProperty({ description: 'ID del curso' })
  cursoId: number;

  @ApiProperty({ description: 'Título de la lección' })
  titulo: string;

  @ApiProperty({ description: 'Nombre del curso' })
  cursoNombre: string;

  @ApiProperty({ description: 'Nombre de la ruta' })
  rutaNombre: string;
}
