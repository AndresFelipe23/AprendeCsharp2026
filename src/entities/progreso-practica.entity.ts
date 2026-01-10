import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Usuario } from './usuario.entity';
import { Practica } from './practica.entity';

@Entity('ProgresoPracticas')
export class ProgresoPractica {
  @PrimaryGeneratedColumn()
  ProgresoPracticaId: number;

  @Column({ type: 'int' })
  UsuarioId: number;

  @Column({ type: 'int' })
  PracticaId: number;

  @ManyToOne(() => Usuario, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'UsuarioId' })
  Usuario: Usuario;

  @ManyToOne(() => Practica)
  @JoinColumn({ name: 'PracticaId' })
  Practica: Practica;

  @Column({ type: 'bit', default: false })
  Completada: boolean;

  @Column({ type: 'int', default: 0 })
  Intentos: number;

  @Column({ type: 'bit', default: false })
  CorrectoEnPrimerIntento: boolean;

  @Column({ type: 'int', default: 0 })
  PuntosObtenidos: number;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  RespuestaUsuario: string | null;

  @Column({ type: 'datetime', nullable: true })
  FechaCompletacion: Date | null;

  @Column({ type: 'datetime', default: () => 'GETDATE()' })
  FechaUltimoIntento: Date;
}

