import { ApiProperty } from '@nestjs/swagger';
import { IsString, MaxLength, IsOptional, IsInt, Min, IsBoolean } from 'class-validator';

export class UpdateCursoDto {
  @ApiProperty({
    description: 'Nombre del curso',
    example: 'Variables y Tipos de Datos',
    maxLength: 100,
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(100)
  nombre?: string;

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
    required: false,
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  orden?: number;

  @ApiProperty({
    description: 'Estado activo/inactivo del curso',
    example: true,
    required: false,
  })
  @IsOptional()
  @IsBoolean()
  activo?: boolean;
}

