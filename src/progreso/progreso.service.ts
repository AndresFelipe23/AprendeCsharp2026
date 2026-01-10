import {
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository, InjectDataSource } from '@nestjs/typeorm';
import { Repository, In, DataSource } from 'typeorm';
import { ProgresoLeccion } from '../entities/progreso-leccion.entity';
import { ProgresoPractica } from '../entities/progreso-practica.entity';
import { Leccion } from '../entities/leccion.entity';
import { Usuario } from '../entities/usuario.entity';
import { Ruta } from '../entities/ruta.entity';
import { Curso } from '../entities/curso.entity';
import { EstadisticasUsuarioDto } from './dto/estadisticas-usuario.dto';
import { ProgresoRutaDto } from './dto/progreso-ruta.dto';
import { ProgresoCursoDto } from './dto/progreso-curso.dto';

@Injectable()
export class ProgresoService {
  constructor(
    @InjectRepository(ProgresoLeccion)
    private progresoLeccionRepository: Repository<ProgresoLeccion>,
    @InjectRepository(ProgresoPractica)
    private progresoPracticaRepository: Repository<ProgresoPractica>,
    @InjectRepository(Leccion)
    private leccionRepository: Repository<Leccion>,
    @InjectRepository(Usuario)
    private usuarioRepository: Repository<Usuario>,
    @InjectRepository(Ruta)
    private rutaRepository: Repository<Ruta>,
    @InjectRepository(Curso)
    private cursoRepository: Repository<Curso>,
    @InjectDataSource()
    private dataSource: DataSource,
  ) {}

  /**
   * Calcula el nivel del usuario basado en sus puntos totales
   * Fórmula: Nivel 1 (0-99 puntos), Nivel 2 (100-199), Nivel 3 (200-299), etc.
   * @param puntosTotales Puntos totales del usuario
   * @returns Nivel calculado (mínimo 1)
   */
  private calcularNivel(puntosTotales: number): number {
    if (puntosTotales <= 0) {
      return 1;
    }
    // Cada 100 puntos aumenta un nivel
    // 0-99 = Nivel 1, 100-199 = Nivel 2, 200-299 = Nivel 3, etc.
    return Math.floor(puntosTotales / 100) + 1;
  }

  /**
   * Actualiza los puntos y nivel del usuario
   * @param usuarioId ID del usuario
   * @param puntosAgregar Puntos a agregar (puede ser negativo)
   * @returns Usuario actualizado con nuevos puntos y nivel
   */
  private async actualizarPuntosYNivel(
    usuarioId: number,
    puntosAgregar: number,
  ): Promise<Usuario | null> {
    const usuario = await this.usuarioRepository.findOne({
      where: { UsuarioId: usuarioId },
    });

    if (!usuario) {
      return null;
    }

    // Actualizar puntos totales
    usuario.PuntosTotales = (usuario.PuntosTotales || 0) + puntosAgregar;
    
    // Asegurar que no sea negativo
    if (usuario.PuntosTotales < 0) {
      usuario.PuntosTotales = 0;
    }

    // Calcular y actualizar nivel
    usuario.Nivel = this.calcularNivel(usuario.PuntosTotales);

    return await this.usuarioRepository.save(usuario);
  }

  async marcarLeccionCompletada(
    usuarioId: number,
    leccionId: number,
  ): Promise<ProgresoLeccion> {
    // Verificar que la lección existe
    const leccion = await this.leccionRepository.findOne({
      where: { LeccionId: leccionId },
    });

    if (!leccion) {
      throw new NotFoundException(`Lección con ID ${leccionId} no encontrada`);
    }

    // Buscar o crear progreso
    let progreso = await this.progresoLeccionRepository.findOne({
      where: {
        UsuarioId: usuarioId,
        LeccionId: leccionId,
      },
    });

    if (!progreso) {
      progreso = this.progresoLeccionRepository.create({
        UsuarioId: usuarioId,
        LeccionId: leccionId,
        Completada: false,
        FechaUltimoAcceso: new Date(),
      });
    }

    // Verificar si es la primera vez que se completa
    const esPrimeraVez = !progreso.Completada;
    const PUNTOS_POR_LECCION = 10;

    // Marcar como completada si no lo está
    if (esPrimeraVez) {
      progreso.Completada = true;
      progreso.FechaCompletacion = new Date();
      
      // Otorgar puntos y actualizar nivel solo la primera vez
      await this.actualizarPuntosYNivel(usuarioId, PUNTOS_POR_LECCION);
    }

    progreso.FechaUltimoAcceso = new Date();

    return this.progresoLeccionRepository.save(progreso);
  }

