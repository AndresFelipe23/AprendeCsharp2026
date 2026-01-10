import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
  Unique,
} from 'typeorm';
import { Usuario } from './usuario.entity';
import { Leccion } from './leccion.entity';

@Entity('ProgresoLecciones')
@Unique(['UsuarioId', 'LeccionId'])
export class ProgresoLeccion {
  @PrimaryGeneratedColumn()
  ProgresoLeccionId: number;

  @Column({ type: 'int' })
  UsuarioId: number;

  @ManyToOne(() => Usuario)
  @JoinColumn({ name: 'UsuarioId' })
  Usuario: Usuario;

  @Column({ type: 'int' })
  LeccionId: number;

  @ManyToOne(() => Leccion)
  @JoinColumn({ name: 'LeccionId' })
  Leccion: Leccion;

  @Column({ type: 'bit', default: false })
  Completada: boolean;

  @Column({ type: 'datetime', nullable: true })
  FechaCompletacion: Date | null;

  @CreateDateColumn({ type: 'datetime' })
  FechaUltimoAcceso: Date;
}

