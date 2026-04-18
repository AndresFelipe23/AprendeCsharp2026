-- ============================================
-- EJERCICIOS: Tipos de datos numéricos decimales
-- Lección: "Tipos de datos numéricos decimales" (CursoId = 1, Orden 3 en insert_lecciones_variables.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo (como lección enteros)
-- ============================================
-- Ejecutar en una sola vez en SSMS (la tabla #LeccionDecimales cruza los lotes GO).
-- Requisito: exista la lección insertada con insert_lecciones_variables.sql (o equivalente).
-- No ejecutes dos veces seguidas: duplicaría prácticas. Si ya corriste el script, borra esas Practicas o ajusta Orden.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionDecimales') IS NOT NULL
    DROP TABLE #LeccionDecimales;

CREATE TABLE #LeccionDecimales (LeccionId INT NOT NULL);

INSERT INTO #LeccionDecimales (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 1
  AND l.Titulo = N'Tipos de datos numéricos decimales'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionDecimales)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Tipos de datos numéricos decimales" en CursoId 1.';
    PRINT 'Ejecuta primero insert_lecciones_variables.sql o revisa el título en la tabla Lecciones.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
PRINT 'Prácticas se asociarán a LeccionId = ' + CAST(@Lid AS VARCHAR(10));
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Dinero / finanzas
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'¿Qué tipo usarías para el precio de un producto en una tienda?',
'Elige el tipo más adecuado en C# para representar dinero con precisión y evitar errores de redondeo habituales en float o double:',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;
PRINT 'Ejercicio 1 (MultipleChoice) PracticaId: ' + CAST(@PracticaId1 AS VARCHAR);

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, 'decimal', 1, 1, 'Correcto. decimal ofrece alta precisión (28-29 dígitos) y es el tipo recomendado para cantidades monetarias en C#.'),
(@PracticaId1, 'double', 0, 2, 'Incorrecto. double es binario en coma flotante y puede acumular errores de redondeo; no es ideal para dinero.'),
(@PracticaId1, 'float', 0, 3, 'Incorrecto. float tiene aún menos precisión que double; no es apropiado para dinero.'),
(@PracticaId1, 'int', 0, 4, 'Incorrecto. int no almacena decimales; no sirve para precios con centavos.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Sufijos literales
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Literal correcto para un float en C#',
'¿Cuál de estas asignaciones usa el sufijo adecuado para el tipo float?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, 'float x = 3.14f;', 1, 1, 'Correcto. Los literales float deben llevar el sufijo f o F.'),
(@PracticaId2, 'float x = 3.14;', 0, 2, 'Incorrecto. Sin sufijo, 3.14 se interpreta como double, no como float.'),
(@PracticaId2, 'float x = 3.14m;', 0, 3, 'Incorrecto. El sufijo m corresponde a decimal, no a float.'),
(@PracticaId2, 'float x = 3.14L;', 0, 4, 'Incorrecto. L es el sufijo típico para long, no para float.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — float, double, decimal
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Declara float, double y decimal',
'Completa las tres líneas: altura en float (1.75f), temperatura en double (36.5) y precio en decimal (19.99m):',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + '[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + '[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, 'float', 1, 0),
(@PracticaId3, @CodigoBase3, 2, 'altura', 2, 0),
(@PracticaId3, @CodigoBase3, 3, '1.75f', 3, 0),
(@PracticaId3, @CodigoBase3, 4, 'double', 4, 0),
(@PracticaId3, @CodigoBase3, 5, 'temperatura', 5, 0),
(@PracticaId3, @CodigoBase3, 6, '36.5', 6, 0),
(@PracticaId3, @CodigoBase3, 7, 'decimal', 7, 0),
(@PracticaId3, @CodigoBase3, 8, 'precio', 8, 0),
(@PracticaId3, @CodigoBase3, 9, '19.99m', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 10, 'int', 0, 1),
(@PracticaId3, @CodigoBase3, 11, '19.99', 0, 1),
(@PracticaId3, @CodigoBase3, 12, '1.75', 0, 1),
(@PracticaId3, @CodigoBase3, 13, 'string', 0, 1),
(@PracticaId3, @CodigoBase3, 14, '36.5f', 0, 1),
(@PracticaId3, @CodigoBase3, 15, 'bool', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — Multiplicación con decimales
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Precio, cantidad y total',
'Completa: precio decimal 9.99m, cantidad entera 3, y total decimal = precio * cantidad (usa decimal para el total):',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + '[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + '[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9] * [BLOQUE_10];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, 'decimal', 1, 0),
(@PracticaId4, @CodigoBase4, 2, 'precio', 2, 0),
(@PracticaId4, @CodigoBase4, 3, '9.99m', 3, 0),
(@PracticaId4, @CodigoBase4, 4, 'int', 4, 0),
(@PracticaId4, @CodigoBase4, 5, 'cantidad', 5, 0),
(@PracticaId4, @CodigoBase4, 6, '3', 6, 0),
(@PracticaId4, @CodigoBase4, 7, 'decimal', 7, 0),
(@PracticaId4, @CodigoBase4, 8, 'total', 8, 0),
(@PracticaId4, @CodigoBase4, 9, 'precio', 9, 0),
(@PracticaId4, @CodigoBase4, 10, 'cantidad', 10, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 11, 'double', 0, 1),
(@PracticaId4, @CodigoBase4, 12, 'float', 0, 1),
(@PracticaId4, @CodigoBase4, 13, '9.99', 0, 1),
(@PracticaId4, @CodigoBase4, 14, '3.0', 0, 1),
(@PracticaId4, @CodigoBase4, 15, 'subtotal', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — Tres declaraciones
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Declara float, double y decimal',
'Escribe solo las declaraciones (con punto y coma al final):
1) float llamado radio con valor 2.5f
2) double llamado pi con valor 3.14159
3) decimal llamado saldo con valor 100.00m',
5,
1);

SELECT @PracticaId5 = PracticaId FROM @TempTable5;

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId5,
'using System;

class Program
{
    static void Main()
    {
        // Escribe tus declaraciones aquí
    }
}',
'float radio = 2.5f;
double pi = 3.14159;
decimal saldo = 100.00m;',
'[
  { "test": "Tres declaraciones numéricas decimales", "expected": "validado por el servidor" }
]',
'Recuerda: sufijo f para float, sin sufijo para double literal, sufijo m para decimal.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Suma con double
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Suma de dos double',
'Escribe declaraciones que:
1) double a = 1.25;
2) double b = 2.75;
3) double suma = a + b;
(Solo declaraciones con tipo explícito double, terminadas en ;)',
6,
1);

SELECT @PracticaId6 = PracticaId FROM @TempTable6;

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId6,
'using System;

class Program
{
    static void Main()
    {
        // Tu código
    }
}',
'double a = 1.25;
double b = 2.75;
double suma = a + b;',
'[
  { "test": "Suma double", "expected": "validado por el servidor" }
]',
'Usa el mismo nombre de variables: a, b y suma.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecimales);

PRINT '========================================';
PRINT 'Ejercicios insertados para LeccionId ' + CAST(@LeccionId AS VARCHAR(10));
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

PRINT 'Total: 6 ejercicios (2 MC, 2 completar, 2 escribir).';
GO

IF OBJECT_ID('tempdb..#LeccionDecimales') IS NOT NULL
    DROP TABLE #LeccionDecimales;
GO
