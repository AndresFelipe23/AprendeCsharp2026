-- ============================================
-- EJERCICIOS: Operadores Aritméticos
-- Curso: Operadores y Expresiones (CursoId = 2)
-- Lección: "Operadores Aritméticos" (Orden 2 en lecciones_operadores_expresiones.sql)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionAritOps cruza los GO).
-- Requisito: cursos + lecciones_operadores_expresiones.sql (o equivalente).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionAritOps') IS NOT NULL
    DROP TABLE #LeccionAritOps;

CREATE TABLE #LeccionAritOps (LeccionId INT NOT NULL);

INSERT INTO #LeccionAritOps (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 2
  AND l.Titulo = N'Operadores Aritméticos'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionAritOps)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Operadores Aritméticos" con CursoId = 2.';
    PRINT 'Verifica insert_cursos_fundamentos.sql y lecciones_operadores_expresiones.sql.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
PRINT CONCAT(N'Prácticas → LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Operadores Aritméticos, CursoId 2)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — División entera
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'División entre enteros',
N'En C#, si ambos operandos son int, ¿qué valor queda en x después de int x = 17 / 5;?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'3 (se descarta la parte decimal)', 1, 1, N'Correcto. La división entera trunca hacia cero; 17 / 5 = 3.'),
(@PracticaId1, N'3.4', 0, 2, N'Incorrecto. 3.4 sería double; aquí x es int.'),
(@PracticaId1, N'4 (redondeo al entero más cercano)', 0, 3, N'Incorrecto. No redondea: trunca.'),
(@PracticaId1, N'2', 0, 4, N'Incorrecto. Revisa la división entera 17 / 5.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Operador módulo
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Resto de la división',
N'¿Qué operador de C# devuelve el resto de una división entera (por ejemplo, el resto de dividir 15 entre 4)?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'% (módulo)', 1, 1, N'Correcto. 15 % 4 es 3.'),
(@PracticaId2, N'/ (división)', 0, 2, N'Incorrecto. / da el cociente entero o decimal según los tipos, no el resto.'),
(@PracticaId2, N'^ (potencia)', 0, 3, N'Incorrecto. En C# no se usa ^ para potencia; además ^ es XOR a nivel de bits.'),
(@PracticaId2, N'mod (palabra clave)', 0, 4, N'Incorrecto. En C# el módulo se escribe con %.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — Multiplicación
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Multiplicar con *',
N'Completa las tres líneas: int a = 6; int b = 7; int producto = a * b;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9] * [BLOQUE_10];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'a', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'6', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'int', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'b', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'7', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'int', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'producto', 8, 0),
(@PracticaId3, @CodigoBase3, 9, N'a', 9, 0),
(@PracticaId3, @CodigoBase3, 10, N'b', 10, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 11, N'+', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'/', 0, 1),
(@PracticaId3, @CodigoBase3, 13, N'suma', 0, 1),
(@PracticaId3, @CodigoBase3, 14, N'42', 0, 1),
(@PracticaId3, @CodigoBase3, 15, N'double', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — División entera
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Dividir con /',
N'Completa: int m = 23; int n = 5; int cociente = m / n;  (recuerda: división entera)',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9] / [BLOQUE_10];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'm', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'23', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'int', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'n', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'5', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'int', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'cociente', 8, 0),
(@PracticaId4, @CodigoBase4, 9, N'm', 9, 0),
(@PracticaId4, @CodigoBase4, 10, N'n', 10, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 11, N'%', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'*', 0, 1),
(@PracticaId4, @CodigoBase4, 13, N'division', 0, 1),
(@PracticaId4, @CodigoBase4, 14, N'4.6', 0, 1),
(@PracticaId4, @CodigoBase4, 15, N'bool', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — Módulo
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Resto con %',
N'Escribe estas declaraciones:
int valor = 19;
int divisor = 4;
int resto = valor % divisor;',
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
N'int valor = 19;
int divisor = 4;
int resto = valor % divisor;',
N'[ { "test": "módulo aritmético", "expected": "validado por el servidor" } ]',
N'El operador % devuelve el resto: 19 dividido entre 4 deja resto 3.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Resta
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Restar con -',
N'Escribe estas declaraciones:
int total = 50;
int descuento = 12;
int aPagar = total - descuento;',
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
N'int total = 50;
int descuento = 12;
int aPagar = total - descuento;',
N'[ { "test": "resta", "expected": "validado por el servidor" } ]',
N'El operador - resta el segundo valor al primero.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionAritOps);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios → LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Operadores Aritméticos)');
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

IF OBJECT_ID('tempdb..#LeccionAritOps') IS NOT NULL
    DROP TABLE #LeccionAritOps;
GO
