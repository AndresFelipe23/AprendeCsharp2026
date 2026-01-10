import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, MinLength } from 'class-validator';

export class LoginDto {
  @ApiProperty({
    description: 'Correo electrónico o nombre de usuario',
    example: 'juan@example.com',
  })
  @IsString()
  emailOrUsername: string;

  @ApiProperty({
    description: 'Contraseña del usuario',
    example: 'MiPassword123!',
  })
  @IsString()
  @MinLength(6)
  contrasena: string;
}

