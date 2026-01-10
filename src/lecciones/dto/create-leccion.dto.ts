import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, MaxLength, IsOptional, IsInt, Min } from 'class-validator';

export class CreateLeccionDto {
  @ApiProperty({
    description: 'ID del curso al que pertenece la lección',
    example: 1,
  })
  @IsInt()
  @Min(1)
  cursoId: number;

  @ApiProperty({
    description: 'Título de la lección',
    example: 'Introducción a las Variables',
    maxLength: 150,
  })
  @IsString()
  @IsNotEmpty()
  @MaxLength(150)
  titulo: string;

  @ApiProperty({
    description: 'Descripción corta de la lección',
    example: 'Aprende los conceptos básicos de las variables en C#',
    maxLength: 255,
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(255)
  descripcionCorta?: string;

  @ApiProperty({
    description: 'Contenido breve de la lección (texto explicativo)',
    example: 'Las variables son contenedores que almacenan valores...',
    required: false,
  })
  @IsOptional()
  @IsString()
  contenidoBreve?: string;

  @ApiProperty({
    description: 'Código de ejemplo para la lección',
    example: 'int edad = 25;\nstring nombre = "Juan";',
    required: false,
  })
  @IsOptional()
  @IsString()
  codigoEjemplo?: string;

  @ApiProperty({
    description: 'Orden de visualización dentro del curso',
    example: 1,
    minimum: 1,
  })
  @IsInt()
  @Min(1)
  orden: number;
}

