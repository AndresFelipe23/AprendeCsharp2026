-- ============================================
-- EJERCICIOS: Operadores Lógicos
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Operadores Lógicos" (Orden 4 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionLogOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionLogOps') IS NOT NULL
    DROP TABLE #LeccionLogOps;

CREATE TABLE #LeccionLogOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionLogOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Operadores Lógicos'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionLogOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Operadores Lógicos" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Operadores Lógicos, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Tabla de verdad &&
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'AND lógico (&&)',
N'En C#, ¿qué valor tiene la expresión true && false?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'false', 1, 1, N'Correcto. Con && hace falta que ambas condiciones sean true.'),
(@PracticaId1, N'true', 0, 2, N'Incorrecto. Solo sería true si ambos operandos fueran true.'),
(@PracticaId1, N'null', 0, 3, N'Incorrecto. bool no usa null salvo bool?.'),
(@PracticaId1, N'No compila', 0, 4, N'Incorrecto. La expresión es válida y se evalúa a false.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Cortocircuito con &&
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Evaluación en cortocircuito',
N'Con el operador &&, si la primera condición ya es false, ¿qué ocurre con la segunda expresión?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'No se evalúa (cortocircuito)', 1, 1, N'Correcto. Si la primera parte es false, el resultado ya es false.'),
(@PracticaId2, N'Siempre se evalúa la segunda expresión', 0, 2, N'Incorrecto. Con &&, si la primera es false, la segunda no se evalúa.'),
(@PracticaId2, N'Se evalúa antes que la primera', 0, 3, N'Incorrecto. El orden de evaluación respeta primero la expresión de la izquierda.'),
(@PracticaId2, N'Depende del compilador y no está definido', 0, 4, N'Incorrecto. El cortocircuito de && está definido en el lenguaje.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — && con comparación
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Combinar condiciones con &&',
N'Completa: int edad = 21; bool carnet = true; bool apto = edad >= 18 && carnet;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'bool [BLOQUE_7] = [BLOQUE_8] >= [BLOQUE_9] && [BLOQUE_10];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'edad', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'21', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'bool', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'carnet', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'true', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'apto', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'edad', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'18', 9, 0),
(@PracticaId3, @CodigoBase3, 10, N'carnet', 10, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 11, N'||', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'==', 0, 1),
(@PracticaId3, @CodigoBase3, 13, N'false', 0, 1),
(@PracticaId3, @CodigoBase3, 14, N'mayor', 0, 1),
(@PracticaId3, @CodigoBase3, 15, N'17', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — ||
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'OR lógico (||)',
N'Completa: bool p = false; bool q = true; bool alguno = p || q;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'bool [BLOQUE_7] = [BLOQUE_8] || [BLOQUE_9];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'bool', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'p', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'false', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'bool', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'q', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'true', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'alguno', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'p', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'q', 9, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 10, N'&&', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'int', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'ambos', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'!', 0, 1),
(@PracticaId4, @CodigoBase4, 14, N'0', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — ! (NOT)
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Negar con !',
N'Escribe estas declaraciones:
bool cerrado = true;
bool abierto = !cerrado;',
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
N'bool cerrado = true;
bool abierto = !cerrado;',
N'[ { "test": "NOT lógico", "expected": "validado por el servidor" } ]',
N'! invierte: si cerrado es true, !cerrado es false.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — && y variables bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'AND entre booleanos',
N'Escribe estas declaraciones:
bool a = true;
bool b = true;
bool ambos = a && b;',
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
N'bool a = true;
bool b = true;
bool ambos = a && b;',
N'[ { "test": "&& bool", "expected": "validado por el servidor" } ]',
N'&& exige que ambas expresiones bool sean true para dar true.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionLogOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Operadores Lógicos)');
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

IF OBJECT_ID('tempdb..#LeccionLogOps') IS NOT NULL
    DROP TABLE #LeccionLogOps;
GO