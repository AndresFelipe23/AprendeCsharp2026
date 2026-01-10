import { ApiProperty } from '@nestjs/swagger';
import { IsString, MaxLength, IsOptional, IsInt, Min, IsBoolean } from 'class-validator';

export class UpdateLeccionDto {
  @ApiProperty({
    description: 'Título de la lección',
    example: 'Introducción a las Variables',
    maxLength: 150,
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(150)
  titulo?: string;

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
    required: false,
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  orden?: number;

  @ApiProperty({
    description: 'Estado activo/inactivo de la lección',
    example: true,
    required: false,
  })
  @IsOptional()
  @IsBoolean()
  activo?: boolean;
}

