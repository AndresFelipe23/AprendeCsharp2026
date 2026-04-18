-- ============================================
-- EJERCICIOS: Operadores de Asignación
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Operadores de Asignación" (Orden 5 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionAsigOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- Escribir código: requiere backend que acepte líneas tipo n += 1; (practicas.service.ts).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionAsigOps') IS NOT NULL
    DROP TABLE #LeccionAsigOps;

CREATE TABLE #LeccionAsigOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionAsigOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Operadores de Asignación'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionAsigOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Operadores de Asignación" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Operadores de Asignación, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Equivalente de +=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'Significado de +=',
N'Si x es una variable int ya declarada, ¿a qué es equivalente la instrucción x += 4;?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'x = x + 4;', 1, 1, N'Correcto. += suma y asigna el resultado a la misma variable.'),
(@PracticaId1, N'x = 4;', 0, 2, N'Incorrecto. Eso solo asigna 4; no usa el valor anterior de x.'),
(@PracticaId1, N'x + 4;', 0, 3, N'Incorrecto. Falta la asignación; es solo una expresión.'),
(@PracticaId1, N'x =+ 4; (operador distinto)', 0, 4, N'Incorrecto. =+ no es el operador compuesto; el correcto es +=.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — /=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'División y asignación',
N'¿Qué operador de C# divide la variable por un valor y guarda el cociente en la misma variable?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'/=', 1, 1, N'Correcto. Por ejemplo: n /= 2; equivale a n = n / 2;'),
(@PracticaId2, N'\\=', 0, 2, N'Incorrecto. No existe ese operador en C#.'),
(@PracticaId2, N'div=', 0, 3, N'Incorrecto. En C# se usa /=, no div=.'),
(@PracticaId2, N'%=', 0, 4, N'Incorrecto. %= asigna el resto (módulo), no el cociente.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — += con int
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Suma y asigna (+=)',
N'Completa: int puntos = 10; puntos += 5;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'puntos', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'10', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'puntos', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'+=', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'5', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 7, N'-=', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'=', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'*', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'score', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'15', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — += con string
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Concatenar con +=',
N'Completa: string saludo = "Hola"; saludo += "!";',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'string', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'saludo', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'"Hola"', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'saludo', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'+=', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'"!"', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 7, N'-=', 0, 1),
(@PracticaId4, @CodigoBase4, 8, N'=', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'"Adiós"', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'mensaje', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'int', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — *=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Multiplicar y asignar (*=)',
N'Escribe estas líneas:
int factor = 7;
factor *= 3;',
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
N'int factor = 7;
factor *= 3;',
N'[ { "test": "*=", "expected": "validado por el servidor" } ]',
N'*= multiplica la variable por el valor y guarda el resultado en la misma variable.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — -= y %=
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Restar y módulo (-= y %=)',
N'Escribe estas líneas:
int stock = 50;
stock -= 12;
stock %= 7;',
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
N'int stock = 50;
stock -= 12;
stock %= 7;',
N'[ { "test": "-= y %=", "expected": "validado por el servidor" } ]',
N'Primero resta; %= deja en stock el resto de dividir por 7.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAsigOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Operadores de Asignación)');
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

IF OBJECT_ID('tempdb..#LeccionAsigOps') IS NOT NULL
    DROP TABLE #LeccionAsigOps;
GO
