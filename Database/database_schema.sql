-- ============================================
-- ESTRUCTURA DE BASE DE DATOS PARA APP DE APRENDIZAJE C#
-- ============================================

CREATE DATABASE LenguajeCsharp
GO

USE LenguajeCsharp
GO

-- Tabla: Rutas
CREATE TABLE Rutas (
    RutaId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    DescripcionCorta NVARCHAR(255) NULL,
    Orden INT NOT NULL,
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- Tabla: Cursos
CREATE TABLE Cursos (
    CursoId INT IDENTITY(1,1) PRIMARY KEY,
    RutaId INT NOT NULL FOREIGN KEY REFERENCES Rutas(RutaId),
    Nombre NVARCHAR(100) NOT NULL,
    DescripcionCorta NVARCHAR(255) NULL,
    Orden INT NOT NULL,
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- Tabla: Lecciones
CREATE TABLE Lecciones (
    LeccionId INT IDENTITY(1,1) PRIMARY KEY,
    CursoId INT NOT NULL FOREIGN KEY REFERENCES Cursos(CursoId),
    Titulo NVARCHAR(150) NOT NULL,
    DescripcionCorta NVARCHAR(255) NULL,
    ContenidoBreve NVARCHAR(MAX) NULL,
    CodigoEjemplo NVARCHAR(MAX) NULL,
    Orden INT NOT NULL,
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE()
);
GO

-- ============================================
-- TABLAS PARA PRÁCTICAS/EJERCICIOS
-- ============================================

-- Tabla: Practicas (Tabla principal)
-- TipoEjercicio: 'MultipleChoice', 'CompletarCodigo', 'EscribirCodigo'
CREATE TABLE Practicas (
    PracticaId INT IDENTITY(1,1) PRIMARY KEY,
    LeccionId INT NOT NULL FOREIGN KEY REFERENCES Lecciones(LeccionId),
    TipoEjercicio NVARCHAR(50) NOT NULL CHECK (TipoEjercicio IN ('MultipleChoice', 'CompletarCodigo', 'EscribirCodigo')),
    Titulo NVARCHAR(150) NOT NULL,
    Enunciado NVARCHAR(MAX) NOT NULL,
    Orden INT NOT NULL,
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- Tabla: PracticaOpciones (Para ejercicios de respuesta múltiple)
CREATE TABLE PracticaOpciones (
    OpcionId INT IDENTITY(1,1) PRIMARY KEY,
    PracticaId INT NOT NULL FOREIGN KEY REFERENCES Practicas(PracticaId) ON DELETE CASCADE,
    TextoOpcion NVARCHAR(500) NOT NULL,
    EsCorrecta BIT NOT NULL DEFAULT 0,
    Orden INT NOT NULL,
    Explicacion NVARCHAR(MAX) NULL -- Explicación cuando se selecciona esta opción
);

-- Tabla: PracticaBloques (Para ejercicios tipo Duolingo - completar código con bloques)
CREATE TABLE PracticaBloques (
    BloqueId INT IDENTITY(1,1) PRIMARY KEY,
    PracticaId INT NOT NULL FOREIGN KEY REFERENCES Practicas(PracticaId) ON DELETE CASCADE,
    CodigoBase NVARCHAR(MAX) NOT NULL, -- Código con marcadores [BLOQUE_1], [BLOQUE_2], etc.
    OrdenBloque INT NOT NULL, -- Orden en que deben aparecer los bloques
    TextoBloque NVARCHAR(500) NOT NULL, -- Texto que se muestra en el bloque arrastrable
    PosicionCorrecta INT NOT NULL, -- Posición correcta en el código (1, 2, 3...)
    EsDistractor BIT DEFAULT 0 -- Si es un bloque falso/distractor
);

-- Tabla: PracticaCodigo (Para ejercicios de escribir código)
CREATE TABLE PracticaCodigo (
    PracticaCodigoId INT IDENTITY(1,1) PRIMARY KEY,
    PracticaId INT NOT NULL FOREIGN KEY REFERENCES Practicas(PracticaId) ON DELETE CASCADE,
    CodigoBase NVARCHAR(MAX) NULL, -- Código inicial (puede estar vacío o tener estructura)
    SolucionEsperada NVARCHAR(MAX) NOT NULL, -- Código solución completo
    CasosPrueba NVARCHAR(MAX) NULL, -- JSON con casos de prueba: [{"input": "...", "output": "..."}]
    PistaOpcional NVARCHAR(MAX) NULL
);
GO

-- ============================================
-- TABLAS PARA RETOS
-- ============================================

CREATE TABLE Retos (
    RetoId INT IDENTITY(1,1) PRIMARY KEY,
    CursoId INT NOT NULL FOREIGN KEY REFERENCES Cursos(CursoId),
    TipoEjercicio NVARCHAR(50) NOT NULL CHECK (TipoEjercicio IN ('MultipleChoice', 'CompletarCodigo', 'EscribirCodigo')),
    Titulo NVARCHAR(150) NOT NULL,
    Enunciado NVARCHAR(MAX) NOT NULL,
    PistaOpcional NVARCHAR(MAX) NULL,
    SolucionEjemplo NVARCHAR(MAX) NULL,
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- Tabla: RetoOpciones (Para retos de respuesta múltiple)
CREATE TABLE RetoOpciones (
    OpcionId INT IDENTITY(1,1) PRIMARY KEY,
    RetoId INT NOT NULL FOREIGN KEY REFERENCES Retos(RetoId) ON DELETE CASCADE,
    TextoOpcion NVARCHAR(500) NOT NULL,
    EsCorrecta BIT NOT NULL DEFAULT 0,
    Orden INT NOT NULL,
    Explicacion NVARCHAR(MAX) NULL
);

-- Tabla: RetoBloques (Para retos tipo Duolingo)
CREATE TABLE RetoBloques (
    BloqueId INT IDENTITY(1,1) PRIMARY KEY,
    RetoId INT NOT NULL FOREIGN KEY REFERENCES Retos(RetoId) ON DELETE CASCADE,
    CodigoBase NVARCHAR(MAX) NOT NULL,
    OrdenBloque INT NOT NULL,
    TextoBloque NVARCHAR(500) NOT NULL,
    PosicionCorrecta INT NOT NULL,
    EsDistractor BIT DEFAULT 0
);

-- Tabla: RetoCodigo (Para retos de escribir código)
CREATE TABLE RetoCodigo (
    RetoCodigoId INT IDENTITY(1,1) PRIMARY KEY,
    RetoId INT NOT NULL FOREIGN KEY REFERENCES Retos(RetoId) ON DELETE CASCADE,
    CodigoBase NVARCHAR(MAX) NULL,
    SolucionEsperada NVARCHAR(MAX) NOT NULL,
    CasosPrueba NVARCHAR(MAX) NULL,
    PistaOpcional NVARCHAR(MAX) NULL
);
GO

-- ============================================
-- TABLAS DE USUARIOS Y PROGRESO
-- ============================================

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    UsuarioId INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsuario NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    ContrasenaHash NVARCHAR(255) NULL, -- NULL si usas autenticación externa (Google, Apple, etc.)
    NombreCompleto NVARCHAR(100) NULL,
    FotoPerfilUrl NVARCHAR(500) NULL,
    PuntosTotales INT DEFAULT 0,
    Nivel INT DEFAULT 1, -- Nivel del usuario basado en puntos/experiencia
    FechaRegistro DATETIMEOFFSET NOT NULL,
    UltimaConexion DATETIMEOFFSET NOT NULL,
    Activo BIT DEFAULT 1
);

-- Tabla: ProgresoLecciones (Rastrea qué lecciones ha completado cada usuario)
CREATE TABLE ProgresoLecciones (
    ProgresoLeccionId INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioId INT NOT NULL FOREIGN KEY REFERENCES Usuarios(UsuarioId) ON DELETE CASCADE,
    LeccionId INT NOT NULL FOREIGN KEY REFERENCES Lecciones(LeccionId),
    Completada BIT DEFAULT 0,
    FechaCompletacion DATETIME NULL,
    FechaUltimoAcceso DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_UsuarioLeccion UNIQUE (UsuarioId, LeccionId)
);

-- Tabla: ProgresoPracticas (Rastrea el progreso en prácticas/ejercicios)
CREATE TABLE ProgresoPracticas (
    ProgresoPracticaId INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioId INT NOT NULL FOREIGN KEY REFERENCES Usuarios(UsuarioId) ON DELETE CASCADE,
    PracticaId INT NOT NULL FOREIGN KEY REFERENCES Practicas(PracticaId),
    Completada BIT DEFAULT 0,
    Intentos INT DEFAULT 0,
    CorrectoEnPrimerIntento BIT DEFAULT 0,
    PuntosObtenidos INT DEFAULT 0,
    RespuestaUsuario NVARCHAR(MAX) NULL, -- Guarda la respuesta del usuario (opcional)
    FechaCompletacion DATETIME NULL,
    FechaUltimoIntento DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_UsuarioPractica UNIQUE (UsuarioId, PracticaId)
);

-- Tabla: ProgresoRetos (Rastrea el progreso en retos)
CREATE TABLE ProgresoRetos (
    ProgresoRetoId INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioId INT NOT NULL FOREIGN KEY REFERENCES Usuarios(UsuarioId) ON DELETE CASCADE,
    RetoId INT NOT NULL FOREIGN KEY REFERENCES Retos(RetoId),
    Completado BIT DEFAULT 0,
    Intentos INT DEFAULT 0,
    CorrectoEnPrimerIntento BIT DEFAULT 0,
    PuntosObtenidos INT DEFAULT 0,
    RespuestaUsuario NVARCHAR(MAX) NULL,
    FechaCompletacion DATETIME NULL,
    FechaUltimoIntento DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_UsuarioReto UNIQUE (UsuarioId, RetoId)
);

-- Tabla: ProgresoCursos (Rastrea el progreso general de cada curso)
CREATE TABLE ProgresoCursos (
    ProgresoCursoId INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioId INT NOT NULL FOREIGN KEY REFERENCES Usuarios(UsuarioId) ON DELETE CASCADE,
    CursoId INT NOT NULL FOREIGN KEY REFERENCES Cursos(CursoId),
    PorcentajeCompletado DECIMAL(5,2) DEFAULT 0.00, -- 0.00 a 100.00
    LeccionesCompletadas INT DEFAULT 0,
    TotalLecciones INT DEFAULT 0,
    PracticasCompletadas INT DEFAULT 0,
    TotalPracticas INT DEFAULT 0,
    RetosCompletados INT DEFAULT 0,
    TotalRetos INT DEFAULT 0,
    FechaInicio DATETIME DEFAULT GETDATE(),
    FechaCompletacion DATETIME NULL,
    CONSTRAINT UQ_UsuarioCurso UNIQUE (UsuarioId, CursoId)
);

-- Tabla: ProgresoRutas (Rastrea el progreso general de cada ruta)
CREATE TABLE ProgresoRutas (
    ProgresoRutaId INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioId INT NOT NULL FOREIGN KEY REFERENCES Usuarios(UsuarioId) ON DELETE CASCADE,
    RutaId INT NOT NULL FOREIGN KEY REFERENCES Rutas(RutaId),
    PorcentajeCompletado DECIMAL(5,2) DEFAULT 0.00, -- 0.00 a 100.00
    CursosCompletados INT DEFAULT 0,
    TotalCursos INT DEFAULT 0,
    FechaInicio DATETIME DEFAULT GETDATE(),
    FechaCompletacion DATETIME NULL,
    CONSTRAINT UQ_UsuarioRuta UNIQUE (UsuarioId, RutaId)
);
GO

-- ============================================
-- ÍNDICES PARA MEJOR RENDIMIENTO
-- ============================================

CREATE INDEX IX_Cursos_RutaId ON Cursos(RutaId);
CREATE INDEX IX_Lecciones_CursoId ON Lecciones(CursoId);
CREATE INDEX IX_Practicas_LeccionId ON Practicas(LeccionId);
CREATE INDEX IX_Practicas_TipoEjercicio ON Practicas(TipoEjercicio);
CREATE INDEX IX_PracticaOpciones_PracticaId ON PracticaOpciones(PracticaId);
CREATE INDEX IX_PracticaBloques_PracticaId ON PracticaBloques(PracticaId);
CREATE INDEX IX_PracticaCodigo_PracticaId ON PracticaCodigo(PracticaId);
CREATE INDEX IX_Retos_CursoId ON Retos(CursoId);
CREATE INDEX IX_RetoOpciones_RetoId ON RetoOpciones(RetoId);
CREATE INDEX IX_RetoBloques_RetoId ON RetoBloques(RetoId);
CREATE INDEX IX_RetoCodigo_RetoId ON RetoCodigo(RetoId);

-- Índices para tablas de usuarios y progreso
CREATE INDEX IX_Usuarios_Email ON Usuarios(Email);
CREATE INDEX IX_Usuarios_NombreUsuario ON Usuarios(NombreUsuario);
CREATE INDEX IX_ProgresoLecciones_UsuarioId ON ProgresoLecciones(UsuarioId);
CREATE INDEX IX_ProgresoLecciones_LeccionId ON ProgresoLecciones(LeccionId);
CREATE INDEX IX_ProgresoPracticas_UsuarioId ON ProgresoPracticas(UsuarioId);
CREATE INDEX IX_ProgresoPracticas_PracticaId ON ProgresoPracticas(PracticaId);
CREATE INDEX IX_ProgresoRetos_UsuarioId ON ProgresoRetos(UsuarioId);
CREATE INDEX IX_ProgresoRetos_RetoId ON ProgresoRetos(RetoId);
CREATE INDEX IX_ProgresoCursos_UsuarioId ON ProgresoCursos(UsuarioId);
CREATE INDEX IX_ProgresoCursos_CursoId ON ProgresoCursos(CursoId);
CREATE INDEX IX_ProgresoRutas_UsuarioId ON ProgresoRutas(UsuarioId);
CREATE INDEX IX_ProgresoRutas_RutaId ON ProgresoRutas(RutaId);
GO
