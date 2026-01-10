import {
  Injectable,
  UnauthorizedException,
  ConflictException,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { Usuario } from '../entities/usuario.entity';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { ChangePasswordDto } from './dto/change-password.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(Usuario)
    private usuarioRepository: Repository<Usuario>,
    private jwtService: JwtService,
  ) {}

  async register(registerDto: RegisterDto) {
    const { nombreUsuario, email, contrasena, nombreCompleto } = registerDto;

    try {
      // Verificar si el usuario ya existe
      const existingUser = await this.usuarioRepository.findOne({
        where: [
          { Email: email },
          { NombreUsuario: nombreUsuario },
        ],
      });

      if (existingUser) {
        throw new ConflictException(
          'El usuario o email ya está registrado',
        );
      }

      // Hashear la contraseña
      const saltRounds = 10;
      const contrasenaHash = await bcrypt.hash(contrasena, saltRounds);

      // Crear nuevo usuario
      const fechaActual = new Date();
      const nuevoUsuario = this.usuarioRepository.create({
        NombreUsuario: nombreUsuario,
        Email: email,
        ContrasenaHash: contrasenaHash,
        NombreCompleto: nombreCompleto,
        PuntosTotales: 0,
        Nivel: 1,
        FechaRegistro: fechaActual, // Establecer explícitamente la fecha
        Activo: true,
      });

      console.log('Intentando guardar usuario:', {
        NombreUsuario: nuevoUsuario.NombreUsuario,
        Email: nuevoUsuario.Email,
      });

      const usuarioGuardado = await this.usuarioRepository.save(nuevoUsuario);
      
      console.log('Usuario guardado exitosamente:', usuarioGuardado.UsuarioId);

    // Generar token JWT
    const payload = {
      sub: usuarioGuardado.UsuarioId,
      email: usuarioGuardado.Email,
      nombreUsuario: usuarioGuardado.NombreUsuario,
    };

    const accessToken = this.jwtService.sign(payload);

    // Actualizar última conexión (Colombia UTC-5)
    // TypeORM manejará automáticamente la zona horaria con datetimeoffset
    usuarioGuardado.UltimaConexion = new Date();
    await this.usuarioRepository.save(usuarioGuardado);

      return {
        accessToken,
        user: {
          usuarioId: usuarioGuardado.UsuarioId,
          nombreUsuario: usuarioGuardado.NombreUsuario,
          email: usuarioGuardado.Email,
          nombreCompleto: usuarioGuardado.NombreCompleto,
          puntosTotales: usuarioGuardado.PuntosTotales,
          nivel: usuarioGuardado.Nivel,
        },
      };
    } catch (error) {
      console.error('Error al registrar usuario:', error);
      throw error;
    }
  }

  async login(loginDto: LoginDto) {
    const { emailOrUsername, contrasena } = loginDto;

    // Buscar usuario por email o nombre de usuario
    const usuario = await this.usuarioRepository.findOne({
      where: [
        { Email: emailOrUsername },
        { NombreUsuario: emailOrUsername },
      ],
    });

    if (!usuario) {
      throw new UnauthorizedException('Credenciales inválidas');
    }

    if (!usuario.Activo) {
      throw new UnauthorizedException('Usuario inactivo');
    }

    // Verificar contraseña
    const isPasswordValid = await bcrypt.compare(
      contrasena,
      usuario.ContrasenaHash,
    );

    if (!isPasswordValid) {
      throw new UnauthorizedException('Credenciales inválidas');
    }

    // Generar token JWT
    const payload = {
      sub: usuario.UsuarioId,
      email: usuario.Email,
      nombreUsuario: usuario.NombreUsuario,
    };

    const accessToken = this.jwtService.sign(payload);

    // Actualizar última conexión (Colombia UTC-5)
    // TypeORM manejará automáticamente la zona horaria con datetimeoffset
    usuario.UltimaConexion = new Date();
    await this.usuarioRepository.save(usuario);

    return {
      accessToken,
      user: {
        usuarioId: usuario.UsuarioId,
        nombreUsuario: usuario.NombreUsuario,
        email: usuario.Email,
        nombreCompleto: usuario.NombreCompleto,
        puntosTotales: usuario.PuntosTotales,
        nivel: usuario.Nivel,
      },
    };
  }

  async validateUser(userId: number): Promise<Usuario | null> {
    const usuario = await this.usuarioRepository.findOne({
      where: { UsuarioId: userId },
    });

    if (!usuario || !usuario.Activo) {
      return null;
    }

    return usuario;
  }

  async updateProfile(userId: number, updateProfileDto: UpdateProfileDto) {
    const usuario = await this.usuarioRepository.findOne({
      where: { UsuarioId: userId },
    });

    if (!usuario) {
      throw new NotFoundException('Usuario no encontrado');
    }

    // Verificar si el email ya está en uso por otro usuario
    if (updateProfileDto.email && updateProfileDto.email !== usuario.Email) {
      const existingUser = await this.usuarioRepository.findOne({
        where: { Email: updateProfileDto.email },
      });

      if (existingUser && existingUser.UsuarioId !== userId) {
        throw new ConflictException('El email ya está en uso');
      }
    }

    // Actualizar campos
    if (updateProfileDto.nombreCompleto !== undefined) {
      usuario.NombreCompleto = updateProfileDto.nombreCompleto;
    }

    if (updateProfileDto.email !== undefined) {
      usuario.Email = updateProfileDto.email;
    }

    await this.usuarioRepository.save(usuario);

    return {
      usuarioId: usuario.UsuarioId,
      nombreUsuario: usuario.NombreUsuario,
      email: usuario.Email,
      nombreCompleto: usuario.NombreCompleto,
      puntosTotales: usuario.PuntosTotales,
      nivel: usuario.Nivel,
    };
  }

  async changePassword(userId: number, changePasswordDto: ChangePasswordDto) {
    const usuario = await this.usuarioRepository.findOne({
      where: { UsuarioId: userId },
    });

    if (!usuario) {
      throw new NotFoundException('Usuario no encontrado');
    }

    // Verificar contraseña actual
    const isPasswordValid = await bcrypt.compare(
      changePasswordDto.contrasenaActual,
      usuario.ContrasenaHash,
    );

    if (!isPasswordValid) {
      throw new UnauthorizedException('La contraseña actual es incorrecta');
    }

    // Verificar que la nueva contraseña sea diferente
    const isSamePassword = await bcrypt.compare(
      changePasswordDto.nuevaContrasena,
      usuario.ContrasenaHash,
    );

    if (isSamePassword) {
      throw new BadRequestException(
        'La nueva contraseña debe ser diferente a la actual',
      );
    }

    // Hashear nueva contraseña
    const saltRounds = 10;
    const nuevaContrasenaHash = await bcrypt.hash(
      changePasswordDto.nuevaContrasena,
      saltRounds,
    );

    usuario.ContrasenaHash = nuevaContrasenaHash;
    await this.usuarioRepository.save(usuario);

    return { message: 'Contraseña actualizada exitosamente' };
  }
}

