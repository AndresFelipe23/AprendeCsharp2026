-- ============================================
-- VERIFICAR EJERCICIO DE LECCIÓN 1
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que la lección 1 existe
SELECT 
    LeccionId,
    Titulo,
    CursoId,
    Activo
FROM Lecciones
WHERE LeccionId = 1;
GO

-- Verificar prácticas de la lección 1
SELECT 
    p.PracticaId,
    p.LeccionId,
    p.TipoEjercicio,
    p.Titulo,
    p.Enunciado,
    p.Orden,
    p.Activo,
    p.FechaCreacion
FROM Practicas p
WHERE p.LeccionId = 1
ORDER BY p.Orden;
GO

-- Verificar opciones de las prácticas de la lección 1
SELECT 
    po.OpcionId,
    po.PracticaId,
    po.TextoOpcion,
    po.EsCorrecta,
    po.Orden,
    po.Explicacion,
    p.Titulo AS PracticaTitulo
FROM PracticaOpciones po
INNER JOIN Practicas p ON po.PracticaId = p.PracticaId
WHERE p.LeccionId = 1
ORDER BY po.PracticaId, po.Orden;
GO

-- Contar prácticas por lección
SELECT 
    l.LeccionId,
    l.Titulo AS LeccionTitulo,
    COUNT(p.PracticaId) AS NumPracticas,
    SUM(CASE WHEN p.Activo = 1 THEN 1 ELSE 0 END) AS PracticasActivas
FROM Lecciones l
LEFT JOIN Practicas p ON l.LeccionId = p.LeccionId
WHERE l.LeccionId = 1
GROUP BY l.LeccionId, l.Titulo;
GO

