-- ============================================
-- INSERTAR EJERCICIO DE TIPO ESCRIBIR CÓDIGO PARA LECCIÓN 1
-- Lección: "¿Qué es una variable?"
-- Curso: "Variables y Tipos de Datos" (CursoId = 1)
-- Tipo: EscribirCodigo
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que la Lección 1 existe
IF NOT EXISTS (SELECT 1 FROM Lecciones WHERE LeccionId = 1)
BEGIN
    PRINT 'ERROR: La Lección con ID 1 no existe. Por favor ejecuta primero insert_lecciones_variables.sql';
    RETURN;
END
GO

-- Insertar ejercicio de tipo escribir código sobre declaración de variables
-- Usamos una tabla temporal para obtener el ID insertado
DECLARE @PracticaId INT;
DECLARE @TempTable TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable
VALUES
(1, 
'EscribirCodigo', 
'Declara tus primeras variables',
'Escribe código que declare las siguientes variables:
1. Una variable de tipo entero (int) llamada "edad" con el valor 25
2. Una variable de tipo texto (string) llamada "nombre" con el valor "María"
3. Una variable de tipo decimal (double) llamada "precio" con el valor 99.99

Recuerda usar el formato: tipo nombreVariable = valor;', 
3, 
1);

-- Obtener el ID de la práctica recién insertada
SELECT @PracticaId = PracticaId FROM @TempTable;

-- Verificar que obtuvimos el ID
IF @PracticaId IS NULL
BEGIN
    PRINT 'ERROR: No se pudo obtener el ID de la práctica insertada';
    RETURN;
END

PRINT 'Práctica insertada con ID: ' + CAST(@PracticaId AS VARCHAR);

-- Insertar datos del ejercicio de escribir código
INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(@PracticaId, 
-- Código base (estructura inicial que el usuario puede modificar)
'using System;

class Program
{
    static void Main()
    {
        // Escribe tu código aquí
    }
}',
-- Solución esperada
'int edad = 25;
string nombre = "María";
double precio = 99.99;',
-- Casos de prueba en JSON (opcional, para validación automática)
'[
  {
    "test": "Verificar que edad sea de tipo int con valor 25",
    "expected": "edad es int && edad == 25"
  },
  {
    "test": "Verificar que nombre sea de tipo string con valor María",
    "expected": "nombre es string && nombre == \"María\""
  },
  {
    "test": "Verificar que precio sea de tipo double con valor 99.99",
    "expected": "precio es double && precio == 99.99"
  }
]',
-- Pista opcional
'Recuerda:
- Para números enteros usa: int nombreVariable = valor;
- Para texto usa: string nombreVariable = "valor";
- Para decimales usa: double nombreVariable = valor;
- Cada declaración debe terminar con punto y coma (;)
- Los strings van entre comillas dobles (")');

GO

-- Verificar el ejercicio insertado
SELECT 
    p.PracticaId,
    p.Titulo,
    p.TipoEjercicio,
    p.Enunciado,
    p.Orden,
    l.Titulo AS LeccionTitulo,
    pc.CodigoBase,
    pc.SolucionEsperada,
    pc.PistaOpcional
FROM Practicas p
INNER JOIN Lecciones l ON p.LeccionId = l.LeccionId
LEFT JOIN PracticaCodigo pc ON p.PracticaId = pc.PracticaId
WHERE p.LeccionId = 1 AND p.TipoEjercicio = 'EscribirCodigo' AND p.Orden = 3;
GO

PRINT 'Ejercicio de tipo escribir código insertado exitosamente para la Lección 1';
GO

