-- ============================================
-- INSERTAR EJERCICIOS PARA LECCIÓN 2: TIPOS DE DATOS NUMÉRICOS ENTEROS
-- Lección: "Tipos de datos numéricos enteros"
-- LeccionId: 2
-- Curso: "Variables y Tipos de Datos" (CursoId = 1)
-- ============================================
-- Se crearán 6 ejercicios: 2 MultipleChoice, 2 CompletarCodigo, 2 EscribirCodigo
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que la Lección 2 existe
IF NOT EXISTS (SELECT 1 FROM Lecciones WHERE LeccionId = 2)
BEGIN
    PRINT 'ERROR: La Lección con ID 2 no existe. Por favor verifica que la lección exista.';
    RETURN;
END
GO

-- ============================================
-- EJERCICIO 1: MULTIPLE CHOICE - Identificar el tipo de dato correcto
-- ============================================

DECLARE @PracticaId1 INT;
DECLARE @TempTable1 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable1
VALUES
(2, 
'MultipleChoice', 
'¿Qué tipo de dato usarías para almacenar la edad de una persona?',
'Selecciona el tipo de dato numérico entero más adecuado para almacenar la edad de una persona (rango típico: 0-120 años):', 
1, 
1);

SELECT @PracticaId1 = PracticaId FROM @TempTable1;
PRINT 'Ejercicio 1 (MultipleChoice) insertado con ID: ' + CAST(@PracticaId1 AS VARCHAR);

-- Opciones para ejercicio 1
INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId1, 'int', 1, 1, '¡Correcto! El tipo int es perfecto para almacenar edades. Puede almacenar números desde -2,147,483,648 hasta 2,147,483,647, lo cual es más que suficiente para cualquier edad. Es el tipo más común para números enteros en C#.'),
(@PracticaId1, 'byte', 0, 2, 'Incorrecto. El tipo byte solo puede almacenar valores de 0 a 255, lo cual podría funcionar para edades, pero no es la opción más común ni práctica. Además, no permite valores negativos si fuera necesario.'),
(@PracticaId1, 'long', 0, 3, 'Incorrecto. El tipo long puede almacenar números extremadamente grandes (64 bits), pero es innecesario para almacenar una edad. Usa long solo cuando necesites números realmente grandes.'),
(@PracticaId1, 'double', 0, 4, 'Incorrecto. El tipo double es para números decimales (con punto decimal), no para números enteros. Para edades que siempre son números enteros, usa int.');

GO

-- ============================================
-- EJERCICIO 2: MULTIPLE CHOICE - Rango de valores
-- ============================================

DECLARE @PracticaId2 INT;
DECLARE @TempTable2 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable2
VALUES
(2, 
'MultipleChoice', 
'¿Cuál es el rango de valores del tipo int en C#?',
'Selecciona el rango correcto de valores que puede almacenar el tipo int:', 
2, 
1);

SELECT @PracticaId2 = PracticaId FROM @TempTable2;
PRINT 'Ejercicio 2 (MultipleChoice) insertado con ID: ' + CAST(@PracticaId2 AS VARCHAR);

-- Opciones para ejercicio 2
INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId2, 'Desde -2,147,483,648 hasta 2,147,483,647 (32 bits)', 1, 1, '¡Correcto! El tipo int usa 32 bits (4 bytes) y puede almacenar valores desde -2,147,483,648 hasta 2,147,483,647. Es el tipo entero más utilizado en C#.'),
(@PracticaId2, 'Desde 0 hasta 255 (8 bits)', 0, 2, 'Incorrecto. Ese es el rango del tipo byte, no de int. El byte usa 8 bits y solo puede almacenar valores positivos desde 0 hasta 255.'),
(@PracticaId2, 'Desde -32,768 hasta 32,767 (16 bits)', 0, 3, 'Incorrecto. Ese es el rango del tipo short, no de int. El short usa 16 bits (2 bytes) y puede almacenar valores desde -32,768 hasta 32,767.'),
(@PracticaId2, 'Solo números positivos de 0 a 2,147,483,647', 0, 4, 'Incorrecto. El tipo int puede almacenar tanto valores positivos como negativos. El tipo uint (unsigned int) es el que solo permite valores positivos.');

GO

-- ============================================
-- EJERCICIO 3: COMPLETAR CÓDIGO - Declaración de variables enteras
-- ============================================

