-- ============================================
-- INSERTAR 5 CURSOS PARA "FUNDAMENTOS DE C#"
-- RutaId = 1 (Fundamentos de C#)
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que la Ruta 1 existe
IF NOT EXISTS (SELECT 1 FROM Rutas WHERE RutaId = 1)
BEGIN
    PRINT 'ERROR: La Ruta con ID 1 no existe. Por favor ejecuta primero insert_rutas.sql';
    RETURN;
END
GO

-- Curso 1: Variables y Tipos de Datos
INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
(1, 'Variables y Tipos de Datos', 'Aprende a declarar y usar variables, y conoce los tipos de datos básicos en C#', 1, 1);
GO

-- Curso 2: Operadores y Expresiones
INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
(1, 'Operadores y Expresiones', 'Domina los operadores aritméticos, lógicos y de comparación en C#', 2, 1);
GO

-- Curso 3: Estructuras de Control
INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
(1, 'Estructuras de Control', 'Aprende a usar if, else, switch, for, while y do-while para controlar el flujo de tu programa', 3, 1);
GO

-- Curso 4: Métodos y Funciones
INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
(1, 'Métodos y Funciones', 'Crea y utiliza métodos para organizar y reutilizar tu código', 4, 1);
GO

-- Curso 5: Arrays y Colecciones
INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
(1, 'Arrays y Colecciones', 'Aprende a trabajar con arrays, listas y otras colecciones para manejar múltiples valores', 5, 1);
GO

-- Verificar los cursos insertados
SELECT 
    c.CursoId,
    c.Nombre,
    c.DescripcionCorta,
    c.Orden,
    c.Activo,
    r.Nombre AS RutaNombre
FROM Cursos c
INNER JOIN Rutas r ON c.RutaId = r.RutaId
WHERE c.RutaId = 1
ORDER BY c.Orden;
GO

