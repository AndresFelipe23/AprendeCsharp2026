-- ============================================
-- EJERCICIOS: Bucles Anidados
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Bucles Anidados" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionBuclesAnidados') IS NOT NULL
    DROP TABLE #LeccionBuclesAnidados;

CREATE TABLE #LeccionBuclesAnidados (LeccionId INT NOT NULL);

INSERT INTO #LeccionBuclesAnidados (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Bucles Anidados'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionBuclesAnidados)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Bucles Anidados".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Bucles Anidados)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 2
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'Concepto de bucle anidado',
N'¿Qué es un bucle anidado?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Un bucle que siempre se ejecuta infinito', 0, 1, N'Incorrecto. Puede terminar según su condición.'),
(@PracticaId1, N'Un bucle dentro de otro bucle', 1, 2, N'Correcto. Por cada iteración externa, se ejecuta el interno.'),
(@PracticaId1, N'Un if dentro de un switch', 0, 3, N'Incorrecto. Eso no define anidación de bucles.'),
(@PracticaId1, N'Un bucle que solo usa continue', 0, 4, N'Incorrecto. continue no define si está anidado.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 3
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Cantidad de ejecuciones',
N'Si el bucle externo corre 3 veces y el interno 4 por cada vuelta, ¿cuántas iteraciones internas totales hay?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'7', 0, 1, N'Incorrecto. No se suman 3 + 4 para este caso.'),
(@PracticaId2, N'9', 0, 2, N'Incorrecto. La multiplicación correcta es 3 x 4.'),
(@PracticaId2, N'12', 1, 3, N'Correcto. El interno se ejecuta 4 veces por cada una de las 3 externas.'),
(@PracticaId2, N'16', 0, 4, N'Incorrecto. 16 correspondería a 4 x 4.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'Bucle doble básico',
N'Completa dos bucles for anidados para imprimir pares i-j desde 1 hasta 2.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'for ([BLOQUE_1] [BLOQUE_2] = [BLOQUE_3]; [BLOQUE_4] <= [BLOQUE_5]; [BLOQUE_6]++)' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    for ([BLOQUE_7] [BLOQUE_8] = [BLOQUE_9]; [BLOQUE_10] <= [BLOQUE_11]; [BLOQUE_12]++)' + CHAR(13) + CHAR(10)
    + N'    {' + CHAR(13) + CHAR(10)
    + N'        Console.WriteLine([BLOQUE_13] + "-" + [BLOQUE_14]);' + CHAR(13) + CHAR(10)
    + N'    }' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'i', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'1', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'i', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'2', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'i', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'int', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'j', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'1', 9, 0),
(@PracticaId3, @CodigoBase3, 10, N'j', 10, 0),
(@PracticaId3, @CodigoBase3, 11, N'2', 11, 0),
(@PracticaId3, @CodigoBase3, 12, N'j', 12, 0),
(@PracticaId3, @CodigoBase3, 13, N'i', 13, 0),
(@PracticaId3, @CodigoBase3, 14, N'j', 14, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 15, N'while', 0, 1),
(@PracticaId3, @CodigoBase3, 16, N'k', 0, 1),
(@PracticaId3, @CodigoBase3, 17, N'0', 0, 1),
(@PracticaId3, @CodigoBase3, 18, N'break', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'Tabla simple 2x3',
N'Completa bucles anidados para imprimir multiplicaciones de i por j (i:1..2, j:1..3).',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'for ([BLOQUE_1] [BLOQUE_2] = [BLOQUE_3]; [BLOQUE_4] <= [BLOQUE_5]; [BLOQUE_6]++)' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    for ([BLOQUE_7] [BLOQUE_8] = [BLOQUE_9]; [BLOQUE_10] <= [BLOQUE_11]; [BLOQUE_12]++)' + CHAR(13) + CHAR(10)
    + N'    {' + CHAR(13) + CHAR(10)
    + N'        Console.WriteLine([BLOQUE_13] * [BLOQUE_14]);' + CHAR(13) + CHAR(10)
    + N'    }' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'i', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'1', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'i', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'2', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'i', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'int', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'j', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'1', 9, 0),
(@PracticaId4, @CodigoBase4, 10, N'j', 10, 0),
(@PracticaId4, @CodigoBase4, 11, N'3', 11, 0),
(@PracticaId4, @CodigoBase4, 12, N'j', 12, 0),
(@PracticaId4, @CodigoBase4, 13, N'i', 13, 0),
(@PracticaId4, @CodigoBase4, 14, N'j', 14, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 15, N'if', 0, 1),
(@PracticaId4, @CodigoBase4, 16, N'continue', 0, 1),
(@PracticaId4, @CodigoBase4, 17, N'4', 0, 1),
(@PracticaId4, @CodigoBase4, 18, N'x', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Coordenadas 2x2',
N'Escribe estas declaraciones:
for (int i = 1; i <= 2; i++)
{
    for (int j = 1; j <= 2; j++)
    {
        Console.WriteLine($"({i},{j})");
    }
}',
5,
1);

SELECT @PracticaId5 = PracticaId FROM @TempTable5;

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId5,
N'using System;

class Program
{
    static void Main()
    {
        // Tu código aquí
    }
}',
N'for (int i = 1; i <= 2; i++)
{
    for (int j = 1; j <= 2; j++)
    {
        Console.WriteLine($"({i},{j})");
    }
}',
N'[ { "test": "anidados-coordenadas", "expected": "validado por el servidor" } ]',
N'Recuerda abrir el segundo for dentro del bloque del primero.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Suma por filas',
N'Escribe estas declaraciones:
for (int fila = 1; fila <= 2; fila++)
{
    int sumaFila = 0;
    for (int col = 1; col <= 3; col++)
    {
        sumaFila += col;
    }
    Console.WriteLine(sumaFila);
}',
6,
1);

SELECT @PracticaId6 = PracticaId FROM @TempTable6;

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId6,
N'using System;

class Program
{
    static void Main()
    {
        // Tu código aquí
    }
}',
N'for (int fila = 1; fila <= 2; fila++)
{
    int sumaFila = 0;
    for (int col = 1; col <= 3; col++)
    {
        sumaFila += col;
    }
    Console.WriteLine(sumaFila);
}',
N'[ { "test": "anidados-suma-filas", "expected": "validado por el servidor" } ]',
N'Puedes declarar una variable acumuladora dentro del bucle externo.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBuclesAnidados);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Bucles Anidados)');
PRINT '========================================';

SELECT
    p.PracticaId,
    p.TipoEjercicio,
    p.Titulo,
    p.Orden,
    CASE
        WHEN p.TipoEjercicio = 'MultipleChoice' THEN (SELECT COUNT(*) FROM PracticaOpciones WHERE PracticaId = p.PracticaId)
        WHEN p.TipoEjercicio = 'CompletarCodigo' THEN (SELECT COUNT(*) FROM PracticaBloques WHERE PracticaId = p.PracticaId)
        WHEN p.TipoEjercicio = 'EscribirCodigo' THEN 1
        ELSE 0
    END AS ElementosAsociados
FROM Practicas p
WHERE p.LeccionId = @LeccionId
ORDER BY p.Orden;

PRINT N'Total esperado: 6 ejercicios (2 MC, 2 completar, 2 escribir).';
GO

IF OBJECT_ID('tempdb..#LeccionBuclesAnidados') IS NOT NULL
    DROP TABLE #LeccionBuclesAnidados;
GO
