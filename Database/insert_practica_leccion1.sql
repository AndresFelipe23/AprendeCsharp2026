-- ============================================
-- INSERTAR EJERCICIO DE OPCIÓN MÚLTIPLE PARA LECCIÓN 1
-- Lección: "¿Qué es una variable?"
-- Curso: "Variables y Tipos de Datos" (CursoId = 1)
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

-- Insertar ejercicio de opción múltiple sobre variables
-- Usamos una tabla temporal para obtener el ID insertado
DECLARE @PracticaId INT;
DECLARE @TempTable TABLE (PracticaId INT);

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden, Activo) 
OUTPUT INSERTED.PracticaId INTO @TempTable
VALUES
(1, 
'MultipleChoice', 
'¿Qué es una variable en programación?',
'Selecciona la opción que mejor describe qué es una variable:', 
1, 
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

-- Insertar opciones para el ejercicio
-- Opción correcta
INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId, 
'Un espacio en memoria con un nombre donde se almacena un valor que puede cambiar', 
1, 
1, 
'¡Correcto! Una variable es exactamente eso: un espacio en memoria con un nombre (identificador) donde puedes almacenar un valor. El valor puede cambiar durante la ejecución del programa, a diferencia de las constantes.');

-- Opciones incorrectas
INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId, 
'Un valor fijo que nunca cambia durante la ejecución del programa', 
0, 
2, 
'Incorrecto. Eso describe una constante, no una variable. Las variables pueden cambiar su valor, mientras que las constantes permanecen igual durante toda la ejecución.');

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId, 
'Solo un nombre sin almacenar ningún valor', 
0, 
3, 
'Incorrecto. Una variable debe tener un valor almacenado (aunque puede ser null en algunos casos). El nombre es solo el identificador que usas para acceder al valor almacenado.');

INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(@PracticaId, 
'Un tipo de dato que solo puede almacenar números', 
0, 
4, 
'Incorrecto. Una variable puede almacenar diferentes tipos de datos: números, texto, booleanos, etc. El tipo de dato se especifica al declarar la variable, pero no limita qué es una variable en sí.');
GO

-- Verificar el ejercicio insertado
SELECT 
    p.PracticaId,
    p.Titulo,
    p.TipoEjercicio,
    p.Enunciado,
    p.Orden,
    l.Titulo AS LeccionTitulo,
    COUNT(po.OpcionId) AS NumOpciones
FROM Practicas p
INNER JOIN Lecciones l ON p.LeccionId = l.LeccionId
LEFT JOIN PracticaOpciones po ON p.PracticaId = po.PracticaId
WHERE p.LeccionId = 1
GROUP BY p.PracticaId, p.Titulo, p.TipoEjercicio, p.Enunciado, p.Orden, l.Titulo
ORDER BY p.Orden;
GO

-- Mostrar todas las opciones del ejercicio
SELECT 
    po.OpcionId,
    po.TextoOpcion,
    po.EsCorrecta,
    po.Orden,
    po.Explicacion
FROM PracticaOpciones po
INNER JOIN Practicas p ON po.PracticaId = p.PracticaId
WHERE p.LeccionId = 1 AND p.Orden = 1
ORDER BY po.Orden;
GO

PRINT 'Ejercicio de opción múltiple insertado exitosamente para la Lección 1';
GO

