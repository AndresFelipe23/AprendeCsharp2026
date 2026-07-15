-- ============================================
-- EJERCICIOS: Estructura if-else
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Estructura if-else" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionIfElse') IS NOT NULL
    DROP TABLE #LeccionIfElse;

CREATE TABLE #LeccionIfElse (LeccionId INT NOT NULL);

INSERT INTO #LeccionIfElse (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Estructura if-else'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionIfElse)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Estructura if-else".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Estructura if-else)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'¿Cuándo se ejecuta else?',
N'El bloque else en un if-else se ejecuta cuando:',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'La condición del if es false', 1, 1, N'Correcto. else es la ruta alternativa cuando if no se cumple.'),
(@PracticaId1, N'La condición del if es true', 0, 2, N'Incorrecto. Si es true, se ejecuta el bloque if.'),
(@PracticaId1, N'Siempre, antes del if', 0, 3, N'Incorrecto. else depende del resultado del if.'),
(@PracticaId1, N'Solo si hay un for dentro del if', 0, 4, N'Incorrecto. No depende de bucles.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'if-else if-else',
N'¿Cuál es la ventaja principal de usar if-else if-else?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Permite evaluar múltiples condiciones en orden', 1, 1, N'Correcto. Se revisa cada condición hasta encontrar una verdadera.'),
(@PracticaId2, N'Ejecuta todos los bloques al mismo tiempo', 0, 2, N'Incorrecto. Solo se ejecuta un bloque.'),
(@PracticaId2, N'Reemplaza por completo a switch en todos los casos', 0, 3, N'Incorrecto. switch puede ser más claro en casos concretos.'),
(@PracticaId2, N'No necesita condiciones booleanas', 0, 4, N'Incorrecto. Las condiciones son obligatorias.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'if-else básico',
N'Completa para mostrar "Positivo" si numero > 0, de lo contrario "No positivo".',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] ([BLOQUE_5] > [BLOQUE_6])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_7]);' + CHAR(13) + CHAR(10)
    + N'}' + CHAR(13) + CHAR(10)
    + N'else' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_8]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'numero', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'-2', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'if', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'numero', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'0', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'"Positivo"', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'"No positivo"', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 9, N'while', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'==', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'"Cero"', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'bool', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'if-else if con rangos',
N'Completa para clasificar una nota: >= 90 "Excelente", >= 70 "Aprobado", si no "Reprobado".',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'if ([BLOQUE_3] >= [BLOQUE_4])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_5]);' + CHAR(13) + CHAR(10)
    + N'}' + CHAR(13) + CHAR(10)
    + N'else if ([BLOQUE_6] >= [BLOQUE_7])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_8]);' + CHAR(13) + CHAR(10)
    + N'}' + CHAR(13) + CHAR(10)
    + N'else' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_9]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'nota', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'75', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'nota', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'90', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'"Excelente"', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'nota', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'70', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'"Aprobado"', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'"Reprobado"', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 10, N'for', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'100', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'"Regular"', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'=', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Par o impar',
N'Escribe estas declaraciones:
int numero = 8;
if (numero % 2 == 0)
{
    Console.WriteLine("Par");
}
else
{
    Console.WriteLine("Impar");
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
N'int numero = 8;
if (numero % 2 == 0)
{
    Console.WriteLine("Par");
}
else
{
    Console.WriteLine("Impar");
}',
N'[ { "test": "par-impar", "expected": "validado por el servidor" } ]',
N'Usa el operador % para obtener el residuo y compara con 0.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Comparar dos números',
N'Escribe estas declaraciones:
int a = 10;
int b = 15;
if (a > b)
{
    Console.WriteLine("a es mayor");
}
else
{
    Console.WriteLine("b es mayor o igual");
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
N'int a = 10;
int b = 15;
if (a > b)
{
    Console.WriteLine("a es mayor");
}
else
{
    Console.WriteLine("b es mayor o igual");
}',
N'[ { "test": "comparacion-if-else", "expected": "validado por el servidor" } ]',
N'La condición debe estar en el if y el caso contrario en else.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIfElse);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Estructura if-else)');
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

IF OBJECT_ID('tempdb..#LeccionIfElse') IS NOT NULL
    DROP TABLE #LeccionIfElse;
GO
