-- Script para actualizar las columnas de fecha a datetimeoffset
-- Ejecuta este script en tu base de datos SQL Server

USE LenguajeCsharp;
GO

-- 1. Eliminar el constraint de default de FechaRegistro si existe
IF EXISTS (SELECT * FROM sys.default_constraints WHERE name = 'DF__Usuarios__FechaR__693CA210')
BEGIN
    ALTER TABLE Usuarios DROP CONSTRAINT DF__Usuarios__FechaR__693CA210;
    PRINT 'Constraint DF__Usuarios__FechaR__693CA210 eliminado';
END
GO

-- 2. Buscar y eliminar cualquier otro constraint de default en FechaRegistro
DECLARE @ConstraintName NVARCHAR(200);
SELECT @ConstraintName = name 
FROM sys.default_constraints 
WHERE parent_object_id = OBJECT_ID('Usuarios') 
AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('Usuarios'), 'FechaRegistro', 'ColumnId');

IF @ConstraintName IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Usuarios DROP CONSTRAINT ' + @ConstraintName);
    PRINT 'Constraint ' + @ConstraintName + ' eliminado';
END
GO

-- 3. Eliminar el constraint específico de UltimaConexion si existe
IF EXISTS (SELECT * FROM sys.default_constraints WHERE name = 'DF_ac285cb4510b0b3bc363a74d289')
BEGIN
    ALTER TABLE Usuarios DROP CONSTRAINT DF_ac285cb4510b0b3bc363a74d289;
    PRINT 'Constraint DF_ac285cb4510b0b3bc363a74d289 eliminado';
END
GO

-- 4. Buscar y eliminar cualquier otro constraint de default en UltimaConexion
DECLARE @ConstraintName2 NVARCHAR(200);
SELECT @ConstraintName2 = name 
FROM sys.default_constraints 
WHERE parent_object_id = OBJECT_ID('Usuarios') 
AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('Usuarios'), 'UltimaConexion', 'ColumnId');

IF @ConstraintName2 IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Usuarios DROP CONSTRAINT ' + @ConstraintName2);
    PRINT 'Constraint ' + @ConstraintName2 + ' eliminado';
END
GO

-- 5. Cambiar FechaRegistro a datetimeoffset
ALTER TABLE Usuarios
ALTER COLUMN FechaRegistro DATETIMEOFFSET NOT NULL;
GO

-- 6. Agregar default para FechaRegistro con zona horaria de Colombia
ALTER TABLE Usuarios
ADD CONSTRAINT DF_Usuarios_FechaRegistro DEFAULT (SYSDATETIMEOFFSET() AT TIME ZONE 'SA Pacific Standard Time') FOR FechaRegistro;
GO

-- 7. Cambiar UltimaConexion a datetimeoffset
ALTER TABLE Usuarios
ALTER COLUMN UltimaConexion DATETIMEOFFSET NULL;
GO

PRINT 'Columnas actualizadas exitosamente a datetimeoffset';
GO

