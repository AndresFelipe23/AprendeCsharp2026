import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  OneToMany,
} from 'typeorm';
import { Curso } from './curso.entity';

@Entity('Rutas')
export class Ruta {
  @PrimaryGeneratedColumn()
  RutaId: number;

  @Column({ type: 'nvarchar', length: 100 })
  Nombre: string;

  @Column({ type: 'nvarchar', length: 255, nullable: true })
  DescripcionCorta: string;

  @Column({ type: 'int' })
  Orden: number;

  @Column({ type: 'bit', default: true })
  Activo: boolean;

  @CreateDateColumn({ type: 'datetime' })
  FechaCreacion: Date;

  @OneToMany(() => Curso, (curso) => curso.Ruta)
  Cursos: Curso[];
}

