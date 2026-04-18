-- ============================================
-- EJERCICIOS: Constantes y readonly
-- Lección: "Constantes y readonly" (CursoId = 1)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionConst cruza los GO).
-- Requisito: insert_lecciones_variables.sql (u otra carga con la misma lección).
-- "Escribir código" usa const locales (válidas dentro de Main). El API debe reconocer el prefijo const.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionConst') IS NOT NULL
    DROP TABLE #LeccionConst;

CREATE TABLE #LeccionConst (LeccionId INT NOT NULL);

INSERT INTO #LeccionConst (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 1
  AND l.Titulo = N'Constantes y readonly'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionConst)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Constantes y readonly" en CursoId 1.';
    PRINT 'Ejecuta insert_lecciones_variables.sql o revisa Lecciones.Titulo.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
PRINT 'Prácticas se asociarán a LeccionId = ' + CAST(@Lid AS VARCHAR(10));
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — const
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'¿Qué caracteriza a una constante (const)?',
N'Selecciona la afirmación correcta sobre const en C#:',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, N'Debe poder evaluarse en tiempo de compilación y no puede cambiar después', 1, 1, N'Correcto. const implica valor fijo conocido al compilar; se trata como miembro estático implícito.'),
(@PracticaId1, N'Puede reasignarse más adelante en el método', 0, 2, N'Incorrecto. Una constante no puede modificarse en tiempo de ejecución.'),
(@PracticaId1, N'Solo puede ser de tipo string', 0, 3, N'Incorrecto. const admite tipos primitivos y valores constantes permitidos por el compilador.'),
(@PracticaId1, N'Equivale exactamente a readonly en todos los casos', 0, 4, N'Incorrecto. readonly y const tienen reglas distintas (momento de asignación, estáticos, etc.).');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — readonly
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Campo readonly',
N'En una clase, ¿cuándo suele poder asignarse un campo readonly (no static)?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'En la declaración o en el constructor de la instancia', 1, 1, N'Correcto. Un campo de instancia readonly puede inicializarse al declararlo o en el constructor.'),
(@PracticaId2, N'Solo dentro de cualquier método público tantas veces como quieras', 0, 2, N'Incorrecto. readonly impide reasignación fuera de los puntos permitidos.'),
(@PracticaId2, N'Nunca; readonly solo existe para propiedades automáticas', 0, 3, N'Incorrecto. readonly aplica a campos y tiene reglas claras de asignación.'),
(@PracticaId2, N'Solo en tiempo de compilación como const', 0, 4, N'Incorrecto. readonly puede usar valores calculados en tiempo de ejecución en el constructor.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — const int y const string
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Declarar constantes',
N'Completa: const int HorasDia = 24; y const string Etiqueta = "MAX";',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] [BLOQUE_3] = [BLOQUE_4];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_5] [BLOQUE_6] [BLOQUE_7] = [BLOQUE_8];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'const', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'int', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'HorasDia', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'24', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'const', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'string', 6, 0),
(@PracticaId3, @CodigoBase3, 7, N'Etiqueta', 7, 0),
(@PracticaId3, @CodigoBase3, 8, N'"MAX"', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 9, N'readonly', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'var', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'Horas', 0, 1),
(@PracticaId3, @CodigoBase3, 12, N'''MAX''', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — const double y const bool
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Más constantes',
N'Completa: const double Iva = 0.19; y const bool ModoPrueba = true;',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] [BLOQUE_3] = [BLOQUE_4];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_5] [BLOQUE_6] [BLOQUE_7] = [BLOQUE_8];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'const', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'double', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'Iva', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'0.19', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'const', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'bool', 6, 0),
(@PracticaId4, @CodigoBase4, 7, N'ModoPrueba', 7, 0),
(@PracticaId4, @CodigoBase4, 8, N'true', 8, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 9, N'decimal', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'0.19m', 0, 1),
(@PracticaId4, @CodigoBase4, 11, N'false', 0, 1),
(@PracticaId4, @CodigoBase4, 12, N'float', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO — const locales
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Constantes locales',
N'Escribe exactamente estas declaraciones dentro de Main (con ;):
const int DiasSemana = 7;
const double Pi = 3.14159;',
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
N'const int DiasSemana = 7;
const double Pi = 3.14159;',
N'[ { "test": "const int y double", "expected": "validado por el servidor" } ]',
N'const exige tipo explícito y valor constante en tiempo de compilación.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — string y int const
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Constantes de texto y entero',
N'Escribe estas líneas:
const string Version = "1.0";
const int MaxIntentos = 3;',
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
N'const string Version = "1.0";
const int MaxIntentos = 3;',
N'[ { "test": "const string e int", "expected": "validado por el servidor" } ]',
N'Los nombres deben coincidir: Version y MaxIntentos.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionConst);

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

IF OBJECT_ID('tempdb..#LeccionConst') IS NOT NULL
    DROP TABLE #LeccionConst;
GO
