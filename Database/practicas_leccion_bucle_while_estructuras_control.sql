-- ============================================
-- EJERCICIOS: Bucle while
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Bucle while" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionBucleWhile') IS NOT NULL
    DROP TABLE #LeccionBucleWhile;

CREATE TABLE #LeccionBucleWhile (LeccionId INT NOT NULL);

INSERT INTO #LeccionBucleWhile (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Bucle while'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionBucleWhile)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Bucle while".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Bucle while)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 2
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'¿Cómo funciona while?',
N'¿Cuál afirmación describe correctamente el comportamiento de while?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Siempre se ejecuta al menos una vez', 0, 1, N'Incorrecto. Eso corresponde a do-while.'),
(@PracticaId1, N'Evalúa la condición antes de cada iteración', 1, 2, N'Correcto. Si la condición es false al inicio, no entra al bucle.'),
(@PracticaId1, N'Solo puede usarse con variables string', 0, 3, N'Incorrecto. while usa expresiones booleanas.'),
(@PracticaId1, N'Reemplaza automáticamente cualquier for', 0, 4, N'Incorrecto. Son estructuras distintas para contextos distintos.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 3
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Evitar bucles infinitos',
N'¿Qué práctica ayuda a evitar un bucle while infinito?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Eliminar la condición del while', 0, 1, N'Incorrecto. Sin condición no hay control de salida.'),
(@PracticaId2, N'Usar siempre while(true) sin break', 0, 2, N'Incorrecto. Eso favorece loops infinitos.'),
(@PracticaId2, N'Actualizar dentro del bucle la variable que controla la condición', 1, 3, N'Correcto. Debe existir progreso hacia una condición false.'),
(@PracticaId2, N'Cambiar while por if sin más', 0, 4, N'Incorrecto. if no repite iteraciones.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'Contar del 1 al 4 con while',
N'Completa el código para imprimir los números del 1 al 4 usando while.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_3] ([BLOQUE_4] <= [BLOQUE_5])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_6]);' + CHAR(13) + CHAR(10)
    + N'    [BLOQUE_7]++;' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'contador', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'1', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'while', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'contador', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'4', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'contador', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'contador', 7, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 8, N'for', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'if', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'0', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'break', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'While con acumulador',
N'Completa para sumar 3 veces el valor de i empezando en 1.',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'int [BLOQUE_3] = [BLOQUE_4];' + CHAR(13) + CHAR(10)
    + N'while ([BLOQUE_5] <= [BLOQUE_6])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    [BLOQUE_7] += [BLOQUE_8];' + CHAR(13) + CHAR(10)
    + N'    [BLOQUE_9]++;' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'i', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'1', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'suma', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'0', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'i', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'3', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'suma', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'i', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'i', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 10, N'contador', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'5', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'switch', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'continue', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Conteo básico con while',
N'Escribe estas declaraciones:
int i = 1;
while (i <= 3)
{
    Console.WriteLine(i);
    i++;
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
N'int i = 1;
while (i <= 3)
{
    Console.WriteLine(i);
    i++;
}',
N'[ { "test": "while-conteo", "expected": "validado por el servidor" } ]',
N'No olvides incrementar i dentro del bucle.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'While con condición de búsqueda',
N'Escribe estas declaraciones:
int numero = 1;
while (numero < 5)
{
    numero++;
}
Console.WriteLine(numero);',
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
N'int numero = 1;
while (numero < 5)
{
    numero++;
}
Console.WriteLine(numero);',
N'[ { "test": "while-busqueda", "expected": "validado por el servidor" } ]',
N'Modifica la variable numero en cada iteración para alcanzar la condición de salida.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleWhile);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Bucle while)');
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

IF OBJECT_ID('tempdb..#LeccionBucleWhile') IS NOT NULL
    DROP TABLE #LeccionBucleWhile;
GO
