import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In } from 'typeorm';
import { Practica } from '../entities/practica.entity';
import { PracticaOpcion } from '../entities/practica-opcion.entity';
import { PracticaBloque } from '../entities/practica-bloque.entity';
import { PracticaCodigo } from '../entities/practica-codigo.entity';
import { Leccion } from '../entities/leccion.entity';
import { ProgresoPractica } from '../entities/progreso-practica.entity';
import { Usuario } from '../entities/usuario.entity';
import { CreatePracticaDto } from './dto/create-practica.dto';
import { UpdatePracticaDto } from './dto/update-practica.dto';
import {
  ValidarRespuestaDto,
  RespuestaValidacionDto,
} from './dto/validar-respuesta.dto';

@Injectable()
export class PracticasService {
  constructor(
    @InjectRepository(Practica)
    private practicaRepository: Repository<Practica>,
    @InjectRepository(PracticaOpcion)
    private practicaOpcionRepository: Repository<PracticaOpcion>,
    @InjectRepository(PracticaBloque)
    private practicaBloqueRepository: Repository<PracticaBloque>,
    @InjectRepository(PracticaCodigo)
    private practicaCodigoRepository: Repository<PracticaCodigo>,
    @InjectRepository(Leccion)
    private leccionRepository: Repository<Leccion>,
    @InjectRepository(ProgresoPractica)
    private progresoPracticaRepository: Repository<ProgresoPractica>,
    @InjectRepository(Usuario)
    private usuarioRepository: Repository<Usuario>,
  ) {}

  async findAllByLeccion(
    leccionId: number,
    includeInactive = false,
  ): Promise<Practica[]> {
    console.log(`🔍 Buscando prácticas para LeccionId: ${leccionId}, includeInactive: ${includeInactive}`);

    // Usar query builder para más control y logging
    const queryBuilder = this.practicaRepository
      .createQueryBuilder('practica')
      .where('practica.LeccionId = :leccionId', { leccionId });

    if (!includeInactive) {
      queryBuilder.andWhere('practica.Activo = :activo', { activo: true });
    }

    queryBuilder.orderBy('practica.Orden', 'ASC');

    const sql = queryBuilder.getSql();
    const parameters = queryBuilder.getParameters();
    console.log(`📋 SQL Query: ${sql}`);
    console.log(`📋 Parameters:`, parameters);

    const practicas = await queryBuilder.getMany();

    console.log(`✅ Prácticas encontradas: ${practicas.length}`);
    if (practicas.length > 0) {
      console.log(`📝 Primera práctica:`, {
        PracticaId: practicas[0].PracticaId,
        LeccionId: practicas[0].LeccionId,
        Titulo: practicas[0].Titulo,
        TipoEjercicio: practicas[0].TipoEjercicio,
        Activo: practicas[0].Activo,
      });
    } else {
      // Verificar si hay prácticas en la BD con una consulta directa
      const count = await this.practicaRepository
        .createQueryBuilder('practica')
        .where('practica.LeccionId = :leccionId', { leccionId })
        .getCount();
      console.log(`⚠️ Total de prácticas en BD para LeccionId ${leccionId}: ${count}`);
    }

    return practicas;
  }

  async findAllWithLeccionAndCurso(): Promise<Practica[]> {
    return this.practicaRepository.find({
      where: { Activo: true },
      relations: ['Leccion', 'Leccion.Curso', 'Leccion.Curso.Ruta'],
      order: {
        TipoEjercicio: 'ASC',
        Orden: 'ASC',
      },
    });
  }

  async findOne(id: number): Promise<Practica> {
    const practica = await this.practicaRepository.findOne({
      where: { PracticaId: id },
      relations: ['Leccion'],
    });

    if (!practica) {
      throw new NotFoundException(`Práctica con ID ${id} no encontrada`);
    }

    // Cargar datos específicos según el tipo
    switch (practica.TipoEjercicio) {
      case 'MultipleChoice':
        practica.Opciones = await this.practicaOpcionRepository.find({
          where: { PracticaId: id },
          order: { Orden: 'ASC' },
        });
        break;

      case 'CompletarCodigo':
        practica.Bloques = await this.practicaBloqueRepository.find({
          where: { PracticaId: id },
          order: { OrdenBloque: 'ASC' },
        });
        break;

      case 'EscribirCodigo':
        practica.Codigo = await this.practicaCodigoRepository.findOne({
          where: { PracticaId: id },
        });
        break;
    }

    return practica;
  }

