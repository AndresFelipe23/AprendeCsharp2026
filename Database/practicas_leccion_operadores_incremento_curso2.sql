-- ============================================
-- EJERCICIOS: Operadores de Incremento y Decremento
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Operadores de Incremento y Decremento" (Orden 6 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionIncOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionIncOps') IS NOT NULL
    DROP TABLE #LeccionIncOps;

CREATE TABLE #LeccionIncOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionIncOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Operadores de Incremento y Decremento'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionIncOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Operadores de Incremento y Decremento" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Incremento/Decremento, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Efecto de x++
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'Incremento en una unidad',
N'En C#, si n es una variable int, ¿qué hace la expresión n++ (forma sufija) respecto al valor de n?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Aumenta n en 1', 1, 1, N'Correcto. ++ incrementa; en sufijo el valor se usa antes del incremento si forma parte de una expresión mayor.'),
(@PracticaId1, N'Duplica el valor de n', 0, 2, N'Incorrecto. Eso sería n *= 2 o similar.'),
(@PracticaId1, N'Suma 2 a n', 0, 3, N'Incorrecto. ++ siempre suma 1.'),
(@PracticaId1, N'No modifica n (solo lectura)', 0, 4, N'Incorrecto. n++ sí modifica n después de evaluar el valor anterior en contexto de expresión.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Prefijo ++
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Orden con ++ prefijo',
N'Si ejecutas: int a = 5; int b = ++a; ¿qué valores tienen a y b?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'a = 6 y b = 6', 1, 1, N'Correcto. ++a incrementa a primero; luego ese valor se asigna a b.'),
(@PracticaId2, N'a = 5 y b = 6', 0, 2, N'Incorrecto. Con prefijo, a ya no queda en 5.'),
(@PracticaId2, N'a = 6 y b = 5', 0, 3, N'Incorrecto. b recibe el valor de a ya incrementado.'),
(@PracticaId2, N'a = 5 y b = 5', 0, 4, N'Incorrecto. Tanto a como b cambian respecto al estado inicial de a.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — Sufijo en asignación
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Asignar con x++',
N'Completa: int c = 5; int d = c++;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6]++;';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'c', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'5', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'int', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'd', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'c', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 7, N'--', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'd', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'++d', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'bool', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'6', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — Prefijo --
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Asignar con -- prefijo',
N'Completa: int e = 10; int f = --e;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6] [BLOQUE_7];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'e', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'10', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'int', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'f', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'--', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'e', 7, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 8, N'++', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'e--', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'f', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'9', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'string', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — Sufijo ++
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Instrucción contador++',
N'Escribe estas líneas:
int contador = 0;
contador++;',
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
N'int contador = 0;
contador++;',
N'[ { "test": "postfijo ++", "expected": "validado por el servidor" } ]',
N'La forma sufija incrementa la variable después de usar su valor en una expresión; sola en una línea solo incrementa.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Prefijo --
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Instrucción --prefijo',
N'Escribe estas líneas:
int pasos = 3;
--pasos;',
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
N'int pasos = 3;
--pasos;',
N'[ { "test": "prefijo --", "expected": "validado por el servidor" } ]',
N'--variable decrementa antes de usarse en una expresión; aquí es una sentencia completa.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIncOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Operadores de Incremento y Decremento)');
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

IF OBJECT_ID('tempdb..#LeccionIncOps') IS NOT NULL
    DROP TABLE #LeccionIncOps;
GO