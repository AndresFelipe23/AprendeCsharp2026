-- ============================================
-- EJERCICIOS: Tipo bool y valores nulos
-- Lección: "Tipo bool y valores nulos" (CursoId = 1)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionBoolNulos cruza los GO).
-- Requisito: insert_lecciones_variables.sql (u otra carga con la misma lección).
-- No re-ejecutar sin borrar prácticas duplicadas de esta lección.
-- Nota: ejercicios "Escribir código" usan int?, string? y bool; el API debe aceptar ? en el tipo (regex actualizado).
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionBoolNulos') IS NOT NULL
    DROP TABLE #LeccionBoolNulos;

CREATE TABLE #LeccionBoolNulos (LeccionId INT NOT NULL);

INSERT INTO #LeccionBoolNulos (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 1
  AND l.Titulo = N'Tipo bool y valores nulos'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionBoolNulos)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Tipo bool y valores nulos" en CursoId 1.';
    PRINT 'Ejecuta insert_lecciones_variables.sql o revisa Lecciones.Titulo.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
PRINT 'Prácticas se asociarán a LeccionId = ' + CAST(@Lid AS VARCHAR(10));
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Valores de bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'Valores del tipo bool',
N'En C#, ¿qué valores puede almacenar una variable de tipo bool?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Solo true y false', 1, 1, N'Correcto. bool representa valores lógicos: true (verdadero) o false (falso).'),
(@PracticaId1, N'true, false y null', 0, 2, N'Incorrecto. Un bool "normal" no admite null; para eso se usa bool?.'),
(@PracticaId1, N'0 y 1', 0, 3, N'Incorrecto. En C# no se usa 0/1 como en otros lenguajes; usa true o false.'),
(@PracticaId1, N'Cualquier número entero', 0, 4, N'Incorrecto. Para números enteros usa int, long, etc.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — int?
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'¿Qué significa int? en C#?',
N'Selecciona la descripción correcta del tipo int? (int nullable):',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Un entero que también puede valer null (sin valor)', 1, 1, N'Correcto. El sufijo ? indica un tipo valor nullable; int? puede ser un int o null.'),
(@PracticaId2, N'Un entero que siempre es cero al inicio', 0, 2, N'Incorrecto. int? no fuerza cero; puede ser null si no asignas valor.'),
(@PracticaId2, N'Un entero más grande que long', 0, 3, N'Incorrecto. int? no cambia el rango del entero, solo permite null.'),
(@PracticaId2, N'Un error de sintaxis', 0, 4, N'Incorrecto. int? es sintaxis válida en C#.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — int? y bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Nullable y bool',
N'Completa: int? edad = null; y bool registrado = true;',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'int?', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'edad', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'null', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'bool', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'registrado', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'true', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 7, N'int', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'false', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'string', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'0', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'bool?', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — string? y bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'string nullable y bandera',
N'Completa: string? apodo = null; y bool verificado = false;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'string?', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'apodo', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'null', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'bool', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'verificado', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'false', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 7, N'string', 0, 1),
(@PracticaId4, @CodigoBase4, 8, N'true', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'"null"', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'int?', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — Nullables simples
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Nullable y bool básico',
N'Escribe exactamente estas declaraciones (con ; al final):
int? puntaje = null;
bool publicado = true;',
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
N'int? puntaje = null;
bool publicado = true;',
N'[ { "test": "int? y bool", "expected": "validado por el servidor" } ]',
N'Usa int? para permitir null; bool solo admite true o false.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Operador lógico
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Combinar bool con &&',
N'Escribe estas tres declaraciones:
bool a = true;
bool b = false;
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
bool b = false;
bool ambos = a && b;',
N'[ { "test": "bool y &&", "expected": "validado por el servidor" } ]',
N'&& devuelve true solo si ambos operandos son true.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionBoolNulos);

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

IF OBJECT_ID('tempdb..#LeccionBoolNulos') IS NOT NULL
    DROP TABLE #LeccionBoolNulos;
GO