DECLARE @PracticaId3 INT;
DECLARE @TempTable3 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable3
VALUES
(2, 
'CompletarCodigo', 
'Completa la declaración de variables enteras',
'Arrastra los bloques para completar la declaración de tres variables: una de tipo int llamada "cantidad" con valor 100, una de tipo byte llamada "edad" con valor 25, y una de tipo long llamada "numeroGrande" con valor 9999999999L:', 
3, 
1);

SELECT @PracticaId3 = PracticaId FROM @TempTable3;
PRINT 'Ejercicio 3 (CompletarCodigo) insertado con ID: ' + CAST(@PracticaId3 AS VARCHAR);

DECLARE @CodigoBase3 NVARCHAR(MAX) = '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];' + CHAR(13) + CHAR(10) + '[BLOQUE_4] [BLOQUE_5] = [BLOQUE_6];' + CHAR(13) + CHAR(10) + '[BLOQUE_7] [BLOQUE_8] = [BLOQUE_9];';

-- Bloques correctos
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 1, 'int', 1, 0),
(@PracticaId3, @CodigoBase3, 2, 'cantidad', 2, 0),
(@PracticaId3, @CodigoBase3, 3, '100', 3, 0),
(@PracticaId3, @CodigoBase3, 4, 'byte', 4, 0),
(@PracticaId3, @CodigoBase3, 5, 'edad', 5, 0),
(@PracticaId3, @CodigoBase3, 6, '25', 6, 0),
(@PracticaId3, @CodigoBase3, 7, 'long', 7, 0),
(@PracticaId3, @CodigoBase3, 8, 'numeroGrande', 8, 0),
(@PracticaId3, @CodigoBase3, 9, '9999999999L', 9, 0);

-- Bloques distractores
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId3, @CodigoBase3, 10, 'string', 0, 1),
(@PracticaId3, @CodigoBase3, 11, 'double', 0, 1),
(@PracticaId3, @CodigoBase3, 12, 'bool', 0, 1),
(@PracticaId3, @CodigoBase3, 13, 'short', 0, 1),
(@PracticaId3, @CodigoBase3, 14, 'precio', 0, 1),
(@PracticaId3, @CodigoBase3, 15, 'nombre', 0, 1),
(@PracticaId3, @CodigoBase3, 16, '"100"', 0, 1),
(@PracticaId3, @CodigoBase3, 17, '100.0', 0, 1);

GO

-- ============================================
-- EJERCICIO 4: COMPLETAR CÓDIGO - Operaciones con tipos enteros
-- ============================================

DECLARE @PracticaId4 INT;
DECLARE @TempTable4 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable4
VALUES
(2, 
'CompletarCodigo', 
'Completa la operación aritmética',
'Arrastra los bloques para completar el código que declara dos variables enteras, las suma y muestra el resultado:', 
4, 
1);

SELECT @PracticaId4 = PracticaId FROM @TempTable4;
PRINT 'Ejercicio 4 (CompletarCodigo) insertado con ID: ' + CAST(@PracticaId4 AS VARCHAR);

DECLARE @CodigoBase4 NVARCHAR(MAX) = '[BLOQUE_1] a = 10;' + CHAR(13) + CHAR(10) + '[BLOQUE_2] b = 20;' + CHAR(13) + CHAR(10) + '[BLOQUE_3] resultado = [BLOQUE_4] + [BLOQUE_5];' + CHAR(13) + CHAR(10) + 'Console.WriteLine(resultado);';

-- Bloques correctos
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 1, 'int', 1, 0),
(@PracticaId4, @CodigoBase4, 2, 'int', 2, 0),
(@PracticaId4, @CodigoBase4, 3, 'int', 3, 0),
(@PracticaId4, @CodigoBase4, 4, 'a', 4, 0),
(@PracticaId4, @CodigoBase4, 5, 'b', 5, 0);

-- Bloques distractores
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(@PracticaId4, @CodigoBase4, 6, 'string', 0, 1),
(@PracticaId4, @CodigoBase4, 7, 'double', 0, 1),
(@PracticaId4, @CodigoBase4, 8, '10', 0, 1),
(@PracticaId4, @CodigoBase4, 9, '20', 0, 1),
(@PracticaId4, @CodigoBase4, 10, 'resultado', 0, 1);

GO

-- ============================================
-- EJERCICIO 5: ESCRIBIR CÓDIGO - Declarar diferentes tipos enteros
-- ============================================

