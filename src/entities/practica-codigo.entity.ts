import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  OneToOne,
  JoinColumn,
} from 'typeorm';
import { Practica } from './practica.entity';

@Entity('PracticaCodigo')
export class PracticaCodigo {
  @PrimaryGeneratedColumn()
  PracticaCodigoId: number;

  @Column({ type: 'int' })
  PracticaId: number;

  @OneToOne(() => Practica, (practica) => practica.Codigo, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'PracticaId' })
  Practica: Practica;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  CodigoBase: string | null;

  @Column({ type: 'nvarchar', length: 'MAX' })
  SolucionEsperada: string;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  CasosPrueba: string | null;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  PistaOpcional: string | null;
}