  async create(createPracticaDto: CreatePracticaDto): Promise<Practica> {
    // Verificar que la lección existe
    const leccion = await this.leccionRepository.findOne({
      where: { LeccionId: createPracticaDto.LeccionId },
    });

    if (!leccion) {
      throw new NotFoundException(
        `Lección con ID ${createPracticaDto.LeccionId} no encontrada`,
      );
    }

    // Validar que los datos específicos estén presentes según el tipo
    if (
      createPracticaDto.TipoEjercicio === 'MultipleChoice' &&
      (!createPracticaDto.Opciones || createPracticaDto.Opciones.length === 0)
    ) {
      throw new BadRequestException(
        'Las prácticas de respuesta múltiple deben tener al menos una opción',
      );
    }

    if (
      createPracticaDto.TipoEjercicio === 'CompletarCodigo' &&
      (!createPracticaDto.Bloques || createPracticaDto.Bloques.length === 0)
    ) {
      throw new BadRequestException(
        'Las prácticas de completar código deben tener al menos un bloque',
      );
    }

    if (
      createPracticaDto.TipoEjercicio === 'EscribirCodigo' &&
      !createPracticaDto.Codigo
    ) {
      throw new BadRequestException(
        'Las prácticas de escribir código deben tener datos de código',
      );
    }

    // Crear la práctica
    const practica = this.practicaRepository.create({
      LeccionId: createPracticaDto.LeccionId,
      TipoEjercicio: createPracticaDto.TipoEjercicio,
      Titulo: createPracticaDto.Titulo,
      Enunciado: createPracticaDto.Enunciado,
      Orden: createPracticaDto.Orden,
      Activo: true,
    });

    const practicaGuardada = await this.practicaRepository.save(practica);

    // Crear datos específicos según el tipo
    if (createPracticaDto.TipoEjercicio === 'MultipleChoice') {
      const opciones = createPracticaDto.Opciones!.map((opcion) =>
        this.practicaOpcionRepository.create({
          PracticaId: practicaGuardada.PracticaId,
          TextoOpcion: opcion.TextoOpcion,
          EsCorrecta: opcion.EsCorrecta,
          Orden: opcion.Orden,
          Explicacion: opcion.Explicacion || null,
        }),
      );
      await this.practicaOpcionRepository.save(opciones);
    }

    if (createPracticaDto.TipoEjercicio === 'CompletarCodigo') {
      const bloques = createPracticaDto.Bloques!.map((bloque) =>
        this.practicaBloqueRepository.create({
          PracticaId: practicaGuardada.PracticaId,
          CodigoBase: bloque.CodigoBase,
          OrdenBloque: bloque.OrdenBloque,
          TextoBloque: bloque.TextoBloque,
          PosicionCorrecta: bloque.PosicionCorrecta,
          EsDistractor: bloque.EsDistractor || false,
        }),
      );
      await this.practicaBloqueRepository.save(bloques);
    }

    if (createPracticaDto.TipoEjercicio === 'EscribirCodigo') {
      const codigo = this.practicaCodigoRepository.create({
        PracticaId: practicaGuardada.PracticaId,
        CodigoBase: createPracticaDto.Codigo!.CodigoBase || null,
        SolucionEsperada: createPracticaDto.Codigo!.SolucionEsperada,
        CasosPrueba: createPracticaDto.Codigo!.CasosPrueba || null,
        PistaOpcional: createPracticaDto.Codigo!.PistaOpcional || null,
      });
      await this.practicaCodigoRepository.save(codigo);
    }

    return this.findOne(practicaGuardada.PracticaId);
  }

