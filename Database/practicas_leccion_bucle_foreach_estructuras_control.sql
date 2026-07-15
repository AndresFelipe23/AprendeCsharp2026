-- ============================================
-- EJERCICIOS: Bucle foreach
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Bucle foreach" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionBucleForeach') IS NOT NULL
    DROP TABLE #LeccionBucleForeach;

CREATE TABLE #LeccionBucleForeach (LeccionId INT NOT NULL);

INSERT INTO #LeccionBucleForeach (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Bucle foreach'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionBucleForeach)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Bucle foreach".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Bucle foreach)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 3
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'¿Qué hace foreach?',
N'Selecciona la definición correcta de foreach en C#:',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Itera solo sobre variables int', 0, 1, N'Incorrecto. foreach funciona con colecciones enumerables de muchos tipos.'),
(@PracticaId1, N'Obliga a usar índices manuales', 0, 2, N'Incorrecto. Precisamente evita manejar índices manuales.'),
(@PracticaId1, N'Recorre elementos de una colección uno por uno', 1, 3, N'Correcto. foreach itera directamente sobre cada elemento.'),
(@PracticaId1, N'Solo se puede usar dentro de un switch', 0, 4, N'Incorrecto. foreach es independiente de switch.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 2
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Foreach vs for',
N'¿Cuál ventaja típica ofrece foreach frente a for al recorrer una lista?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Siempre es más rápido en todos los casos', 0, 1, N'Incorrecto. El rendimiento depende del escenario.'),
(@PracticaId2, N'Menor riesgo de errores de índice y código más legible', 1, 2, N'Correcto. Es una de sus principales ventajas.'),
(@PracticaId2, N'Permite modificar cualquier colección sin restricciones', 0, 3, N'Incorrecto. Modificar durante foreach suele causar problemas.'),
(@PracticaId2, N'Reemplaza por completo a while y do-while', 0, 4, N'Incorrecto. Son estructuras con propósitos distintos.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'Foreach con array de enteros',
N'Completa el foreach para imprimir cada número del arreglo.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'int[] [BLOQUE_1] = { [BLOQUE_2], [BLOQUE_3], [BLOQUE_4] };' + CHAR(13) + CHAR(10)
    + N'foreach ([BLOQUE_5] [BLOQUE_6] in [BLOQUE_7])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_8]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'numeros', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'1', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'2', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'3', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'int', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'n', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'numeros', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'n', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 9, N'for', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'i', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'while', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'0', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'Foreach con strings',
N'Completa para recorrer e imprimir nombres con foreach.',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'string[] [BLOQUE_1] = { [BLOQUE_2], [BLOQUE_3] };' + CHAR(13) + CHAR(10)
    + N'foreach ([BLOQUE_4] [BLOQUE_5] in [BLOQUE_6])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    Console.WriteLine([BLOQUE_7]);' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'nombres', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'"Ana"', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'"Luis"', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'string', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'nombre', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'nombres', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'nombre', 7, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 8, N'int', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'for', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'n', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'continue', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Suma con foreach',
N'Escribe estas declaraciones:
int[] valores = { 2, 4, 6 };
int suma = 0;
foreach (int v in valores)
{
    suma += v;
}
Console.WriteLine(suma);',
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
N'int[] valores = { 2, 4, 6 };
int suma = 0;
foreach (int v in valores)
{
    suma += v;
}
Console.WriteLine(suma);',
N'[ { "test": "foreach-suma", "expected": "validado por el servidor" } ]',
N'Usa una variable acumuladora y recorre con foreach.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Imprimir elementos',
N'Escribe estas declaraciones:
string[] frutas = { "Manzana", "Pera" };
foreach (string fruta in frutas)
{
    Console.WriteLine(fruta);
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
N'string[] frutas = { "Manzana", "Pera" };
foreach (string fruta in frutas)
{
    Console.WriteLine(fruta);
}',
N'[ { "test": "foreach-imprimir", "expected": "validado por el servidor" } ]',
N'La variable del foreach representa cada elemento de la colección.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBucleForeach);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Bucle foreach)');
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

IF OBJECT_ID('tempdb..#LeccionBucleForeach') IS NOT NULL
    DROP TABLE #LeccionBucleForeach;
GO
