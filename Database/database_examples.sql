-- ============================================
-- EJEMPLOS DE DATOS PARA DIFERENTES TIPOS DE EJERCICIOS
-- ============================================

-- Insertar una Ruta de ejemplo
INSERT INTO Rutas (Nombre, DescripcionCorta, Orden) VALUES
('Fundamentos de C#', 'Aprende los conceptos básicos del lenguaje C#', 1);

-- Insertar un Curso de ejemplo
INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden) VALUES
(1, 'Variables y Tipos de Datos', 'Aprende a declarar y usar variables en C#', 1);

-- Insertar una Lección de ejemplo
INSERT INTO Lecciones (CursoId, Titulo, DescripcionCorta, ContenidoBreve, CodigoEjemplo, Orden) VALUES
(1, 'Variables en C#', 'Qué es una variable y cómo declararla', 
'Una variable es un espacio en memoria donde guardas un valor. En C# debes especificar el tipo de dato que almacenará.',
'int edad = 25;
string nombre = "Juan";
double altura = 1.75;', 1);

-- ============================================
-- EJEMPLO 1: EJERCICIO DE RESPUESTA MÚLTIPLE
-- ============================================

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden) VALUES
(1, 'MultipleChoice', 
'¿Qué tipo de dato usarías para almacenar la edad de una persona?',
'Selecciona la opción correcta:', 1);

-- Opciones para el ejercicio de respuesta múltiple
INSERT INTO PracticaOpciones (PracticaId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(1, 'int', 1, 1, 'Correcto! int es ideal para números enteros como la edad.'),
(1, 'string', 0, 2, 'Incorrecto. string se usa para texto, no para números.'),
(1, 'double', 0, 3, 'Incorrecto. double es para números decimales, la edad es un número entero.'),
(1, 'bool', 0, 4, 'Incorrecto. bool solo almacena true o false.');

-- ============================================
-- EJEMPLO 2: EJERCICIO TIPO DUOLINGO (COMPLETAR CÓDIGO CON BLOQUES)
-- ============================================

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden) VALUES
(1, 'CompletarCodigo',
'Completa el código arrastrando los bloques correctos',
'Arrastra los bloques para completar la declaración de variable:', 2);

-- Bloques para el ejercicio tipo Duolingo
-- El código base tiene marcadores [BLOQUE_1], [BLOQUE_2], etc.
INSERT INTO PracticaBloques (PracticaId, CodigoBase, OrdenBloque, TextoBloque, PosicionCorrecta, EsDistractor) VALUES
(2, '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];', 1, 'int', 1, 0), -- Posición 1: tipo de dato
(2, '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];', 2, 'edad', 2, 0), -- Posición 2: nombre de variable
(2, '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];', 3, '25', 3, 0), -- Posición 3: valor
-- Bloques distractores (incorrectos)
(2, '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];', 4, 'string', 0, 1), -- Distractor
(2, '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];', 5, 'nombre', 0, 1), -- Distractor
(2, '[BLOQUE_1] [BLOQUE_2] = [BLOQUE_3];', 6, 'true', 0, 1); -- Distractor

-- Resultado esperado: int edad = 25;

-- ============================================
-- EJEMPLO 3: EJERCICIO DE ESCRIBIR CÓDIGO
-- ============================================

INSERT INTO Practicas (LeccionId, TipoEjercicio, Titulo, Enunciado, Orden) VALUES
(1, 'EscribirCodigo',
'Escribe un programa que declare variables',
'Escribe código que declare tres variables: una variable int llamada "edad" con valor 20, una string llamada "nombre" con valor "María", y una double llamada "altura" con valor 1.65.', 3);

INSERT INTO PracticaCodigo (PracticaId, CodigoBase, SolucionEsperada, CasosPrueba, PistaOpcional) VALUES
(3, 
-- Código base (puede estar vacío o tener estructura)
'// Escribe tu código aquí
',
-- Solución esperada
'int edad = 20;
string nombre = "María";
double altura = 1.65;',
-- Casos de prueba en JSON (opcional, para validación automática)
'[
  {"test": "Verificar que edad sea 20", "expected": "edad == 20"},
  {"test": "Verificar que nombre sea María", "expected": "nombre == \"María\""},
  {"test": "Verificar que altura sea 1.65", "expected": "altura == 1.65"}
]',
-- Pista opcional
'Recuerda usar el formato: tipo nombre = valor;');

-- ============================================
-- EJEMPLO DE RETO (al final del curso)
-- ============================================

-- Reto de respuesta múltiple
INSERT INTO Retos (CursoId, TipoEjercicio, Titulo, Enunciado, PistaOpcional, SolucionEjemplo) VALUES
(1, 'MultipleChoice',
'Reto: Identifica el tipo de dato',
'¿Qué tipo de dato usarías para almacenar si un usuario está activo o no?',
'Piensa en valores que solo pueden ser verdadero o falso.',
'bool usuarioActivo = true;');

INSERT INTO RetoOpciones (RetoId, TextoOpcion, EsCorrecta, Orden, Explicacion) VALUES
(1, 'bool', 1, 1, '¡Perfecto! bool es el tipo correcto para valores true/false.'),
(1, 'int', 0, 2, 'Incorrecto. int es para números enteros.'),
(1, 'string', 0, 3, 'Incorrecto. Aunque podrías usar "si"/"no", bool es más apropiado.');

-- ============================================
-- CONSULTAS ÚTILES PARA LA APP
-- ============================================

