-- ============================================
-- EJERCICIOS: Introducción a Operadores
-- Curso: Operadores y Expresiones (CursoId = 2 en insert_cursos_fundamentos.sql)
-- Lección: "Introducción a Operadores" (Orden 1 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionIntroOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionIntroOps') IS NOT NULL
    DROP TABLE #LeccionIntroOps;

CREATE TABLE #LeccionIntroOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionIntroOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Introducción a Operadores'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionIntroOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Introducción a Operadores" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Introducción a Operadores, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Concepto de operador
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'¿Qué es un operador en C#?',
N'Selecciona la definición que mejor describe un operador:',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Un símbolo que indica una operación sobre uno o más operandos', 1, 1, N'Correcto. Ejemplos: + suma, == compara, = asigna.'),
(@PracticaId1, N'Solo el nombre de una variable', 0, 2, N'Incorrecto. El nombre de la variable es el identificador; el operador es el símbolo de la operación.'),
(@PracticaId1, N'Cualquier palabra reservada del lenguaje', 0, 3, N'Incorrecto. Los operadores son símbolos o palabras clave concretas (if no es un operador aritmético).'),
(@PracticaId1, N'Únicamente los símbolos + y -', 0, 4, N'Incorrecto. Hay muchos operadores: *, /, %, ==, &&, etc.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Tipo de operador
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Clasificación del operador ==',
N'¿A qué categoría pertenece principalmente el operador == en C#?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Operador de comparación (igualdad)', 1, 1, N'Correcto. == compara si dos valores son iguales y devuelve bool.'),
(@PracticaId2, N'Operador aritmético', 0, 2, N'Incorrecto. La suma es +; == no hace aritmética.'),
(@PracticaId2, N'Operador de asignación', 0, 3, N'Incorrecto. La asignación es = ; == es comparación.'),
(@PracticaId2, N'Operador de concatenación exclusivo de texto', 0, 4, N'Incorrecto. Para texto también se usa + en C#, pero == no es “solo concatenación”.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — Suma
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Suma con +',
N'Completa las tres líneas: int a = 12; int b = 8; int total = a + b;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9] + [BLOQUE_10];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'a', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'12', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'int', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'b', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'8', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'int', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'total', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'a', 9, 0),
(@PracticaId3, @CodigoBase3, 10, N'b', 10, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 11, N'string', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'*', 0, 1),
(@PracticaId3, @CodigoBase3, 13, N'-', 0, 1),
(@PracticaId3, @CodigoBase3, 14, N'20', 0, 1),
(@PracticaId3, @CodigoBase3, 15, N'suma', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — Comparación >
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Comparar con >',
N'Completa: int x = 15; int y = 9; bool mayor = x > y;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'bool [BLOQUE_7] = [BLOQUE_8] > [BLOQUE_9];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'x', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'15', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'int', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'y', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'9', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'mayor', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'x', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'y', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 10, N'bool', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'y', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'x', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'==', 0, 1),
(@PracticaId4, @CodigoBase4, 14, N'menor', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — Módulo %
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Operador módulo',
N'Escribe estas declaraciones:
int n = 17;
int d = 5;
int resto = n % d;',
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
N'int n = 17;
int d = 5;
int resto = n % d;',
N'[ { "test": "módulo", "expected": "validado por el servidor" } ]',
N'El operador % devuelve el resto de la división entera.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Igualdad ==
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Comparar igualdad',
N'Escribe estas declaraciones:
int p = 3;
int q = 3;
bool mismoValor = p == q;',
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
N'int p = 3;
int q = 3;
bool mismoValor = p == q;',
N'[ { "test": "==", "expected": "validado por el servidor" } ]',
N'== compara valores; no confundir con = (asignación).');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Introducción a Operadores)');
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

IF OBJECT_ID('tempdb..#LeccionIntroOps') IS NOT NULL
    DROP TABLE #LeccionIntroOps;
GO
