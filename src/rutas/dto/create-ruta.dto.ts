import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, MaxLength, IsOptional, IsInt, Min } from 'class-validator';

export class CreateRutaDto {
  @ApiProperty({
    description: 'Nombre de la ruta',
    example: 'Fundamentos de C#',
    maxLength: 100,
  })
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  nombre: string;

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
  })
  @IsInt()
  @Min(1)
  orden: number;
}

