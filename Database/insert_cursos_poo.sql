-- ============================================
-- INSERTAR CURSOS PARA "PROGRAMACIÓN ORIENTADA A OBJETOS"
-- RutaId = 2 (Programación Orientada a Objetos)
-- ============================================

USE LenguajeCsharp
GO

-- Verificar que la Ruta 2 existe
IF NOT EXISTS (SELECT 1 FROM Rutas WHERE RutaId = 2)
BEGIN
    PRINT 'ERROR: La Ruta con ID 2 no existe. Por favor verifica que la ruta "Programación Orientada a Objetos" existe.';
    RETURN;
END
GO

PRINT 'Insertando cursos para la ruta "Programación Orientada a Objetos" (RutaId = 2)';
PRINT '';

-- Curso 1: Clases y Objetos
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Clases y Objetos' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Clases y Objetos', 'Aprende a definir clases y crear objetos, los bloques fundamentales de la POO en C#', 1, 1);
    PRINT '✓ Curso 1: Clases y Objetos - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 1: Clases y Objetos - Ya existe';
END
GO

-- Curso 2: Encapsulación y Modificadores de Acceso
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Encapsulación y Modificadores de Acceso' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Encapsulación y Modificadores de Acceso', 'Aprende a controlar el acceso a los miembros de una clase usando modificadores de acceso y propiedades', 2, 1);
    PRINT '✓ Curso 2: Encapsulación y Modificadores de Acceso - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 2: Encapsulación y Modificadores de Acceso - Ya existe';
END
GO

-- Curso 3: Constructores y Destructores
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Constructores y Destructores' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Constructores y Destructores', 'Aprende a usar constructores para inicializar objetos y destructores para limpiar recursos', 3, 1);
    PRINT '✓ Curso 3: Constructores y Destructores - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 3: Constructores y Destructores - Ya existe';
END
GO

-- Curso 4: Herencia
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Herencia' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Herencia', 'Aprende a crear clases derivadas que heredan características de clases base, permitiendo reutilización de código', 4, 1);
    PRINT '✓ Curso 4: Herencia - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 4: Herencia - Ya existe';
END
GO

-- Curso 5: Polimorfismo
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Polimorfismo' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Polimorfismo', 'Comprende el polimorfismo, que permite que objetos de diferentes clases sean tratados de forma uniforme', 5, 1);
    PRINT '✓ Curso 5: Polimorfismo - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 5: Polimorfismo - Ya existe';
END
GO

-- Curso 6: Clases Abstractas
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Clases Abstractas' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Clases Abstractas', 'Aprende a usar clases abstractas para definir plantillas que deben ser implementadas por clases derivadas', 6, 1);
    PRINT '✓ Curso 6: Clases Abstractas - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 6: Clases Abstractas - Ya existe';
END
GO

-- Curso 7: Interfaces
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Interfaces' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Interfaces', 'Aprende a definir e implementar interfaces para crear contratos que las clases deben cumplir', 7, 1);
    PRINT '✓ Curso 7: Interfaces - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 7: Interfaces - Ya existe';
END
GO

-- Curso 8: Propiedades e Indexadores
IF NOT EXISTS (SELECT 1 FROM Cursos WHERE Nombre = 'Propiedades e Indexadores' AND RutaId = 2)
BEGIN
    INSERT INTO Cursos (RutaId, Nombre, DescripcionCorta, Orden, Activo) VALUES
    (2, 'Propiedades e Indexadores', 'Domina las propiedades para acceso controlado a campos y los indexadores para acceso tipo array', 8, 1);
    PRINT '✓ Curso 8: Propiedades e Indexadores - Insertado';
END
ELSE
BEGIN
    PRINT '⚠ Curso 8: Propiedades e Indexadores - Ya existe';
END
GO

PRINT '';
PRINT '========================================';
PRINT 'VERIFICACIÓN DE CURSOS INSERTADOS';
PRINT '========================================';

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
WHERE c.RutaId = 2
ORDER BY c.Orden;
GO

PRINT '';
PRINT '¡Proceso completado!';
PRINT 'Total de cursos en la ruta: ' + CAST((SELECT COUNT(*) FROM Cursos WHERE RutaId = 2) AS VARCHAR);
GO

