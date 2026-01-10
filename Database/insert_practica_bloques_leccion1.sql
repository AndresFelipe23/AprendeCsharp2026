-- ============================================
-- INSERTAR EJERCICIO DE TIPO BLOQUES (COMPLETAR CÓDIGO) PARA LECCIÓN 1
-- Lección: "¿Qué es una variable?"
-- Curso: "Variables y Tipos de Datos" (CursoId = 1)
-- Tipo: CompletarCodigo (bloques arrastrables)
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que la Lección 1 existe
IF NOT EXISTS (SELECT 1 FROM Lecciones WHERE LeccionId = 1)
BEGIN
    PRINT 'ERROR: La Lección con ID 1 no existe. Por favor ejecuta primero insert_lecciones_variables.sql';
    RETURN;
END
GO

-- Insertar ejercicio de tipo bloques sobre declaración de variables
-- Usamos una tabla temporal para obtener el ID insertado
DECLARE @PracticaId INT;
DECLARE @TempTable TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable
VALUES
(1, 
'CompletarCodigo', 
'Completa la declaración de variable',
'Arrastra los bloques para completar la declaración de una variable de tipo entero llamada "edad" con el valor 25:', 
2, 
1);

-- Obtener el ID de la práctica recién insertada
SELECT @PracticaId = PracticaId FROM @TempTable;

-- Verificar que obtuvimos el ID
IF @PracticaId IS NULL
BEGIN
    PRINT 'ERROR: No se pudo obtener el ID de la práctica insertada';
    RETURN;
END

PRINT 'Práctica insertada con ID: ' + CAST(@PracticaId AS VARCHAR);

-- Código base con marcadores para los bloques
-- [BLOQUE_1] = tipo de dato
-- [BLOQUE_2] = nombre de variable
-- [BLOQUE_3] = valor

DECLARE @CodigoBase NVARCHAR(MAX) = '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];';

-- Insertar bloques correctos (en el orden correcto)
-- Bloque 1: tipo de dato (int)
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId, @CodigoBase, 1, 'int', 1, 0);

-- Bloque 2: nombre de variable (edad)
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId, @CodigoBase, 2, 'edad', 2, 0);

-- Bloque 3: valor (25)
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId, @CodigoBase, 3, '25', 3, 0);

-- Insertar bloques distractores (incorrectos) para hacer el ejercicio más desafiante
-- Distractores para el tipo de dato
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId, @CodigoBase, 4, 'string', 0, 1),
(@PracticaId, @CodigoBase, 5, 'double', 0, 1),
(@PracticaId, @CodigoBase, 6, 'bool', 0, 1);

-- Distractores para el nombre de variable
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId, @CodigoBase, 7, 'nombre', 0, 1),
(@PracticaId, @CodigoBase, 8, 'precio', 0, 1),
(@PracticaId, @CodigoBase, 9, 'cantidad', 0, 1);

-- Distractores para el valor
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId, @CodigoBase, 10, '"María"', 0, 1),
(@PracticaId, @CodigoBase, 11, '99.99', 0, 1),
(@PracticaId, @CodigoBase, 12, 'true', 0, 1);

GO

-- Verificar el ejercicio insertado
SELECT 
    p.PracticaId,
    p.Titulo,
    p.TipoEjercicio,
    p.Enunciado,
    p.Orden,
    l.Titulo AS LeccionTitulo,
    COUNT(pb.BloqueId) AS NumBloques,
    SUM(CASE WHEN pb.EsDistractor = 0 THEN 1 ELSE 0 END) AS BloquesCorrectos,
    SUM(CASE WHEN pb.EsDistractor = 1 THEN 1 ELSE 0 END) AS BloquesDistractores
FROM Practicas p
INNER JOIN Lecciones l ON p.LeccionId = l.LeccionId
LEFT JOIN PracticaBloques pb ON p.PracticaId = pb.PracticaId
WHERE p.LeccionId = 1 AND p.TipoEjercicio = 'CompletarCodigo'
GROUP BY p.PracticaId, p.Titulo, p.TipoEjercicio, p.Enunciado, p.Orden, l.Titulo
ORDER BY p.Orden;
GO

-- Mostrar todos los bloques del ejercicio
SELECT 
    pb.BloqueId,
    pb.TextoBloque,
    pb.PosicionCorrecta,
    pb.OrdenBloque,
    pb.EsDistractor,
    pb.CodigoBase
FROM PracticaBloques pb
INNER JOIN Practicas p ON pb.PracticaId = p.PracticaId
WHERE p.LeccionId = 1 AND p.TipoEjercicio = 'CompletarCodigo' AND p.Orden = 2
ORDER BY pb.OrdenBloque;
GO

PRINT 'Ejercicio de tipo bloques insertado exitosamente para la Lección 1';
GO

