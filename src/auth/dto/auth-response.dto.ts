import { ApiProperty } from '@nestjs/swagger';

export class AuthResponseDto {
  @ApiProperty({
    description: 'Token JWT para autenticación',
    example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  })
  accessToken: string;

  @ApiProperty({
    description: 'Información del usuario autenticado',
  })
  user: {
    usuarioId: number;
    nombreUsuario: string;
    email: string;
    nombreCompleto?: string;
    puntosTotales: number;
    nivel: number;
  };
}