DECLARE @PracticaId5 INT;
DECLARE @TempTable5 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable5
VALUES
(2, 
'EscribirCodigo', 
'Escribe código para declarar diferentes tipos enteros',
'Escribe código que declare las siguientes variables de tipos enteros:

1. Una variable de tipo byte llamada "cantidadItems" con el valor 128
2. Una variable de tipo short llamada "temperatura" con el valor -50
3. Una variable de tipo int llamada "poblacion" con el valor 500000
4. Una variable de tipo long llamada "distanciaKm" con el valor 15000000000L

Recuerda:
- Para long, el valor debe terminar con L (mayúscula)
- Cada declaración debe terminar con punto y coma (;)', 
5, 
1);

SELECT @PracticaId5 = PracticaId FROM @TempTable5;
PRINT 'Ejercicio 5 (EscribirCodigo) insertado con ID: ' + CAST(@PracticaId5 AS VARCHAR);

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId5, 
'using System;

class Program
{
    static void Main()
    {
        // Escribe tu código aquí
    }
}',
'byte cantidadItems = 128;
short temperatura = -50;
int poblacion = 500000;
long distanciaKm = 15000000000L;',
'[
  {
    "test": "Verificar que cantidadItems sea de tipo byte con valor 128",
    "expected": "cantidadItems es byte && cantidadItems == 128"
  },
  {
    "test": "Verificar que temperatura sea de tipo short con valor -50",
    "expected": "temperatura es short && temperatura == -50"
  },
  {
    "test": "Verificar que poblacion sea de tipo int con valor 500000",
    "expected": "poblacion es int && poblacion == 500000"
  },
  {
    "test": "Verificar que distanciaKm sea de tipo long con valor 15000000000L",
    "expected": "distanciaKm es long && distanciaKm == 15000000000L"
  }
]',
'Pistas:
- byte: para números pequeños de 0 a 255
- short: para números de -32,768 a 32,767
- int: para números enteros comunes (más utilizado)
- long: para números muy grandes, termina el valor con L (ej: 9999999999L)
- Cada declaración termina con punto y coma (;)');

GO

-- ============================================
-- EJERCICIO 6: ESCRIBIR CÓDIGO - Operaciones con tipos enteros
-- ============================================

DECLARE @PracticaId6 INT;
DECLARE @TempTable6 TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable6
VALUES
(2, 
'EscribirCodigo', 
'Realiza operaciones aritméticas con tipos enteros',
'Escribe código que:
1. Declare dos variables de tipo int: "numero1" con valor 50 y "numero2" con valor 30
2. Calcule y guarde en una variable "suma" el resultado de sumar numero1 y numero2
3. Calcule y guarde en una variable "resta" el resultado de restar numero2 de numero1
4. Calcule y guarde en una variable "multiplicacion" el resultado de multiplicar numero1 por numero2
5. Muestre los tres resultados usando Console.WriteLine

Formato esperado: Console.WriteLine("Suma: " + suma);', 
6, 
1);

SELECT @PracticaId6 = PracticaId FROM @TempTable6;
PRINT 'Ejercicio 6 (EscribirCodigo) insertado con ID: ' + CAST(@PracticaId6 AS VARCHAR);

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId6, 
'using System;

class Program
{
    static void Main()
    {
        // Declara las variables aquí
        // Realiza las operaciones aquí
        // Muestra los resultados aquí
    }
}',
'int numero1 = 50;
int numero2 = 30;
int suma = numero1 + numero2;
int resta = numero1 - numero2;
int multiplicacion = numero1 * numero2;

Console.WriteLine("Suma: " + suma);
Console.WriteLine("Resta: " + resta);
Console.WriteLine("Multiplicacion: " + multiplicacion);',
'[
  {
    "test": "Verificar que suma sea 80",
    "expected": "suma == 80"
  },
  {
    "test": "Verificar que resta sea 20",
    "expected": "resta == 20"
  },
  {
    "test": "Verificar que multiplicacion sea 1500",
    "expected": "multiplicacion == 1500"
  }
]',
'Pistas:
- Usa el operador + para sumar
- Usa el operador - para restar
- Usa el operador * para multiplicar
- Puedes concatenar texto con números usando + dentro de Console.WriteLine
- Todas las variables deben ser de tipo int');

GO

-- ============================================
-- VERIFICACIÓN FINAL
-- ============================================

PRINT '========================================';
PRINT 'RESUMEN DE EJERCICIOS INSERTADOS';
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
WHERE p.LeccionId = 2
ORDER BY p.Orden;

PRINT '========================================';
PRINT 'Total de ejercicios insertados: 6';
PRINT '- 2 ejercicios MultipleChoice';
PRINT '- 2 ejercicios CompletarCodigo';
PRINT '- 2 ejercicios EscribirCodigo';
PRINT '========================================';
GO

