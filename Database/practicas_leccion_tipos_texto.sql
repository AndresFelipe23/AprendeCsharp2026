-- ============================================
-- EJERCICIOS: Tipos de datos de texto (string y char)
-- Lección: "Tipos de datos de texto" (CursoId = 1)
-- Patrón: 2 MultipleChoice + 2 CompletarCodigo + 2 EscribirCodigo
-- ============================================
-- Ejecutar de una sola vez en SSMS (#LeccionTexto cruza los GO).
-- Requisito: insert_lecciones_variables.sql (u otra carga de la misma lección).
-- No re-ejecutar sin borrar prácticas previas de esta lección.
-- ============================================

USE LenguajeCsharp
GO

IF OBJECT_ID('tempdb..#LeccionTexto') IS NOT NULL
    DROP TABLE #LeccionTexto;

CREATE TABLE #LeccionTexto (LeccionId INT NOT NULL);

INSERT INTO #LeccionTexto (LeccionId)
SELECT TOP 1 l.LeccionId
FROM Lecciones l
WHERE l.CursoId = 1
  AND l.Titulo = N'Tipos de datos de texto'
ORDER BY l.LeccionId;

IF NOT EXISTS (SELECT 1 FROM #LeccionTexto)
BEGIN
    PRINT 'ERROR: No se encontró la lección "Tipos de datos de texto" en CursoId 1.';
    PRINT 'Ejecuta primero insert_lecciones_variables.sql o revisa Lecciones.Titulo.';
    RETURN;
END

DECLARE @Lid INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
PRINT 'Prácticas se asociarán a LeccionId = ' + CAST(@Lid AS VARCHAR(10));
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE — Nombre completo
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(@LeccionId,
'MultipleChoice',
'¿Qué tipo usarías para un nombre completo?',
N'Necesitas guardar el texto de un nombre y apellido en una variable. ¿Cuál es el tipo adecuado en C#?',
1,
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, 'string', 1, 1, 'Correcto. string almacena cadenas de texto y se escribe entre comillas dobles.'),
(@PracticaId1, 'char', 0, 2, 'Incorrecto. char guarda un solo carácter, no un nombre completo.'),
(@PracticaId1, 'char[]', 0, 3, 'Incorrecto. Para texto normal en C# se usa string; char[] no es lo habitual aquí.'),
(@PracticaId1, 'text', 0, 4, 'Incorrecto. En C# no existe el tipo text como en SQL; usa string.');
GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE — Literales
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(@LeccionId,
'MultipleChoice',
'Literales correctos en C#',
N'¿Cuál de estas opciones muestra literales válidos para un string y un char?',
2,
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, N'string curso = "C#"; char nota = ''A'';', 1, 1, N'Correcto. string con comillas dobles; char con comillas simples y un carácter.'),
(@PracticaId2, N'char curso = "C#"; string nota = ''A'';', 0, 2, N'Incorrecto. char no puede almacenar varios caracteres como "C#".'),
(@PracticaId2, N'string curso = ''C#''; char nota = "A";', 0, 3, N'Incorrecto. string debe ir entre comillas dobles; char entre simples.'),
(@PracticaId2, N'string curso = C#; char nota = A;', 0, 4, N'Incorrecto. Los literales deben ir entre comillas.');
GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO — char y string
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(@LeccionId,
'CompletarCodigo',
'Declara char y string',
N'Completa: una variable char llamada inicial con valor ''J'' y un string llamado ciudad con valor "Medellín":',
3,
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;

DECLARE @CodigoBase3 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, N'char', 1, 0),
(@PracticaId3, @CodigoBase3, 2, N'inicial', 2, 0),
(@PracticaId3, @CodigoBase3, 3, N'''J''', 3, 0),
(@PracticaId3, @CodigoBase3, 4, N'string', 4, 0),
(@PracticaId3, @CodigoBase3, 5, N'ciudad', 5, 0),
(@PracticaId3, @CodigoBase3, 6, N'"Medellín"', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 7, N'int', 0, 1),
(@PracticaId3, @CodigoBase3, 8, N'"J"', 0, 1),
(@PracticaId3, @CodigoBase3, 9, N'''Medellín''', 0, 1),
(@PracticaId3, @CodigoBase3, 10, N'bool', 0, 1),
(@PracticaId3, @CodigoBase3, 11, N'nombre', 0, 1);
GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO — Dos strings
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(@LeccionId,
'CompletarCodigo',
'Dos cadenas',
N'Completa: string saludo con "Hola" y string tema con el texto "C#":',
4,
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;

DECLARE @CodigoBase4 NVARCHAR(MAX) = N'[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10)
    + N'[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];';

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, N'string', 1, 0),
(@PracticaId4, @CodigoBase4, 2, N'saludo', 2, 0),
(@PracticaId4, @CodigoBase4, 3, N'"Hola"', 3, 0),
(@PracticaId4, @CodigoBase4, 4, N'string', 4, 0),
(@PracticaId4, @CodigoBase4, 5, N'tema', 5, 0),
(@PracticaId4, @CodigoBase4, 6, N'"C#"', 6, 0);

INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 7, N'char', 0, 1),
(@PracticaId4, @CodigoBase4, 8, N'''Hola''', 0, 1),
(@PracticaId4, @CodigoBase4, 9, N'Hola', 0, 1),
(@PracticaId4, @CodigoBase4, 10, N'double', 0, 1);
GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(@LeccionId,
'EscribirCodigo',
'Letra y mensaje',
N'Escribe solo declaraciones terminadas en ; :
1) char llamado letra con valor ''Z''
2) string llamado mensaje con valor "Bienvenido"',
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
        // Escribe tus declaraciones aquí
    }
}',
N'char letra = ''Z'';
string mensaje = "Bienvenido";',
N'[ { "test": "Declaraciones char y string", "expected": "validado por el servidor" } ]',
N'char: comillas simples y un carácter. string: comillas dobles.');
GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO — Concatenación
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);
DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo)
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(@LeccionId,
'EscribirCodigo',
'Concatenar strings',
N'Escribe exactamente estas tres declaraciones (con ; al final):
string parte1 = "Hola";
string parte2 = " mundo";
string frase = parte1 + parte2;',
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
N'string parte1 = "Hola";
string parte2 = " mundo";
string frase = parte1 + parte2;',
N'[ { "test": "Concatenación", "expected": "validado por el servidor" } ]',
N'Usa el operador + entre string y variable string.');
GO

-- ============================================
-- RESUMEN
-- ============================================

DECLARE @LeccionId INT = (SELECT TOP 1 LeccionId FROM #LeccionTexto);

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

IF OBJECT_ID('tempdb..#LeccionTexto') IS NOT NULL
    DROP TABLE #LeccionTexto;
GO
