-- ============================================
-- EJERCICIOS: Operadores de Comparación
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Operadores de Comparación" (Orden 3 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionCompOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionCompOps') IS NOT NULL
    DROP TABLE #LeccionCompOps;

CREATE TABLE #LeccionCompOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionCompOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Operadores de Comparación'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionCompOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Operadores de Comparación" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Operadores de Comparación, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Resultado bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'Resultado de una comparación',
N'En C#, los operadores de comparación (==, !=, <, >, <=, >=) aplicados a valores compatibles, ¿qué tipo de resultado devuelven?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'bool (true o false)', 1, 1, N'Correcto. Toda comparación válida produce un valor booleano.'),
(@PracticaId1, N'int (0 o 1)', 0, 2, N'Incorrecto. En C# no se usa int para el resultado directo de ==, <, etc.'),
(@PracticaId1, N'string ("true" / "false")', 0, 3, N'Incorrecto. El resultado es bool, no cadena.'),
(@PracticaId1, N'object', 0, 4, N'Incorrecto. El tipo concreto es bool.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Operador !=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Distinto o diferente',
N'¿Qué operador de C# se usa para comprobar si dos valores NO son iguales?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'!=', 1, 1, N'Correcto. a != b es true cuando los valores difieren.'),
(@PracticaId2, N'!==', 0, 2, N'Incorrecto. Eso existe en JavaScript, no en C#.'),
(@PracticaId2, N'<>', 0, 3, N'Incorrecto. En C# no se usa <> para desigualdad.'),
(@PracticaId2, N'=/=', 0, 4, N'Incorrecto. No es un operador válido en C#.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — !=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Comprobar desigualdad',
N'Completa: int p = 8; int q = 3; bool distintos = p != q;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'bool [BLOQUE_7] = [BLOQUE_8] != [BLOQUE_9];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'p', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'8', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'int', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'q', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'3', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'distintos', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'p', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'q', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 10, N'==', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'=', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'bool', 0, 1),
(@PracticaId3, @CodigoBase3, 13, N'igual', 0, 1),
(@PracticaId3, @CodigoBase3, 14, N'q', 0, 1),
(@PracticaId3, @CodigoBase3, 15, N'p', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — >=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Mayor o igual',
N'Completa: int edad = 20; int minimo = 18; bool puedeEntrar = edad >= minimo;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'bool [BLOQUE_7] = [BLOQUE_8] >= [BLOQUE_9];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'edad', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'20', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'int', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'minimo', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'18', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'puedeEntrar', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'edad', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'minimo', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 10, N'<=', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'>', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'minimo', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'edad', 0, 1),
(@PracticaId4, @CodigoBase4, 14, N'bool', 0, 1),
(@PracticaId4, @CodigoBase4, 15, N'19', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — < entre enteros
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Menor que',
N'Escribe estas declaraciones:
int a = 5;
int b = 12;
bool esMenor = a < b;',
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
N'int a = 5;
int b = 12;
bool esMenor = a < b;',
N'[ { "test": "comparación <", "expected": "validado por el servidor" } ]',
N'< devuelve true si el valor de la izquierda es menor que el de la derecha.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — == entre cadenas
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Igualdad de textos',
N'Escribe estas declaraciones:
string s1 = "Hola";
string s2 = "Hola";
bool mismoTexto = s1 == s2;',
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
N'string s1 = "Hola";
string s2 = "Hola";
bool mismoTexto = s1 == s2;',
N'[ { "test": "== string", "expected": "validado por el servidor" } ]',
N'Con string, == compara el contenido, no la referencia del objeto.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionCompOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Operadores de Comparación)');
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

IF OBJECT_ID('tempdb..#LeccionCompOps') IS NOT NULL
    DROP TABLE #LeccionCompOps;
GO