-- Obtener todas las prácticas de una lección con su tipo
-- SELECT p.*, 
--        CASE p.TipoEjercicio
--            WHEN 'MultipleChoice' THEN (SELECT COUNT(*) FROM PracticaOpciones WHERE PracticaId = p.PracticaId)
--            WHEN 'CompletarCodigo' THEN (SELECT COUNT(*) FROM PracticaBloques WHERE PracticaId = p.PracticaId AND EsDistractor = 0)
--            WHEN 'EscribirCodigo' THEN 1
--        END AS NumeroElementos
-- FROM Practicas p
-- WHERE p.LeccionId = 1
-- ORDER BY p.Orden;

-- Obtener opciones de un ejercicio de respuesta múltiple
-- SELECT * FROM PracticaOpciones 
-- WHERE PracticaId = 1 
-- ORDER BY Orden;

-- Obtener bloques de un ejercicio tipo Duolingo
-- SELECT * FROM PracticaBloques 
-- WHERE PracticaId = 2 
-- ORDER BY OrdenBloque;

-- Obtener datos de un ejercicio de escribir código
-- SELECT * FROM PracticaCodigo WHERE PracticaId = 3;

-- ============================================
-- EJEMPLOS DE USUARIOS Y PROGRESO
-- ============================================

-- Insertar usuarios de ejemplo
INSERT INTO Usuarios (NombreUsuario, Email, NombreCompleto, PuntosTotales, Nivel) VALUES
('juan123', 'juan@example.com', 'Juan Pérez', 150, 2),
('maria_dev', 'maria@example.com', 'María García', 50, 1),
('carlos_csharp', 'carlos@example.com', 'Carlos López', 300, 3);

-- Progreso de lecciones (usuario 1 ha completado la lección 1)
INSERT INTO ProgresoLecciones (UsuarioId, LeccionId, Completada, FechaCompletacion) VALUES
(1, 1, 1, GETDATE());

-- Progreso de prácticas (usuario 1 completó la práctica 1 correctamente en el primer intento)
INSERT INTO ProgresoPracticas (UsuarioId, PracticaId, Completada, Intentos, CorrectoEnPrimerIntento, PuntosObtenidos, FechaCompletacion) VALUES
(1, 1, 1, 1, 1, 10, GETDATE()),
(1, 2, 1, 2, 0, 8, GETDATE()), -- Completó en segundo intento
(2, 1, 0, 1, 0, 0, GETDATE()); -- Usuario 2 intentó pero no completó

-- Progreso de retos (usuario 1 completó el reto 1)
INSERT INTO ProgresoRetos (UsuarioId, RetoId, Completado, Intentos, CorrectoEnPrimerIntento, PuntosObtenidos, FechaCompletacion) VALUES
(1, 1, 1, 1, 1, 20, GETDATE());

-- Progreso de cursos (calcular porcentaje basado en lecciones y prácticas completadas)
-- Ejemplo: Usuario 1 tiene 1 lección completada de 1 total, y 2 prácticas completadas de 3 totales
INSERT INTO ProgresoCursos (UsuarioId, CursoId, PorcentajeCompletado, LeccionesCompletadas, TotalLecciones, PracticasCompletadas, TotalPracticas, RetosCompletados, TotalRetos) VALUES
(1, 1, 66.67, 1, 1, 2, 3, 1, 1), -- 66.67% completado
(2, 1, 0.00, 0, 1, 0, 3, 0, 1); -- 0% completado

-- Progreso de rutas (calcular porcentaje basado en cursos completados)
INSERT INTO ProgresoRutas (UsuarioId, RutaId, PorcentajeCompletado, CursosCompletados, TotalCursos) VALUES
(1, 1, 0.00, 0, 1), -- Aún no completó la ruta completa
(2, 1, 0.00, 0, 1);

-- ============================================
-- CONSULTAS ÚTILES PARA PROGRESO
-- ============================================

-- Obtener progreso de un usuario en una lección específica
-- SELECT * FROM ProgresoLecciones 
-- WHERE UsuarioId = 1 AND LeccionId = 1;

-- Obtener todas las lecciones completadas de un usuario
-- SELECT l.*, pl.FechaCompletacion 
-- FROM Lecciones l
-- INNER JOIN ProgresoLecciones pl ON l.LeccionId = pl.LeccionId
-- WHERE pl.UsuarioId = 1 AND pl.Completada = 1
-- ORDER BY pl.FechaCompletacion DESC;

-- Obtener estadísticas de un usuario
-- SELECT 
--     u.NombreUsuario,
--     u.PuntosTotales,
--     u.Nivel,
--     (SELECT COUNT(*) FROM ProgresoLecciones WHERE UsuarioId = u.UsuarioId AND Completada = 1) AS LeccionesCompletadas,
--     (SELECT COUNT(*) FROM ProgresoPracticas WHERE UsuarioId = u.UsuarioId AND Completada = 1) AS PracticasCompletadas,
--     (SELECT COUNT(*) FROM ProgresoRetos WHERE UsuarioId = u.UsuarioId AND Completado = 1) AS RetosCompletados
-- FROM Usuarios u
-- WHERE u.UsuarioId = 1;

-- Obtener progreso de un curso para un usuario
-- SELECT 
--     c.Nombre AS CursoNombre,
--     pc.PorcentajeCompletado,
--     pc.LeccionesCompletadas,
--     pc.TotalLecciones,
--     pc.PracticasCompletadas,
--     pc.TotalPracticas
-- FROM ProgresoCursos pc
-- INNER JOIN Cursos c ON pc.CursoId = c.CursoId
-- WHERE pc.UsuarioId = 1;

-- Actualizar porcentaje de progreso de un curso (ejemplo de cálculo)
-- UPDATE ProgresoCursos
-- SET PorcentajeCompletado = (
--     (LeccionesCompletadas * 50.0 / TotalLecciones) + 
--     (PracticasCompletadas * 30.0 / TotalPracticas) + 
--     (RetosCompletados * 20.0 / TotalRetos)
-- )
-- WHERE UsuarioId = 1 AND CursoId = 1;

