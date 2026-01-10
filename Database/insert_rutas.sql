-- ============================================
-- INSERTAR 3 RUTAS DE APRENDIZAJE DE C#
-- ============================================

USE LenguajeCsharp
GO

-- Ruta 1: Fundamentos de C#
INSERT INTO Rutas (Nombre, DescripcionCorta, Orden, Activo) VALUES
('Fundamentos de C#', 'Aprende los conceptos básicos del lenguaje C# desde cero', 1, 1);
GO

-- Ruta 2: Programación Orientada a Objetos
INSERT INTO Rutas (Nombre, DescripcionCorta, Orden, Activo) VALUES
('Programación Orientada a Objetos', 'Domina las clases, objetos, herencia y polimorfismo en C#', 2, 1);
GO

-- Ruta 3: Temas Avanzados
INSERT INTO Rutas (Nombre, DescripcionCorta, Orden, Activo) VALUES
('Temas Avanzados', 'Explora características avanzadas como LINQ, async/await y más', 3, 1);
GO

-- Verificar las rutas insertadas
SELECT RutaId, Nombre, DescripcionCorta, Orden, Activo, FechaCreacion
FROM Rutas
ORDER BY Orden;
GO

