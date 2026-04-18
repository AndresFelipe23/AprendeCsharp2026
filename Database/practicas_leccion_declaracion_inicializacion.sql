-- ============================================
-- EJERCICIOS: Declaración e inicialización de variables
-- Lección: "Declaración e inicialización de variables" (CursoId = 1)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionDecl cruza los GO).
-- Requisito: insert_lecciones_variables.sql (u otra carga con la misma lección).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionDecl') IS NOT NULL
    DROP TABLE #LeccionDecl;

CREATE TABLE #LeccionDecl (LeccionId INT NOT NULL);

INSERT INTO #LeccionDecl (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 1
  AND l.Titulo = N'Declaración e inicialización de variables'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionDecl)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Declaración e inicialización de variables" en CursoId 1.';
    PRINT 'Ejecuta insert_lecciones_variables.sql o revisa Lecciones.Titulo.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
PRINT 'Prácticas se asociarán a LeccionId = ' + CAST(@Lid AS VARCHAR(10));
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Palabra clave var
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'¿Qué hace la palabra clave var?',
N'Al escribir por ejemplo: var edad = 25; ¿qué ocurre en C#?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'El compilador infiere el tipo a partir del valor (aquí sería int)', 1, 1, N'Correcto. var no es un tipo dinámico: el compilador deduce el tipo en tiempo de compilación.'),
(@PracticaId1, N'La variable puede cambiar de tipo más adelante', 0, 2, N'Incorrecto. var sigue siendo fuertemente tipado; no puedes asignar un string después a esa variable si fue inferida como int.'),
(@PracticaId1, N'Crea una variable sin tipo (como en JavaScript)', 0, 3, N'Incorrecto. C# es estático; var solo evita escribir el tipo explícito.'),
(@PracticaId1, N'Solo se puede usar con string', 0, 4, N'Incorrecto. var funciona con muchos tipos según el literal o expresión de la derecha.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Declaración múltiple
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Declarar varias variables del mismo tipo',
N'¿Cuál de estas líneas es válida en C# para declarar dos enteros con valor inicial?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'int a = 1, b = 2;', 1, 1, N'Correcto. Puedes declarar varias variables del mismo tipo separadas por coma.'),
(@PracticaId2, N'int a = 1; b = 2;', 0, 2, N'Incorrecto. La segunda asignación necesita tipo o declaración previa de b.'),
(@PracticaId2, N'int a = 1 int b = 2;', 0, 3, N'Incorrecto. Faltan el punto y coma entre declaraciones.'),
(@PracticaId2, N'var a = 1, b = "2";', 0, 4, N'Incorrecto. Con var en una misma declaración, todas las expresiones deben ser compatibles con un único tipo inferido; mezclar int y string así no es válido.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — int y string
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Declarar e inicializar',
N'Completa: int unidades = 12; y string producto = "Teclado";',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'unidades', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'12', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'string', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'producto', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'"Teclado"', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 7, N'double', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'''Teclado''', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'bool', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'"12"', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — double y bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Tipos distintos en dos líneas',
N'Completa: double precio = 19.95; y bool enOferta = true;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'double', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'precio', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'19.95', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'bool', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'enOferta', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'true', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 7, N'decimal', 0, 1),
(@PracticaId4, @CodigoBase4, 8, N'19.95m', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'false', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'float', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — var
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Inferencia con var',
N'Escribe exactamente estas dos declaraciones:
var ciudad = "Cali";
var año = 2026;',
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
N'var ciudad = "Cali";
var año = 2026;',
N'[ { "test": "var string e int", "expected": "validado por el servidor" } ]',
N'Recuerda el punto y coma al final de cada línea.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Una variable a partir de otra
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Inicializar usando otra variable',
N'Escribe estas declaraciones:
int inicio = 8;
int total = inicio + 2;',
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
N'int inicio = 8;
int total = inicio + 2;',
N'[ { "test": "int e expresión", "expected": "validado por el servidor" } ]',
N'La segunda línea usa el nombre de la primera variable en la expresión.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionDecl);

PRINT '========================================';
PRINT N'Ejercicios insertados para LeccionId ' + CAST(@LeccionId AS VARCHAR(10));
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

IF OBJECT_ID('tempdb..#LeccionDecl') IS NOT NULL
    DROP TABLE #LeccionDecl;
GO
