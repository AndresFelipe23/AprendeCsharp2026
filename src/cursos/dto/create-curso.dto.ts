import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, MaxLength, IsOptional, IsInt, Min } from 'class-validator';

export class CreateCursoDto {
  @ApiProperty({
    description: 'ID de la ruta a la que pertenece el curso',
    example: 1,
  })
  @IsInt()
  @Min(1)
  rutaId: number;

  @ApiProperty({
    description: 'Nombre del curso',
    example: 'Variables y Tipos de Datos',
    maxLength: 100,
  })
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  nombre: string;

  @ApiProperty({
    description: 'Descripción corta del curso',
    example: 'Aprende a declarar y usar variables en C#',
    maxLength: 255,
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(255)
  descripcionCorta?: string;

  @ApiProperty({
    description: 'Orden de visualización dentro de la ruta',
    example: 1,
    minimum: 1,
  })
  @IsInt()
  @Min(1)
  orden: number;
}