  async update(
    id: number,
    updatePracticaDto: UpdatePracticaDto,
  ): Promise<Practica> {
    const practica = await this.findOne(id);

    // Actualizar campos básicos
    if (updatePracticaDto.Titulo !== undefined) {
      practica.Titulo = updatePracticaDto.Titulo;
    }
    if (updatePracticaDto.Enunciado !== undefined) {
      practica.Enunciado = updatePracticaDto.Enunciado;
    }
    if (updatePracticaDto.Orden !== undefined) {
      practica.Orden = updatePracticaDto.Orden;
    }
    if (updatePracticaDto.Activo !== undefined) {
      practica.Activo = updatePracticaDto.Activo;
    }

    await this.practicaRepository.save(practica);

    // Actualizar datos específicos si se proporcionan
    if (updatePracticaDto.Opciones) {
      // Eliminar opciones existentes y crear nuevas
      await this.practicaOpcionRepository.delete({ PracticaId: id });
      const opciones = updatePracticaDto.Opciones.map((opcion) =>
        this.practicaOpcionRepository.create({
          PracticaId: id,
          ...opcion,
        }),
      );
      await this.practicaOpcionRepository.save(opciones);
    }

    if (updatePracticaDto.Bloques) {
      await this.practicaBloqueRepository.delete({ PracticaId: id });
      const bloques = updatePracticaDto.Bloques.map((bloque) =>
        this.practicaBloqueRepository.create({
          PracticaId: id,
          ...bloque,
        }),
      );
      await this.practicaBloqueRepository.save(bloques);
    }

    if (updatePracticaDto.Codigo) {
      await this.practicaCodigoRepository.delete({ PracticaId: id });
      const codigo = this.practicaCodigoRepository.create({
        PracticaId: id,
        ...updatePracticaDto.Codigo,
      });
      await this.practicaCodigoRepository.save(codigo);
    }

    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    const practica = await this.findOne(id);
    practica.Activo = false;
    await this.practicaRepository.save(practica);
  }

