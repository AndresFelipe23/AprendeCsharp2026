import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  ManyToOne,
  OneToMany,
  OneToOne,
  JoinColumn,
} from 'typeorm';
import { Leccion } from './leccion.entity';
import { PracticaOpcion } from './practica-opcion.entity';
import { PracticaBloque } from './practica-bloque.entity';
import { PracticaCodigo } from './practica-codigo.entity';

@Entity('Practicas')
export class Practica {
  @PrimaryGeneratedColumn()
  PracticaId: number;

  @Column({ type: 'int' })
  LeccionId: number;

  @ManyToOne(() => Leccion, (leccion) => leccion.Practicas)
  @JoinColumn({ name: 'LeccionId' })
  Leccion: Leccion;

  @Column({ type: 'nvarchar', length: 50 })
  TipoEjercicio: 'MultipleChoice' | 'CompletarCodigo' | 'EscribirCodigo';

  @Column({ type: 'nvarchar', length: 150 })
  Titulo: string;

  @Column({ type: 'nvarchar', length: 'MAX' })
  Enunciado: string;

  @Column({ type: 'int' })
  Orden: number;

  @Column({ type: 'bit', default: true })
  Activo: boolean;

  @CreateDateColumn({ type: 'datetime' })
  FechaCreacion: Date;

  // Relaciones con tablas específicas según el tipo
  @OneToMany(() => PracticaOpcion, (opcion) => opcion.Practica, {
    cascade: true,
  })
  Opciones?: PracticaOpcion[];

  @OneToMany(() => PracticaBloque, (bloque) => bloque.Practica, {
    cascade: true,
  })
  Bloques?: PracticaBloque[];

  @OneToOne(() => PracticaCodigo, (codigo) => codigo.Practica, {
    cascade: true,
  })
  Codigo?: PracticaCodigo | null;
}

