import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Practica } from './practica.entity';

@Entity('PracticaOpciones')
export class PracticaOpcion {
  @PrimaryGeneratedColumn()
  OpcionId: number;

  @Column({ type: 'int' })
  PracticaId: number;

  @ManyToOne(() => Practica, (practica) => practica.Opciones, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'PracticaId' })
  Practica: Practica;

  @Column({ type: 'nvarchar', length: 500 })
  TextoOpcion: string;

  @Column({ type: 'bit', default: false })
  EsCorrecta: boolean;

  @Column({ type: 'int' })
  Orden: number;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  Explicacion: string | null;
}

