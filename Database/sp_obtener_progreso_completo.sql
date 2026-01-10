-- ============================================
-- PROCEDIMIENTO ALMACENADO: Obtener Progreso Completo del Usuario
-- Este procedimiento retorna toda la información de progreso en una sola llamada
-- Optimizado para la pantalla de progreso
-- ============================================

USE LenguajeCsharp
GO

CREATE OR ALTER PROCEDURE sp_obtener_progreso_completo
    @UsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el usuario exista
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE UsuarioId = @UsuarioId AND Activo = 1)
    BEGIN
        RAISERROR('Usuario no encontrado o inactivo', 16, 1);
        RETURN;
    END

    -- Declarar variables para estadísticas
    DECLARE @LeccionesCompletadas INT = 0;
    DECLARE @PracticasCompletadas INT = 0;
    DECLARE @RetosCompletados INT = 0;
    DECLARE @PuntosTotales INT = 0;
    DECLARE @Nivel INT = 1;

    -- Obtener estadísticas del usuario
    SELECT 
        @PuntosTotales = ISNULL(PuntosTotales, 0),
        @Nivel = ISNULL(Nivel, 1)
    FROM Usuarios
    WHERE UsuarioId = @UsuarioId;

    -- Contar lecciones completadas
    SELECT @LeccionesCompletadas = COUNT(*)
    FROM ProgresoLecciones
    WHERE UsuarioId = @UsuarioId AND Completada = 1;

    -- Contar prácticas completadas
    SELECT @PracticasCompletadas = COUNT(*)
    FROM ProgresoPracticas
    WHERE UsuarioId = @UsuarioId AND Completada = 1;

    -- Contar retos completados
    SELECT @RetosCompletados = COUNT(*)
    FROM ProgresoRetos
    WHERE UsuarioId = @UsuarioId AND Completado = 1;

    -- Retornar JSON completo con toda la información (como string único)
    DECLARE @ResultadoJSON NVARCHAR(MAX);
    
    SET @ResultadoJSON = (
        SELECT 
            -- Estadísticas del usuario
            (
                SELECT 
                    @LeccionesCompletadas AS leccionesCompletadas,
                    @PracticasCompletadas AS practicasCompletadas,
                    @RetosCompletados AS retosCompletados,
                    @PuntosTotales AS puntosTotales,
                    @Nivel AS nivel
                FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
            ) AS estadisticas,
            
            -- Progreso de rutas
            (
                SELECT 
                    r.RutaId AS rutaId,
                    r.Nombre AS nombre,
                    CAST(
                        CASE 
                            WHEN COUNT(DISTINCT c.CursoId) = 0 THEN 0.0
                            ELSE (COUNT(DISTINCT CASE WHEN pc.CursoId IS NOT NULL THEN c.CursoId END) * 100.0) / COUNT(DISTINCT c.CursoId)
                        END AS DECIMAL(5,2)
                    ) AS porcentajeCompletado,
                    COUNT(DISTINCT CASE WHEN pc.CursoId IS NOT NULL THEN c.CursoId END) AS cursosCompletados,
                    COUNT(DISTINCT c.CursoId) AS totalCursos
                FROM Rutas r
                LEFT JOIN Cursos c ON c.RutaId = r.RutaId AND c.Activo = 1
                LEFT JOIN (
                    -- Cursos completados (100% de lecciones completadas)
                    SELECT DISTINCT c.CursoId
                    FROM Cursos c
                    INNER JOIN Lecciones l ON l.CursoId = c.CursoId AND l.Activo = 1
                    LEFT JOIN ProgresoLecciones pl ON pl.LeccionId = l.LeccionId AND pl.UsuarioId = @UsuarioId AND pl.Completada = 1
                    WHERE c.Activo = 1
                    GROUP BY c.CursoId
                    HAVING COUNT(DISTINCT l.LeccionId) = COUNT(DISTINCT pl.LeccionId)
                        AND COUNT(DISTINCT l.LeccionId) > 0
                ) pc ON pc.CursoId = c.CursoId
                WHERE r.Activo = 1
                GROUP BY r.RutaId, r.Nombre, r.Orden
                ORDER BY r.Orden
                FOR JSON PATH
            ) AS progresoRutas,
            
            -- Progreso de cursos
            (
                SELECT 
                    c.CursoId AS cursoId,
                    c.Nombre AS nombre,
                    c.RutaId AS rutaId,
                    r.Nombre AS rutaNombre,
                    CAST(
                        CASE 
                            WHEN COUNT(DISTINCT l.LeccionId) = 0 THEN 0.0
                            ELSE (COUNT(DISTINCT CASE WHEN pl.Completada = 1 THEN l.LeccionId END) * 100.0) / COUNT(DISTINCT l.LeccionId)
                        END AS DECIMAL(5,2)
                    ) AS porcentajeCompletado,
                    COUNT(DISTINCT CASE WHEN pl.Completada = 1 THEN l.LeccionId END) AS leccionesCompletadas,
                    COUNT(DISTINCT l.LeccionId) AS totalLecciones,
                    COUNT(DISTINCT CASE WHEN pp.Completada = 1 THEN pr.PracticaId END) AS practicasCompletadas,
                    COUNT(DISTINCT pr.PracticaId) AS totalPracticas
                FROM Cursos c
                INNER JOIN Rutas r ON r.RutaId = c.RutaId
                LEFT JOIN Lecciones l ON l.CursoId = c.CursoId AND l.Activo = 1
                LEFT JOIN ProgresoLecciones pl ON pl.LeccionId = l.LeccionId AND pl.UsuarioId = @UsuarioId
                LEFT JOIN Practicas pr ON pr.LeccionId = l.LeccionId AND pr.Activo = 1
                LEFT JOIN ProgresoPracticas pp ON pp.PracticaId = pr.PracticaId AND pp.UsuarioId = @UsuarioId
                WHERE c.Activo = 1
                GROUP BY c.CursoId, c.Nombre, c.RutaId, r.Nombre, c.Orden
                ORDER BY c.Orden
                FOR JSON PATH
            ) AS progresoCursos
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );
    
    -- Retornar el JSON como resultado
    SELECT @ResultadoJSON AS resultado;
END
GO

-- ============================================
-- Ejemplo de uso:
-- EXEC sp_obtener_progreso_completo @UsuarioId = 1
-- ============================================

