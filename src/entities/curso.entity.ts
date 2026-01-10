import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  ManyToOne,
  OneToMany,
  JoinColumn,
} from 'typeorm';
import { Ruta } from './ruta.entity';
import { Leccion } from './leccion.entity';

@Entity('Cursos')
export class Curso {
  @PrimaryGeneratedColumn()
  CursoId: number;

  @Column({ type: 'int' })
  RutaId: number;

  @ManyToOne(() => Ruta, (ruta) => ruta.Cursos)
  @JoinColumn({ name: 'RutaId' })
  Ruta: Ruta;

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

  @OneToMany(() => Leccion, (leccion) => leccion.Curso)
  Lecciones: Leccion[];
}

