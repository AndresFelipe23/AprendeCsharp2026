-- ============================================
-- EJERCICIOS: Estructura switch-case
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Requisito: la lección "Estructura switch-case" ya debe existir.
-- Nota: este script no elimina duplicados; no re-ejecutar sin limpiar antes.
-- ============================================

USE LenguajeCsharp;
GO

IF OBJECT_ID('tempdb..#LeccionSwitchCase') IS NOT NULL
    DROP TABLE #LeccionSwitchCase;

CREATE TABLE #LeccionSwitchCase (LeccionId INT NOT NULL);

INSERT INTO #LeccionSwitchCase (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.Titulo = N'Estructura switch-case'
ORDER BY l.LeccionId DESC;

IF NOT EXISTS (SELECT 1 FROM #LeccionSwitchCase)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Estructura switch-case".';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
PRINT CONCAT(N'Prácticas -> LeccionId = ', CAST(@Lid AS NVARCHAR(10)), N' (Estructura switch-case)');
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE
-- Correcta en posición 3 (rotada)
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
N'¿Para qué sirve break en switch?',
N'En una estructura switch-case, ¿qué función cumple break dentro de un case?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Convierte el case en un bucle', 0, 1, N'Incorrecto. switch no es un bucle.'),
(@PracticaId1, N'Evalúa automáticamente el siguiente case', 0, 2, N'Incorrecto. Eso sería lo contrario de break.'),
(@PracticaId1, N'Finaliza ese case y evita continuar con los siguientes', 1, 3, N'Correcto. break corta la ejecución del switch en ese punto.'),
(@PracticaId1, N'Reemplaza al bloque default', 0, 4, N'Incorrecto. default se usa cuando no hay coincidencia.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE
-- Correcta en posición 2 (rotada)
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
N'Caso default',
N'¿Cuándo se ejecuta default en un switch?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'Siempre al final del switch, aunque haya coincidencia', 0, 1, N'Incorrecto. Si hay case coincidente con break, default no se ejecuta.'),
(@PracticaId2, N'Cuando ningún case coincide con el valor evaluado', 1, 2, N'Correcto. default actúa como caso por defecto.'),
(@PracticaId2, N'Solo cuando el valor es null', 0, 3, N'Incorrecto. default no depende de null únicamente.'),
(@PracticaId2, N'Antes del primer case', 0, 4, N'Incorrecto. default es una alternativa de ejecución, no una cabecera previa.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
N'Switch con días',
N'Completa el switch para mostrar "Lunes" cuando dia sea 1.',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_3] ([BLOQUE_4])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    [BLOQUE_5] [BLOQUE_6]:' + CHAR(13) + CHAR(10)
    + N'        Console.WriteLine([BLOQUE_7]);' + CHAR(13) + CHAR(10)
    + N'        [BLOQUE_8];' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'dia', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'1', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'switch', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'dia', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'case', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'1', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'"Lunes"', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'break', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 9, N'if', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'default', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'continue', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'"Martes"', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
N'Case agrupados',
N'Completa para que 6 y 7 muestren "Fin de semana".',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'int [BLOQUE_1] = [BLOQUE_2];' + CHAR(13) + CHAR(10)
    + N'switch ([BLOQUE_3])' + CHAR(13) + CHAR(10)
    + N'{' + CHAR(13) + CHAR(10)
    + N'    case [BLOQUE_4]:' + CHAR(13) + CHAR(10)
    + N'    case [BLOQUE_5]:' + CHAR(13) + CHAR(10)
    + N'        Console.WriteLine([BLOQUE_6]);' + CHAR(13) + CHAR(10)
    + N'        [BLOQUE_7];' + CHAR(13) + CHAR(10)
    + N'}';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'dia', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'7', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'dia', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'6', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'7', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'"Fin de semana"', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'break', 7, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 8, N'"Día hábil"', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'return', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'1', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'while', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
N'Switch de menú',
N'Escribe estas declaraciones:
int opcion = 2;
switch (opcion)
{
    case 1:
        Console.WriteLine("Crear");
        break;
    case 2:
        Console.WriteLine("Editar");
        break;
    default:
        Console.WriteLine("Opción inválida");
        break;
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
N'int opcion = 2;
switch (opcion)
{
    case 1:
        Console.WriteLine("Crear");
        break;
    case 2:
        Console.WriteLine("Editar");
        break;
    default:
        Console.WriteLine("Opción inválida");
        break;
}',
N'[ { "test": "switch-menu", "expected": "validado por el servidor" } ]',
N'Recuerda incluir break en cada case.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
N'Switch con string',
N'Escribe estas declaraciones:
string rol = "admin";
switch (rol)
{
    case "admin":
        Console.WriteLine("Acceso total");
        break;
    case "user":
        Console.WriteLine("Acceso limitado");
        break;
    default:
        Console.WriteLine("Rol desconocido");
        break;
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
N'string rol = "admin";
switch (rol)
{
    case "admin":
        Console.WriteLine("Acceso total");
        break;
    case "user":
        Console.WriteLine("Acceso limitado");
        break;
    default:
        Console.WriteLine("Rol desconocido");
        break;
}',
N'[ { "test": "switch-string", "expected": "validado por el servidor" } ]',
N'En switch también puedes evaluar strings.');
GO

-- ============================================
-- RESUMEN
-- ============================================
DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionSwitchCase);

PRINT '========================================';
PRINT CONCAT(N'Ejercicios -> LeccionId ', CAST(@LeccionId AS NVARCHAR(10)), N' (Estructura switch-case)');
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

IF OBJECT_ID('tempdb..#LeccionSwitchCase') IS NOT NULL
    DROP TABLE #LeccionSwitchCase;
GO
