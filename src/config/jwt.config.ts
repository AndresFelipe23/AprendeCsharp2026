import { registerAs } from '@nestjs/config';

export default registerAs('jwt', () => ({
  secret: process.env.JWT_SECRET || 'tu-secret-key-cambiar-en-produccion',
  expiresIn: process.env.JWT_EXPIRES_IN || '7d',
}));