  async actualizarUltimoAcceso(
    usuarioId: number,
    leccionId: number,
  ): Promise<ProgresoLeccion> {
    // Buscar o crear progreso
    let progreso = await this.progresoLeccionRepository.findOne({
      where: {
        UsuarioId: usuarioId,
        LeccionId: leccionId,
      },
    });

    if (!progreso) {
      progreso = this.progresoLeccionRepository.create({
        UsuarioId: usuarioId,
        LeccionId: leccionId,
        Completada: false,
        FechaUltimoAcceso: new Date(),
      });
    } else {
      progreso.FechaUltimoAcceso = new Date();
    }

    return this.progresoLeccionRepository.save(progreso);
  }

  async obtenerProgresoLeccion(
    usuarioId: number,
    leccionId: number,
  ): Promise<ProgresoLeccion | null> {
    return this.progresoLeccionRepository.findOne({
      where: {
        UsuarioId: usuarioId,
        LeccionId: leccionId,
      },
      relations: ['Leccion'],
    });
  }

  async obtenerLeccionesCompletadas(
    usuarioId: number,
  ): Promise<number[]> {
    if (!usuarioId || isNaN(usuarioId)) {
      console.warn('obtenerLeccionesCompletadas: usuarioId inválido:', usuarioId);
      return [];
    }

    try {
      const progresos = await this.progresoLeccionRepository.find({
        where: {
          UsuarioId: usuarioId,
          Completada: true,
        },
        select: ['LeccionId'],
      });

      const leccionIds = progresos.map((p) => p.LeccionId).filter((id) => id != null);
      console.log(`obtenerLeccionesCompletadas: Usuario ${usuarioId} tiene ${leccionIds.length} lecciones completadas:`, leccionIds);
      return leccionIds;
    } catch (error) {
      console.error('Error al obtener lecciones completadas:', error);
      return [];
    }
  }

  async obtenerEstadisticasUsuario(
    usuarioId: number,
  ): Promise<EstadisticasUsuarioDto> {
    const usuario = await this.usuarioRepository.findOne({
      where: { UsuarioId: usuarioId },
    });

    if (!usuario) {
      throw new NotFoundException('Usuario no encontrado');
    }

    const leccionesCompletadas = await this.progresoLeccionRepository.count({
      where: {
        UsuarioId: usuarioId,
        Completada: true,
      },
    });

    // TODO: Agregar conteo de prácticas y retos cuando se implementen
    const practicasCompletadas = 0;
    const retosCompletados = 0;

    return {
      leccionesCompletadas,
      practicasCompletadas,
      retosCompletados,
      puntosTotales: usuario.PuntosTotales,
      nivel: usuario.Nivel,
    };
  }

  async obtenerProgresoRutas(
    usuarioId: number,
  ): Promise<ProgresoRutaDto[]> {
    const rutas = await this.rutaRepository.find({
      where: { Activo: true },
      order: { Orden: 'ASC' },
      relations: ['Cursos'],
    });

    const progresoRutas: ProgresoRutaDto[] = [];

    for (const ruta of rutas) {
      const cursos = await this.cursoRepository.find({
        where: { RutaId: ruta.RutaId, Activo: true },
      });

      // Contar cursos completados (un curso está completado si todas sus lecciones están completadas)
      let cursosCompletados = 0;
      for (const curso of cursos) {
        const lecciones = await this.leccionRepository.find({
          where: { CursoId: curso.CursoId, Activo: true },
        });

        if (lecciones.length === 0) continue;

        const leccionesIds = lecciones.map((l) => l.LeccionId);
        const leccionesCompletadas = leccionesIds.length > 0
          ? await this.progresoLeccionRepository.count({
              where: {
                UsuarioId: usuarioId,
                Completada: true,
                LeccionId: In(leccionesIds),
              },
            })
          : 0;

        if (leccionesCompletadas === lecciones.length) {
          cursosCompletados++;
        }
      }

      const totalCursos = cursos.length;
      const porcentajeCompletado =
        totalCursos > 0 ? (cursosCompletados / totalCursos) * 100 : 0;

      progresoRutas.push({
        rutaId: ruta.RutaId,
        nombre: ruta.Nombre,
        porcentajeCompletado: Math.round(porcentajeCompletado * 100) / 100,
        cursosCompletados,
        totalCursos,
      });
    }

    return progresoRutas;
  }

