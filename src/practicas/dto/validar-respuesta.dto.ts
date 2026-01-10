import {
  IsString,
  IsInt,
  IsArray,
  IsOptional,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

export class ValidarRespuestaMultipleChoiceDto {
  @ApiProperty({
    description: 'ID de la opción seleccionada',
    example: 1,
  })
  @IsInt()
  OpcionId: number;
}

export class ValidarRespuestaCompletarCodigoDto {
  @ApiProperty({
    description: 'Array de bloques en el orden seleccionado',
    example: [1, 2, 3],
  })
  @IsArray()
  @IsInt({ each: true })
  BloquesOrden: number[];
}

export class ValidarRespuestaEscribirCodigoDto {
  @ApiProperty({
    description: 'Código escrito por el usuario',
    example: 'int edad = 20;',
  })
  @IsString()
  CodigoUsuario: string;
}

export class ValidarRespuestaDto {
  @ApiProperty({
    description: 'Respuesta para MultipleChoice',
    type: ValidarRespuestaMultipleChoiceDto,
    required: false,
  })
  @ValidateNested()
  @Type(() => ValidarRespuestaMultipleChoiceDto)
  @IsOptional()
  MultipleChoice?: ValidarRespuestaMultipleChoiceDto;

  @ApiProperty({
    description: 'Respuesta para CompletarCodigo',
    type: ValidarRespuestaCompletarCodigoDto,
    required: false,
  })
  @ValidateNested()
  @Type(() => ValidarRespuestaCompletarCodigoDto)
  @IsOptional()
  CompletarCodigo?: ValidarRespuestaCompletarCodigoDto;

  @ApiProperty({
    description: 'Respuesta para EscribirCodigo',
    type: ValidarRespuestaEscribirCodigoDto,
    required: false,
  })
  @ValidateNested()
  @Type(() => ValidarRespuestaEscribirCodigoDto)
  @IsOptional()
  EscribirCodigo?: ValidarRespuestaEscribirCodigoDto;
}

export class RespuestaValidacionDto {
  @ApiProperty({ description: 'Si la respuesta es correcta', example: true })
  EsCorrecta: boolean;

  @ApiProperty({
    description: 'Mensaje de retroalimentación',
    example: '¡Correcto!',
  })
  Mensaje: string;

  @ApiProperty({
    description: 'Explicación detallada',
    example: 'int es el tipo correcto para números enteros.',
    required: false,
  })
  Explicacion?: string;

  @ApiProperty({
    description: 'Puntos obtenidos',
    example: 10,
  })
  PuntosObtenidos: number;
}

