import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Practica } from './practica.entity';

@Entity('PracticaBloques')
export class PracticaBloque {
  @PrimaryGeneratedColumn()
  BloqueId: number;

  @Column({ type: 'int' })
  PracticaId: number;

  @ManyToOne(() => Practica, (practica) => practica.Bloques, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'PracticaId' })
  Practica: Practica;

  @Column({ type: 'nvarchar', length: 'MAX' })
  CodigoBase: string;

  @Column({ type: 'int' })
  OrdenBloque: number;

  @Column({ type: 'nvarchar', length: 500 })
  TextoBloque: string;

  @Column({ type: 'int' })
  PosicionCorrecta: number;

  @Column({ type: 'bit', default: false })
  EsDistractor: boolean;
}

