-- ============================================
-- EJERCICIOS: Bucle for
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Bucle for" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionBucleFor') IS NOT NULL
    DROP TABLE #LeccionBucleFor;

CREATE TABLE #LeccionBucleFor (LeccionId INT NOT NULL);

INSERT INTO #LeccionBucleFor (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Bucle for'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionBucleFor)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Bucle for".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Bucle for)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 4
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'Partes del bucle for',
N'¿Qué componentes conforman la cabecera de un for en C#?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Solo condición y break', 0, 1, N'Incorrecto. break no forma parte de la cabecera del for.'),
(@PracticaId1, N'Variable y Console.WriteLine', 0, 2, N'Incorrecto. Console.WriteLine va en el cuerpo, no en la cabecera.'),
(@PracticaId1, N'Switch, case y default', 0, 3, N'Incorrecto. Eso corresponde a switch-case.'),
(@PracticaId1, N'Inicialización, condición e incremento/decremento', 1, 4, N'Correcto. Esa es la estructura clásica del for.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 1
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'¿Cuándo usar for?',
N'¿En qué situación suele ser más apropiado usar un bucle for?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Cuando conoces o controlas el número de iteraciones', 1, 1, N'Correcto. for es ideal para conteos definidos o iteración por índice.'),
(@PracticaId2, N'Cuando no quieres repetir código nunca', 0, 2, N'Incorrecto. Los bucles existen justamente para repetir.'),
(@PracticaId2, N'Cuando necesitas elegir entre muchos casos de texto', 0, 3, N'Incorrecto. Eso suele resolverse con switch.'),
(@PracticaId2, N'Cuando quieres salir de un método inmediatamente', 0, 4, N'Incorrecto. Para eso se usa return.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'Contar del 1 al 5',
N'Completa el bucle for para imprimir los números del 1 al 5.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] ([BLOQUE_2] [BLOQUE_3] = [BLOQUE_4]; [BLOQUE_5] <= [BLOQUE_6]; [BLOQUE_7]++)' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_8]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'for', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'int', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'i', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'1', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'i', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'5', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'i', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'i', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 9, N'if', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'j', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'0', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'break', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'Números pares',
N'Completa el for para imprimir números pares del 0 al 10.',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] ([BLOQUE_2] [BLOQUE_3] = [BLOQUE_4]; [BLOQUE_5] <= [BLOQUE_6]; [BLOQUE_7] += [BLOQUE_8])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_9]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'for', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'int', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'i', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'0', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'i', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'10', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'i', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'2', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'i', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 10, N'while', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'j', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'1', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'continue', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Sumar del 1 al 4',
N'Escribe estas declaraciones:
int suma = 0;
for (int i = 1; i <= 4; i++)
{
    suma += i;
}
Console.WriteLine(suma);',
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
N'int suma = 0;
for (int i = 1; i <= 4; i++)
{
    suma += i;
}
Console.WriteLine(suma);',
N'[ { "test": "for-suma", "expected": "validado por el servidor" } ]',
N'Inicializa suma en 0 y acumula dentro del bucle.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Conteo regresivo',
N'Escribe estas declaraciones:
for (int i = 5; i >= 1; i--)
{
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
N'for (int i = 5; i >= 1; i--)
{
    Console.WriteLine(i);
}',
N'[ { "test": "for-regresivo", "expected": "validado por el servidor" } ]',
N'Recuerda usar i-- para decrementar en cada iteración.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleFor);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Bucle for)');
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

IF OBJECT_ID('tempdb..#LeccionBucleFor') IS NOT NULL
    DROP TABLE #LeccionBucleFor;
GO
