-- ============================================
-- EJERCICIOS: Introducción a Estructuras de Control
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Introducción a Estructuras de Control" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionIntroControl') IS NOT NULL
    DROP TABLE #LeccionIntroControl;

CREATE TABLE #LeccionIntroControl (LeccionId INT NOT NULL);

INSERT INTO #LeccionIntroControl (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Introducción a Estructuras de Control'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionIntroControl)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Introducción a Estructuras de Control".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Introducción a Estructuras de Control)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'¿Qué hacen las estructuras de control?',
N'Selecciona la opción correcta:',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Controlan el flujo del programa para tomar decisiones y repetir acciones', 1, 1, N'Correcto. Permiten decidir qué código ejecutar y cuántas veces.'),
(@PracticaId1, N'Solo sirven para declarar variables', 0, 2, N'Incorrecto. Declarar variables no es su propósito principal.'),
(@PracticaId1, N'Únicamente se usan para imprimir texto en consola', 0, 3, N'Incorrecto. Console.WriteLine no define estructuras de control.'),
(@PracticaId1, N'Convierten automáticamente números en texto', 0, 4, N'Incorrecto. Eso corresponde a conversión/formato, no a control de flujo.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Identificar tipo de estructura',
N'¿Cuál de las siguientes opciones representa una estructura de repetición?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'for', 1, 1, N'Correcto. for repite un bloque de código mientras se cumpla una condición.'),
(@PracticaId2, N'if', 0, 2, N'Incorrecto. if es condicional, no de repetición.'),
(@PracticaId2, N'switch', 0, 3, N'Incorrecto. switch es condicional de selección múltiple.'),
(@PracticaId2, N'return', 0, 4, N'Incorrecto. return sale de un método, no es bucle.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'Condición básica con if-else',
N'Completa el código para evaluar si una edad corresponde a mayor de edad.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] ([BLOQUE_5] >= [BLOQUE_6])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_7]);' + CHAR(13) + CHAR(10)
    + N'}' + CHAR(13) + CHAR(10)
    + N'else' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_8]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'edad', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'20', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'if', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'edad', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'18', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'"Mayor de edad"', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'"Menor de edad"', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 9, N'while', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'=', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'"Edad inválida"', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'bool', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'Repetición con for',
N'Completa el bucle para imprimir números del 1 al 3.',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] ([BLOQUE_2] [BLOQUE_3] = [BLOQUE_4]; [BLOQUE_5] <= [BLOQUE_6]; [BLOQUE_7]++)' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_8]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'for', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'int', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'i', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'1', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'i', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'3', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'i', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'i', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 9, N'if', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'j', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'0', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'break', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Decisión con if',
N'Escribe estas declaraciones:
int nota = 85;
if (nota >= 70)
{
    Console.WriteLine("Aprobado");
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
N'int nota = 85;
if (nota >= 70)
{
    Console.WriteLine("Aprobado");
}',
N'[ { "test": "if-basico", "expected": "validado por el servidor" } ]',
N'Primero declara la variable, luego evalúa la condición dentro de if.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Repetición con while',
N'Escribe estas declaraciones:
int contador = 1;
while (contador <= 3)
{
    Console.WriteLine(contador);
    contador++;
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
N'int contador = 1;
while (contador <= 3)
{
    Console.WriteLine(contador);
    contador++;
}',
N'[ { "test": "while-basico", "expected": "validado por el servidor" } ]',
N'Recuerda incrementar el contador dentro del while para evitar un bucle infinito.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionIntroControl);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Introducción a Estructuras de Control)');
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

IF OBJECT_ID('tempdb..#LeccionIntroControl') IS NOT NULL
    DROP TABLE #LeccionIntroControl;
GO
