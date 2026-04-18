-- ============================================
-- EJERCICIOS: Precedencia de Operadores
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Precedencia de Operadores" (Orden 7 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionPrecOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionPrecOps') IS NOT NULL
    DROP TABLE #LeccionPrecOps;

CREATE TABLE #LeccionPrecOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionPrecOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Precedencia de Operadores'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionPrecOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Precedencia de Operadores" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Precedencia de Operadores, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — * antes que +
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'Suma y multiplicación',
N'Sin paréntesis, ¿cuál es el resultado de la expresión entera 2 + 3 * 4 en C#?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'14', 1, 1, N'Correcto. Primero 3 * 4 = 12, luego 2 + 12 = 14.'),
(@PracticaId1, N'20', 0, 2, N'Incorrecto. Eso sería (2 + 3) * 4; sin paréntesis la multiplicación va antes.'),
(@PracticaId1, N'24', 0, 3, N'Incorrecto. No se multiplican todos los números en ese orden.'),
(@PracticaId1, N'9', 0, 4, N'Incorrecto. 2 + 3 sería 5, pero * tiene mayor precedencia que +.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — && antes que ||
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'AND y OR lógicos',
N'Sin paréntesis, en una expresión como a || b && c (con a, b y c de tipo bool), ¿qué operador tiene mayor precedencia en C#?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'&& (AND lógico)', 1, 1, N'Correcto. && se agrupa antes que ||; equivale a a || (b && c).'),
(@PracticaId2, N'|| (OR lógico)', 0, 2, N'Incorrecto. || tiene menor precedencia que && en C#.'),
(@PracticaId2, N'Se evalúan al mismo tiempo', 0, 3, N'Incorrecto. Hay un orden definido por precedencia.'),
(@PracticaId2, N'Depende del valor de las variables', 0, 4, N'Incorrecto. La precedencia es una regla del lenguaje, no del contenido.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — 2 + 3 * 4
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Multiplicación antes que suma',
N'Completa: int total = 2 + 3 * 4;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3] + [BLOQUE_4] * [BLOQUE_5];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'total', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'2', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'3', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'4', 5, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 6, N'*', 0, 1),
(@PracticaId3, @CodigoBase3, 7, N'-', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'20', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'double', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'suma', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — Paréntesis
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Forzar orden con paréntesis',
N'Completa: int r = ( 2 + 3 ) * 4;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = ( [BLOQUE_3] + [BLOQUE_4] ) * [BLOQUE_5];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'r', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'2', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'3', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'4', 5, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 6, N'5', 0, 1),
(@PracticaId4, @CodigoBase4, 7, N'14', 0, 1),
(@PracticaId4, @CodigoBase4, 8, N'resultado', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'bool', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'[', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — * y + en una expresión
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Producto antes que suma',
N'Escribe estas líneas:
int base = 10;
int valor = base * 2 + 5;',
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
N'int base = 10;
int valor = base * 2 + 5;',
N'[ { "test": "precedencia * +", "expected": "validado por el servidor" } ]',
N'Se evalúa como (base * 2) + 5, no base * (2 + 5).');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — +, *, - combinados
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Varios operadores aritméticos',
N'Escribe estas líneas:
int a1 = 2;
int b1 = 3;
int c1 = 4;
int resultado = a1 + b1 * c1 / 2 - 1;',
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
N'int a1 = 2;
int b1 = 3;
int c1 = 4;
int resultado = a1 + b1 * c1 / 2 - 1;',
N'[ { "test": "precedencia mixta", "expected": "validado por el servidor" } ]',
N'* y / antes que + y -; * y / se combinan de izquierda a derecha: b1 * c1 / 2 = 6.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionPrecOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Precedencia de Operadores)');
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

IF OBJECT_ID('tempdb..#LeccionPrecOps') IS NOT NULL
    DROP TABLE #LeccionPrecOps;
GO
