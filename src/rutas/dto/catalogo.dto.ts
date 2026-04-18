import { ApiProperty } from '@nestjs/swagger';

/** Lección para listados (sin ContenidoBreve ni CodigoEjemplo). */
export class CatalogoLeccionDto {
  @ApiProperty({ example: 1 })
  LeccionId: number;

  @ApiProperty({ example: 1 })
  CursoId: number;

  @ApiProperty({ example: 'Introducción a variables' })
  Titulo: string;

  @ApiProperty({
    example: 'Conceptos básicos',
    required: false,
    nullable: true,
  })
  DescripcionCorta: string | null;

  @ApiProperty({ example: 1 })
  Orden: number;

  @ApiProperty({ example: true })
  Activo: boolean;
}

export class CatalogoCursoDto {
  @ApiProperty({ example: 1 })
  CursoId: number;

  @ApiProperty({ example: 1 })
  RutaId: number;

  @ApiProperty({ example: 'C# básico' })
  Nombre: string;

  @ApiProperty({
    example: 'Fundamentos del lenguaje',
    required: false,
    nullable: true,
  })
  DescripcionCorta: string | null;

  @ApiProperty({ example: 1 })
  Orden: number;

  @ApiProperty({ example: true })
  Activo: boolean;

  @ApiProperty({ type: [CatalogoLeccionDto] })
  Lecciones: CatalogoLeccionDto[];
}

export class CatalogoRutaDto {
  @ApiProperty({ example: 1 })
  RutaId: number;

  @ApiProperty({ example: 'Ruta principal' })
  Nombre: string;

  @ApiProperty({
    example: 'Aprende desde cero',
    required: false,
    nullable: true,
  })
  DescripcionCorta: string | null;

  @ApiProperty({ example: 1 })
  Orden: number;

  @ApiProperty({ example: true })
  Activo: boolean;

  @ApiProperty({ type: [CatalogoCursoDto] })
  Cursos: CatalogoCursoDto[];
}
