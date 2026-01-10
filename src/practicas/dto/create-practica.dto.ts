import {
  IsString,
  IsInt,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsArray,
  ValidateNested,
  IsBoolean,
} from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

export enum TipoEjercicio {
  MultipleChoice = 'MultipleChoice',
  CompletarCodigo = 'CompletarCodigo',
  EscribirCodigo = 'EscribirCodigo',
}

export class CreatePracticaOpcionDto {
  @ApiProperty({ description: 'Texto de la opción', example: 'int' })
  @IsString()
  @IsNotEmpty()
  TextoOpcion: string;

  @ApiProperty({ description: 'Si es la opción correcta', example: true })
  @IsBoolean()
  EsCorrecta: boolean;

  @ApiProperty({ description: 'Orden de la opción', example: 1 })
  @IsInt()
  Orden: number;

  @ApiProperty({
    description: 'Explicación de la opción',
    example: 'Correcto! int es ideal para números enteros.',
    required: false,
  })
  @IsString()
  @IsOptional()
  Explicacion?: string;
}

export class CreatePracticaBloqueDto {
  @ApiProperty({
    description: 'Código base con marcadores [BLOQUE_1], [BLOQUE_2], etc.',
    example: '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];',
  })
  @IsString()
  @IsNotEmpty()
  CodigoBase: string;

  @ApiProperty({ description: 'Orden del bloque', example: 1 })
  @IsInt()
  OrdenBloque: number;

  @ApiProperty({ description: 'Texto del bloque arrastrable', example: 'int' })
  @IsString()
  @IsNotEmpty()
  TextoBloque: string;

  @ApiProperty({
    description: 'Posición correcta en el código (1, 2, 3...)',
    example: 1,
  })
  @IsInt()
  PosicionCorrecta: number;

  @ApiProperty({
    description: 'Si es un bloque distractor (falso)',
    example: false,
  })
  @IsBoolean()
  @IsOptional()
  EsDistractor?: boolean;
}

export class CreatePracticaCodigoDto {
  @ApiProperty({
    description: 'Código base inicial (opcional)',
    example: '// Escribe tu código aquí',
    required: false,
  })
  @IsString()
  @IsOptional()
  CodigoBase?: string;

  @ApiProperty({
    description: 'Solución esperada completa',
    example: 'int edad = 20;\nstring nombre = "María";',
  })
  @IsString()
  @IsNotEmpty()
  SolucionEsperada: string;

  @ApiProperty({
    description: 'Casos de prueba en JSON',
    example: '[{"input": "...", "output": "..."}]',
    required: false,
  })
  @IsString()
  @IsOptional()
  CasosPrueba?: string;

  @ApiProperty({
    description: 'Pista opcional para el usuario',
    required: false,
  })
  @IsString()
  @IsOptional()
  PistaOpcional?: string;
}

export class CreatePracticaDto {
  @ApiProperty({ description: 'ID de la lección', example: 1 })
  @IsInt()
  @IsNotEmpty()
  LeccionId: number;

  @ApiProperty({
    description: 'Tipo de ejercicio',
    enum: TipoEjercicio,
    example: 'MultipleChoice',
  })
  @IsEnum(TipoEjercicio)
  @IsNotEmpty()
  TipoEjercicio: TipoEjercicio;

  @ApiProperty({
    description: 'Título de la práctica',
    example: '¿Qué tipo de dato usarías para almacenar la edad?',
  })
  @IsString()
  @IsNotEmpty()
  Titulo: string;

  @ApiProperty({
    description: 'Enunciado de la práctica',
    example: 'Selecciona la opción correcta:',
  })
  @IsString()
  @IsNotEmpty()
  Enunciado: string;

  @ApiProperty({ description: 'Orden de la práctica', example: 1 })
  @IsInt()
  @IsNotEmpty()
  Orden: number;

  @ApiProperty({
    description: 'Si la práctica está activa',
    example: true,
    required: false,
    default: true,
  })
  @IsBoolean()
  @IsOptional()
  Activo?: boolean;

  @ApiProperty({
    description: 'Opciones (solo para MultipleChoice)',
    type: [CreatePracticaOpcionDto],
    required: false,
  })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreatePracticaOpcionDto)
  @IsOptional()
  Opciones?: CreatePracticaOpcionDto[];

  @ApiProperty({
    description: 'Bloques (solo para CompletarCodigo)',
    type: [CreatePracticaBloqueDto],
    required: false,
  })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreatePracticaBloqueDto)
  @IsOptional()
  Bloques?: CreatePracticaBloqueDto[];

  @ApiProperty({
    description: 'Código (solo para EscribirCodigo)',
    type: CreatePracticaCodigoDto,
    required: false,
  })
  @ValidateNested()
  @Type(() => CreatePracticaCodigoDto)
  @IsOptional()
  Codigo?: CreatePracticaCodigoDto;
}