  async validarRespuesta(
    id: number,
    validarRespuestaDto: ValidarRespuestaDto,
    usuarioId: number,
  ): Promise<RespuestaValidacionDto> {
    const practica = await this.findOne(id);
    let esCorrecta = false;
    let mensaje = '';
    let explicacion = '';
    let puntosObtenidos = 0;

    switch (practica.TipoEjercicio) {
      case 'MultipleChoice':
        if (!validarRespuestaDto.MultipleChoice) {
          throw new BadRequestException(
            'Se requiere respuesta para ejercicio de respuesta múltiple',
          );
        }

        const opcion = await this.practicaOpcionRepository.findOne({
          where: {
            PracticaId: id,
            OpcionId: validarRespuestaDto.MultipleChoice.OpcionId,
          },
        });

        if (!opcion) {
          throw new NotFoundException('Opción no encontrada');
        }

        esCorrecta = opcion.EsCorrecta;
        mensaje = esCorrecta ? '¡Correcto!' : 'Incorrecto';
        explicacion = opcion.Explicacion || '';
        puntosObtenidos = esCorrecta ? 10 : 0;
        break;

      case 'CompletarCodigo':
        if (!validarRespuestaDto.CompletarCodigo) {
          throw new BadRequestException(
            'Se requiere respuesta para ejercicio de completar código',
          );
        }

        const bloques = await this.practicaBloqueRepository.find({
          where: {
            PracticaId: id,
            EsDistractor: false,
          },
          order: { PosicionCorrecta: 'ASC' },
        });

        const bloquesCorrectos = bloques.map((b) => b.BloqueId);
        const bloquesUsuario = validarRespuestaDto.CompletarCodigo.BloquesOrden;

        // Verificar que los bloques no distractores estén en el orden correcto
        esCorrecta =
          bloquesCorrectos.length === bloquesUsuario.length &&
          bloquesCorrectos.every(
            (id, index) => id === bloquesUsuario[index],
          );

        mensaje = esCorrecta
          ? '¡Correcto! Has completado el código correctamente.'
          : 'Incorrecto. Revisa el orden de los bloques.';
        explicacion = esCorrecta
          ? 'Has ordenado los bloques correctamente.'
          : 'Verifica que los bloques estén en el orden correcto según el código esperado.';
        puntosObtenidos = esCorrecta ? 15 : 0;
        break;

      case 'EscribirCodigo':
        if (!validarRespuestaDto.EscribirCodigo) {
          throw new BadRequestException(
            'Se requiere respuesta para ejercicio de escribir código',
          );
        }

        const codigo = await this.practicaCodigoRepository.findOne({
          where: { PracticaId: id },
        });

        if (!codigo) {
          throw new NotFoundException('Datos de código no encontrados');
        }

        // Función para normalizar y extraer declaraciones de variables
        const extraerDeclaraciones = (codigoTexto: string): string[] => {
          // Remover comentarios de línea
          let sinComentarios = codigoTexto.replace(/\/\/.*/g, '');
          // Remover comentarios multilínea
          sinComentarios = sinComentarios.replace(/\/\*[\s\S]*?\*\//g, '');
          
          // Remover código base común (using, class, namespace, etc.)
          sinComentarios = sinComentarios
            .replace(/using\s+[\w.]+;?/gi, '') // Remover using statements
            .replace(/namespace\s+[\w.]+[^}]*\{/gi, '') // Remover namespace
            .replace(/class\s+\w+[^}]*\{/gi, '') // Remover class declaration
            .replace(/public\s+static\s+void\s+Main\s*\([^)]*\)\s*\{/gi, '') // Remover Main method
            .replace(/static\s+void\s+Main\s*\([^)]*\)\s*\{/gi, '') // Remover Main method sin public
            .replace(/void\s+Main\s*\([^)]*\)\s*\{/gi, '') // Remover Main method básico
            .replace(/[{}]/g, '') // Remover llaves
            .trim();

          // Dividir por punto y coma para obtener declaraciones individuales
          const posiblesDeclaraciones = sinComentarios
            .split(';')
            .map((linea) => linea.trim())
            .filter((linea) => linea.length > 0);

          // Filtrar y normalizar declaraciones válidas
          const declaraciones = posiblesDeclaraciones
            .filter((linea) => {
              // Ignorar líneas vacías o solo espacios
              if (!linea || linea.trim().length === 0) {
                return false;
              }

              // Ignorar palabras clave comunes que no son declaraciones
              const palabrasClave = [
                'using',
                'namespace',
                'class',
                'public',
                'private',
                'protected',
                'static',
                'void',
                'return',
                'if',
                'else',
                'for',
                'while',
                'foreach',
                'switch',
                'case',
                'break',
                'continue',
              ];
              
              const primeraPalabra = linea.split(/\s+/)[0]?.toLowerCase().trim();
              if (palabrasClave.includes(primeraPalabra)) {
                return false;
              }

              // Buscar patrones de declaración de variable
              // tipo nombre = valor (con o sin espacios extra)
              // Soporta: int edad = 25, string nombre="María", double precio=99.99
              const patronDeclaracion = /^(int|string|double|float|bool|char|byte|short|long|decimal|var)\s+\w+\s*=\s*.+/i;
              return patronDeclaracion.test(linea);
            })
            .map((declaracion) => {
              // Normalizar: quitar espacios extra, normalizar alrededor de =
              return declaracion
                .replace(/\s+/g, ' ') // Múltiples espacios a uno
                .replace(/\s*=\s*/g, ' = ') // Normalizar alrededor del =
                .trim();
            })
            .filter((d) => d.length > 0);

          return declaraciones;
        };

        // Extraer declaraciones de ambas partes
        const declaracionesUsuario = extraerDeclaraciones(
          validarRespuestaDto.EscribirCodigo.CodigoUsuario,
        );
        const declaracionesEsperadas = extraerDeclaraciones(
          codigo.SolucionEsperada,
        );

        // Comparar declaraciones (normalizadas y sin importar orden si hay múltiples)
        const normalizarParaComparacion = (decl: string): string => {
          return decl
            .toLowerCase()
            .replace(/\s+/g, ' ') // Normalizar espacios múltiples
            .replace(/\s*=\s*/g, ' = ') // Normalizar espacios alrededor de =
            .replace(/["']/g, '"') // Normalizar comillas simples a dobles
            .trim();
        };

        // Ordenar ambas listas para comparación independiente del orden
        const usuarioNormalizadas = declaracionesUsuario
          .map(normalizarParaComparacion)
          .sort();
        const esperadasNormalizadas = declaracionesEsperadas
          .map(normalizarParaComparacion)
          .sort();

        // Comparar si tienen la misma cantidad y contenido
        esCorrecta =
          usuarioNormalizadas.length === esperadasNormalizadas.length &&
          usuarioNormalizadas.every(
            (decl, index) => decl === esperadasNormalizadas[index],
          );

        // Mensaje más descriptivo
        if (esCorrecta) {
          mensaje = '¡Correcto! Tu código es correcto.';
          explicacion = 'Has escrito todas las declaraciones de variables correctamente.';
        } else {
          mensaje = 'Incorrecto. Revisa tu solución.';
          
          let detallesError = '';
          if (declaracionesUsuario.length !== declaracionesEsperadas.length) {
            detallesError = `Se esperaban ${declaracionesEsperadas.length} declaración(es), pero encontraste ${declaracionesUsuario.length}. `;
          } else {
            detallesError = 'Las declaraciones no coinciden exactamente. ';
          }

          explicacion =
            detallesError +
            (codigo.PistaOpcional ||
              'Asegúrate de escribir todas las variables con el tipo, nombre y valor correctos.');
        }

        puntosObtenidos = esCorrecta ? 20 : 0;
        break;

      default:
        throw new BadRequestException('Tipo de ejercicio no válido');
    }

    // Guardar la respuesta del usuario en formato JSON
    const respuestaUsuarioJson = JSON.stringify(validarRespuestaDto);

    // Buscar o crear progreso de práctica
    let progreso = await this.progresoPracticaRepository.findOne({
      where: {
        UsuarioId: usuarioId,
        PracticaId: id,
      },
    });

    const esPrimerIntento = !progreso || progreso.Intentos === 0;
    const intentosAnteriores = progreso?.Intentos || 0;
    const nuevoIntento = intentosAnteriores + 1;
    const puntosAnteriores = progreso?.PuntosObtenidos || 0;
    const esPrimeraVezCorrecto = esCorrecta && (esPrimerIntento || puntosAnteriores === 0);

    if (!progreso) {
      progreso = this.progresoPracticaRepository.create({
        UsuarioId: usuarioId,
        PracticaId: id,
        Intentos: nuevoIntento,
        CorrectoEnPrimerIntento: esCorrecta && esPrimerIntento,
        Completada: esCorrecta,
        PuntosObtenidos: puntosObtenidos,
        RespuestaUsuario: respuestaUsuarioJson,
        FechaUltimoIntento: new Date(),
        FechaCompletacion: esCorrecta ? new Date() : null,
      });
    } else {
      progreso.Intentos = nuevoIntento;
      progreso.FechaUltimoIntento = new Date();
      progreso.RespuestaUsuario = respuestaUsuarioJson;

      // Solo actualizar si es correcto y aún no estaba completada
      if (esCorrecta && !progreso.Completada) {
        progreso.Completada = true;
        progreso.FechaCompletacion = new Date();
        // Solo actualizar puntos si es la primera vez que completa correctamente
        if (puntosAnteriores === 0) {
          progreso.PuntosObtenidos = puntosObtenidos;
        }
      }

      // Marcar si fue correcto en el primer intento (solo si aún no estaba marcado)
      if (esPrimerIntento && esCorrecta && !progreso.CorrectoEnPrimerIntento) {
        progreso.CorrectoEnPrimerIntento = true;
      }
    }

    await this.progresoPracticaRepository.save(progreso);

    // Actualizar puntos totales y nivel del usuario solo si es correcto y es la primera vez
    if (esPrimeraVezCorrecto) {
      const usuario = await this.usuarioRepository.findOne({
        where: { UsuarioId: usuarioId },
      });

      if (usuario) {
        usuario.PuntosTotales = (usuario.PuntosTotales || 0) + puntosObtenidos;
        
        // Asegurar que no sea negativo
        if (usuario.PuntosTotales < 0) {
          usuario.PuntosTotales = 0;
        }

        // Calcular y actualizar nivel (cada 100 puntos aumenta un nivel)
        // 0-99 = Nivel 1, 100-199 = Nivel 2, 200-299 = Nivel 3, etc.
        usuario.Nivel = usuario.PuntosTotales <= 0 
          ? 1 
          : Math.floor(usuario.PuntosTotales / 100) + 1;

        await this.usuarioRepository.save(usuario);
      }
    }

    return {
      EsCorrecta: esCorrecta,
      Mensaje: mensaje,
      Explicacion: explicacion,
      PuntosObtenidos: puntosObtenidos,
    };
  }
}

