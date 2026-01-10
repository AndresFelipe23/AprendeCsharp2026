import { ApiProperty } from '@nestjs/swagger';
import { IsString, MaxLength, IsOptional, IsInt, Min, IsBoolean } from 'class-validator';

export class UpdateRutaDto {
  @ApiProperty({
    description: 'Nombre de la ruta',
    example: 'Fundamentos de C#',
    maxLength: 100,
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(100)
  nombre?: string;

  @ApiProperty({
    description: 'Descripción corta de la ruta',
    example: 'Aprende los conceptos básicos del lenguaje C#',
    maxLength: 255,
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(255)
  descripcionCorta?: string;

  @ApiProperty({
    description: 'Orden de visualización',
    example: 1,
    minimum: 1,
    required: false,
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  orden?: number;

  @ApiProperty({
    description: 'Estado activo/inactivo de la ruta',
    example: true,
    required: false,
  })
  @IsOptional()
  @IsBoolean()
  activo?: boolean;
}

