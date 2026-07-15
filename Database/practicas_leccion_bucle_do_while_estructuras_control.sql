-- ============================================
-- EJERCICIOS: Bucle do-while
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Bucle do-while" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionBucleDoWhile') IS NOT NULL
    DROP TABLE #LeccionBucleDoWhile;

CREATE TABLE #LeccionBucleDoWhile (LeccionId INT NOT NULL);

INSERT INTO #LeccionBucleDoWhile (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Bucle do-while'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionBucleDoWhile)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Bucle do-while".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Bucle do-while)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 1
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'Diferencia entre while y do-while',
N'¿Cuál es la diferencia principal del do-while frente al while?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'En do-while, el bloque se ejecuta al menos una vez', 1, 1, N'Correcto. La condición se evalúa después de la primera ejecución.'),
(@PracticaId1, N'do-while solo funciona con bool y while no', 0, 2, N'Incorrecto. Ambos usan condiciones booleanas.'),
(@PracticaId1, N'while siempre se ejecuta al menos una vez y do-while puede no ejecutarse', 0, 3, N'Incorrecto. Es exactamente al revés.'),
(@PracticaId1, N'No hay ninguna diferencia entre ambos', 0, 4, N'Incorrecto. Sí cambia el momento de evaluación de la condición.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 4
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Cuándo usar do-while',
N'¿En cuál escenario do-while suele ser una buena elección?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Cuando nunca quieres ejecutar el bloque', 0, 1, N'Incorrecto. do-while ejecuta el bloque al menos una vez.'),
(@PracticaId2, N'Cuando no deseas validar condiciones', 0, 2, N'Incorrecto. Siempre hay condición en while/do-while.'),
(@PracticaId2, N'Cuando necesitas reemplazar todos los for automáticamente', 0, 3, N'Incorrecto. Cada bucle tiene casos de uso.'),
(@PracticaId2, N'Cuando el flujo debe ejecutarse primero y validar después (ej. menús)', 1, 4, N'Correcto. Es ideal para menús/validaciones con al menos un intento.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'do-while básico',
N'Completa para imprimir 1, 2 y 3 usando do-while.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'do' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_3]);' + CHAR(13) + CHAR(10)
    + N'    [BLOQUE_4]++;' + CHAR(13) + CHAR(10)
    + N'} while ([BLOQUE_5] <= [BLOQUE_6]);';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'i', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'1', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'i', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'i', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'i', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'3', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 7, N'for', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'while', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'0', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'continue', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'Menú con salida',
N'Completa do-while para repetir mientras opcion sea diferente de 0.',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'do' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_3]);' + CHAR(13) + CHAR(10)
    + N'    [BLOQUE_4] = [BLOQUE_5];' + CHAR(13) + CHAR(10)
    + N'} while ([BLOQUE_6] != [BLOQUE_7]);';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'opcion', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'-1', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'"Menú..."', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'opcion', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'0', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'opcion', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'0', 7, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 8, N'if', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'1', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'break', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'switch', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Conteo con do-while',
N'Escribe estas declaraciones:
int contador = 1;
do
{
    Console.WriteLine(contador);
    contador++;
} while (contador <= 3);',
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
N'int contador = 1;
do
{
    Console.WriteLine(contador);
    contador++;
} while (contador <= 3);',
N'[ { "test": "do-while-conteo", "expected": "validado por el servidor" } ]',
N'Recuerda que la condición en do-while va al final.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Validación simple',
N'Escribe estas declaraciones:
int valor = 0;
do
{
    valor++;
} while (valor < 2);
Console.WriteLine(valor);',
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
N'int valor = 0;
do
{
    valor++;
} while (valor < 2);
Console.WriteLine(valor);',
N'[ { "test": "do-while-validacion", "expected": "validado por el servidor" } ]',
N'Primero se ejecuta el bloque y luego se valida la condición.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleDoWhile);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Bucle do-while)');
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

IF OBJECT_ID('tempdb..#LeccionBucleDoWhile') IS NOT NULL
    DROP TABLE #LeccionBucleDoWhile;
GO
