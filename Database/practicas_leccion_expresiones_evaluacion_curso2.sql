-- ============================================
-- EJERCICIOS: Expresiones y Evaluación
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Expresiones y Evaluación" (Orden 8 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionExprEval cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionExprEval') IS NOT NULL
    DROP TABLE #LeccionExprEval;

CREATE TABLE #LeccionExprEval (LeccionId INT NOT NULL);

INSERT INTO #LeccionExprEval (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Expresiones y Evaluación'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionExprEval)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Expresiones y Evaluación" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Expresiones y Evaluación, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Qué es una expresión
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'Definición de expresión',
N'En C#, ¿qué describe mejor una expresión?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Una combinación de valores, variables y operadores que se evalúa y produce un resultado', 1, 1, N'Correcto. Toda expresión tiene un valor resultante (y un tipo asociado).'),
(@PracticaId1, N'Solo una variable declarada con un tipo', 0, 2, N'Incorrecto. La declaración no es lo mismo que una expresión completa.'),
(@PracticaId1, N'Solo un literal, sin operadores', 0, 3, N'Incorrecto. Un literal es una expresión muy simple, pero hay muchas más formas.'),
(@PracticaId1, N'Cualquier bloque de código entre llaves { }', 0, 4, N'Incorrecto. Las llaves delimitan bloques; una expresión es otra noción.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Tipos de expresiones
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Expresión booleana',
N'La expresión (edad >= 18 && edad < 65), con edad de tipo int, ¿qué tipo de resultado produce en C#?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'bool', 1, 1, N'Correcto. Las comparaciones y && producen un valor true o false.'),
(@PracticaId2, N'int', 0, 2, N'Incorrecto. Aunque edad es int, el resultado de la condición compuesta es bool.'),
(@PracticaId2, N'string', 0, 3, N'Incorrecto. No se obtiene texto a partir de esa expresión.'),
(@PracticaId2, N'double', 0, 4, N'Incorrecto. No hay división ni decimales forzados en esa expresión.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — Expresión aritmética (z = x + y * 2)
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Expresión aritmética',
N'Completa: int x = 5; int y = 10; int z = x + y * 2;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9] + [BLOQUE_10] * [BLOQUE_11];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'x', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'5', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'int', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'y', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'10', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'int', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'z', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'x', 9, 0),
(@PracticaId3, @CodigoBase3, 10, N'y', 10, 0),
(@PracticaId3, @CodigoBase3, 11, N'2', 11, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 12, N'x * y', 0, 1),
(@PracticaId3, @CodigoBase3, 13, N'bool', 0, 1),
(@PracticaId3, @CodigoBase3, 14, N'20', 0, 1),
(@PracticaId3, @CodigoBase3, 15, N'w', 0, 1),
(@PracticaId3, @CodigoBase3, 16, N'-', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — Expresión booleana
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Comparaciones y &&',
N'Completa: int edad = 20; bool activo = edad >= 18 && edad < 65;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'bool [BLOQUE_4] = [BLOQUE_5] >= [BLOQUE_6] && [BLOQUE_7] < [BLOQUE_8];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'edad', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'20', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'activo', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'edad', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'18', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'edad', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'65', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 9, N'||', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'==', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'mayor', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'17', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'int', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — Expresión en variable bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Rango numérico',
N'Escribe estas líneas:
int n = 15;
bool enRango = n > 10 && n < 20;',
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
        // Tu código
    }
}',
N'int n = 15;
bool enRango = n > 10 && n < 20;',
N'[ { "test": "expresión bool", "expected": "validado por el servidor" } ]',
N'La expresión completa se evalúa a un bool: true si ambas comparaciones se cumplen.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Operador condicional ? :
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Expresión condicional',
N'Escribe estas líneas:
int valor = 7;
string etiqueta = valor > 5 ? "Mayor" : "Menor o igual";',
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
        // Tu código
    }
}',
N'int valor = 7;
string etiqueta = valor > 5 ? "Mayor" : "Menor o igual";',
N'[ { "test": "ternario", "expected": "validado por el servidor" } ]',
N'La condición antes de ? debe ser bool; los dos resultados deben ser compatibles con string.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionExprEval);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Expresiones y Evaluación)');
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

PRINT N'Total: 6 ejercicios (2 MC, 2 completar, 2 escribir).';
GO

IF OBJECT_ID('tempdb..#LeccionExprEval') IS NOT NULL
    DROP TABLE #LeccionExprEval;
GO
