-- ============================================
-- EJERCICIOS: break y continue
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "break y continue" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionBreakContinue') IS NOT NULL
    DROP TABLE #LeccionBreakContinue;

CREATE TABLE #LeccionBreakContinue (LeccionId INT NOT NULL);

INSERT INTO #LeccionBreakContinue (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'break y continue'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionBreakContinue)
BEGIN
    PRINT 'ERROR: No se encontró la lección "break y continue".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (break y continue)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 4
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'Uso de break',
N'¿Qué sucede cuando se ejecuta break dentro de un bucle?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Se reinicia el bucle desde cero', 0, 1, N'Incorrecto. break no reinicia iteraciones.'),
(@PracticaId1, N'Se salta solo la siguiente iteración', 0, 2, N'Incorrecto. Eso describe más a continue.'),
(@PracticaId1, N'Convierte el bucle en infinito', 0, 3, N'Incorrecto. break ayuda a salir del bucle.'),
(@PracticaId1, N'Se termina inmediatamente el bucle actual', 1, 4, N'Correcto. break corta la ejecución del bucle más interno.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 1
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Uso de continue',
N'¿Qué hace continue dentro de un bucle?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Salta el resto de la iteración actual y pasa a la siguiente', 1, 1, N'Correcto. continue no sale del bucle, solo omite parte de la vuelta actual.'),
(@PracticaId2, N'Termina por completo el método', 0, 2, N'Incorrecto. Eso lo hace return.'),
(@PracticaId2, N'Detiene definitivamente todos los bucles anidados', 0, 3, N'Incorrecto. continue afecta el bucle actual.'),
(@PracticaId2, N'Obliga a ejecutar el bloque else', 0, 4, N'Incorrecto. No está relacionado con if-else directamente.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'break al encontrar valor',
N'Completa para detener el for cuando i sea igual a 4.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'for ([BLOQUE_1] [BLOQUE_2] = [BLOQUE_3]; [BLOQUE_4] <= [BLOQUE_5]; [BLOQUE_6]++)' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    if ([BLOQUE_7] == [BLOQUE_8])' + CHAR(13) + CHAR(10)
    + N'    {' + CHAR(13) + CHAR(10)
    + N'        [BLOQUE_9];' + CHAR(13) + CHAR(10)
    + N'    }' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_10]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'i', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'1', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'i', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'10', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'i', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'i', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'4', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'break', 9, 0),
(@PracticaId3, @CodigoBase3, 10, N'i', 10, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 11, N'continue', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'while', 0, 1),
(@PracticaId3, @CodigoBase3, 13, N'0', 0, 1),
(@PracticaId3, @CodigoBase3, 14, N'j', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'continue para filtrar pares',
N'Completa para imprimir solo números impares del 1 al 6.',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'for ([BLOQUE_1] [BLOQUE_2] = [BLOQUE_3]; [BLOQUE_4] <= [BLOQUE_5]; [BLOQUE_6]++)' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    if ([BLOQUE_7] % [BLOQUE_8] == [BLOQUE_9])' + CHAR(13) + CHAR(10)
    + N'    {' + CHAR(13) + CHAR(10)
    + N'        [BLOQUE_10];' + CHAR(13) + CHAR(10)
    + N'    }' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_11]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'i', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'1', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'i', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'6', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'i', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'i', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'2', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'0', 9, 0),
(@PracticaId4, @CodigoBase4, 10, N'continue', 10, 0),
(@PracticaId4, @CodigoBase4, 11, N'i', 11, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 12, N'break', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'while', 0, 1),
(@PracticaId4, @CodigoBase4, 14, N'10', 0, 1),
(@PracticaId4, @CodigoBase4, 15, N'j', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'break en búsqueda',
N'Escribe estas declaraciones:
for (int i = 1; i <= 10; i++)
{
    if (i == 6)
    {
        break;
    }
    Console.WriteLine(i);
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
N'for (int i = 1; i <= 10; i++)
{
    if (i == 6)
    {
        break;
    }
    Console.WriteLine(i);
}',
N'[ { "test": "break-busqueda", "expected": "validado por el servidor" } ]',
N'Cuando i sea 6, usa break para salir del bucle.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'continue para filtrar',
N'Escribe estas declaraciones:
for (int i = 1; i <= 5; i++)
{
    if (i == 3)
    {
        continue;
    }
    Console.WriteLine(i);
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
N'for (int i = 1; i <= 5; i++)
{
    if (i == 3)
    {
        continue;
    }
    Console.WriteLine(i);
}',
N'[ { "test": "continue-filtrar", "expected": "validado por el servidor" } ]',
N'Con continue se omite la iteración actual sin salir del bucle.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBreakContinue);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (break y continue)');
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

IF OBJECT_ID('tempdb..#LeccionBreakContinue') IS NOT NULL
    DROP TABLE #LeccionBreakContinue;
GO