  async obtenerProgresoCursos(
    usuarioId: number,
  ): Promise<ProgresoCursoDto[]> {
    const cursos = await this.cursoRepository.find({
      where: { Activo: true },
      relations: ['Ruta'],
      order: { Orden: 'ASC' },
    });

    const progresoCursos: ProgresoCursoDto[] = [];

    for (const curso of cursos) {
      const lecciones = await this.leccionRepository.find({
        where: { CursoId: curso.CursoId, Activo: true },
      });

      const leccionesIds = lecciones.map((l) => l.LeccionId);
      const leccionesCompletadas = leccionesIds.length > 0
        ? await this.progresoLeccionRepository.count({
            where: {
              UsuarioId: usuarioId,
              Completada: true,
              LeccionId: In(leccionesIds),
            },
          })
        : 0;

      const totalLecciones = lecciones.length;
      // TODO: Agregar conteo de prácticas cuando se implementen
      const practicasCompletadas = 0;
      const totalPracticas = 0;

      const porcentajeLecciones =
        totalLecciones > 0
          ? (leccionesCompletadas / totalLecciones) * 100
          : 0;

      progresoCursos.push({
        cursoId: curso.CursoId,
        nombre: curso.Nombre,
        rutaId: curso.RutaId,
        rutaNombre: curso.Ruta?.Nombre || '',
        porcentajeCompletado: Math.round(porcentajeLecciones * 100) / 100,
        leccionesCompletadas,
        totalLecciones,
        practicasCompletadas,
        totalPracticas,
      });
    }

    return progresoCursos;
  }

  async obtenerProgresoPractica(
    usuarioId: number,
    practicaId: number,
  ): Promise<ProgresoPractica | null> {
    return this.progresoPracticaRepository.findOne({
      where: {
        UsuarioId: usuarioId,
        PracticaId: practicaId,
      },
      relations: ['Practica'],
    });
  }

  // Obtener progreso completo del usuario (implementación optimizada sin procedimiento almacenado)
  async obtenerProgresoCompleto(usuarioId: number): Promise<any> {
    try {
      console.log('Obteniendo progreso completo optimizado para usuarioId:', usuarioId);
      
      // Ejecutar todas las consultas en paralelo para máxima velocidad
      const [
        usuario,
        leccionesCompletadas,
        practicasCompletadas,
        retosCompletados,
        progresoRutasData,
        progresoCursosData,
      ] = await Promise.all([
        // Estadísticas del usuario
        this.usuarioRepository.findOne({
          where: { UsuarioId: usuarioId },
          select: ['PuntosTotales', 'Nivel'],
        }),
        
        // Contar lecciones completadas
        this.progresoLeccionRepository.count({
          where: { UsuarioId: usuarioId, Completada: true },
        }),
        
        // Contar prácticas completadas
        this.progresoPracticaRepository.count({
          where: { UsuarioId: usuarioId, Completada: true },
        }),
        
        // Contar retos completados - por ahora retornar 0 ya que no hay tabla ProgresoRetos implementada aún
        Promise.resolve([{ count: 0 }]),
        
        // Progreso de rutas (query optimizada)
        this.obtenerProgresoRutas(usuarioId),
        
        // Progreso de cursos (query optimizada)
        this.obtenerProgresoCursos(usuarioId),
      ]);

      // Obtener retos completados del resultado
      const retosCount = retosCompletados?.[0]?.count || 0;

      // Construir respuesta consolidada
      return {
        estadisticas: {
          leccionesCompletadas: leccionesCompletadas || 0,
          practicasCompletadas: practicasCompletadas || 0,
          retosCompletados: retosCount,
          puntosTotales: usuario?.PuntosTotales || 0,
          nivel: usuario?.Nivel || 1,
        },
        progresoRutas: progresoRutasData || [],
        progresoCursos: progresoCursosData || [],
      };
    } catch (error) {
      console.error('Error al obtener progreso completo:', error);
      throw error;
    }
  }
}

