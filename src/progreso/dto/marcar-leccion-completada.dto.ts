import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsOptional } from 'class-validator';

export class MarcarLeccionCompletadaDto {
  @ApiProperty({
    description: 'Indica si la lección está completada',
    example: true,
    required: false,
    default: true,
  })
  @IsOptional()
  @IsBoolean()
  completada?: boolean;
}

