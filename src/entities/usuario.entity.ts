import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('Usuarios')
export class Usuario {
  @PrimaryGeneratedColumn()
  UsuarioId: number;

  @Column({ type: 'nvarchar', length: 50, unique: true })
  NombreUsuario: string;

  @Column({ type: 'nvarchar', length: 100, unique: true })
  Email: string;

  @Column({ type: 'nvarchar', length: 255, nullable: true })
  ContrasenaHash: string;

  @Column({ type: 'nvarchar', length: 100, nullable: true })
  NombreCompleto: string;

  @Column({ type: 'nvarchar', length: 500, nullable: true })
  FotoPerfilUrl: string;

  @Column({ type: 'int', default: 0 })
  PuntosTotales: number;

  @Column({ type: 'int', default: 1 })
  Nivel: number;

  @CreateDateColumn({ 
    type: 'datetimeoffset',
    default: () => 'SYSDATETIMEOFFSET()'
  })
  FechaRegistro: Date;

  @UpdateDateColumn({ type: 'datetimeoffset', nullable: true })
  UltimaConexion: Date;

  @Column({ type: 'bit', default: true })
  Activo: boolean;
}

