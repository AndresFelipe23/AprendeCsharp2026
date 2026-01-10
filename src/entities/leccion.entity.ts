import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  ManyToOne,
  OneToMany,
  JoinColumn,
} from 'typeorm';
import { Curso } from './curso.entity';
import { Practica } from './practica.entity';

@Entity('Lecciones')
export class Leccion {
  @PrimaryGeneratedColumn()
  LeccionId: number;

  @Column({ type: 'int' })
  CursoId: number;

  @ManyToOne(() => Curso, (curso) => curso.Lecciones)
  @JoinColumn({ name: 'CursoId' })
  Curso: Curso;

  @Column({ type: 'nvarchar', length: 150 })
  Titulo: string;

  @Column({ type: 'nvarchar', length: 255, nullable: true })
  DescripcionCorta: string;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  ContenidoBreve: string;

  @Column({ type: 'nvarchar', length: 'MAX', nullable: true })
  CodigoEjemplo: string;

  @Column({ type: 'int' })
  Orden: number;

  @Column({ type: 'bit', default: true })
  Activo: boolean;

  @CreateDateColumn({ type: 'datetime' })
  FechaCreacion: Date;

  @OneToMany(() => Practica, (practica) => practica.Leccion)
  Practicas: Practica[];
}

