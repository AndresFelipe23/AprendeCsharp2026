import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, MaxLength, IsOptional } from 'class-validator';

export class UpdateProfileDto {
  @ApiProperty({
    description: 'Nombre completo del usuario',
    example: 'Juan Pérez',
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(100)
  nombreCompleto?: string;

  @ApiProperty({
    description: 'Correo electrónico del usuario',
    example: 'juan@example.com',
    required: false,
  })
  @IsOptional()
  @IsEmail()
  email?: string;
}

