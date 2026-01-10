-- Script completo para actualizar las columnas de fecha a datetimeoffset
-- Ejecuta este script COMPLETO en tu base de datos SQL Server
-- IMPORTANTE: Ejecuta todo el script de una vez

USE LenguajeCsharp;
GO

-- Eliminar TODOS los constraints de default de FechaRegistro
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql = @sql + 'ALTER TABLE Usuarios DROP CONSTRAINT ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.default_constraints 
WHERE parent_object_id = OBJECT_ID('Usuarios') 
AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('Usuarios'), 'FechaRegistro', 'ColumnId');

IF @sql <> ''
BEGIN
    EXEC sp_executesql @sql;
    PRINT 'Constraints de FechaRegistro eliminados';
END
GO

-- Eliminar TODOS los constraints de default de UltimaConexion
DECLARE @sql2 NVARCHAR(MAX) = '';
SELECT @sql2 = @sql2 + 'ALTER TABLE Usuarios DROP CONSTRAINT ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.default_constraints 
WHERE parent_object_id = OBJECT_ID('Usuarios') 
AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('Usuarios'), 'UltimaConexion', 'ColumnId');

IF @sql2 <> ''
BEGIN
    EXEC sp_executesql @sql2;
    PRINT 'Constraints de UltimaConexion eliminados';
END
GO

-- Cambiar FechaRegistro a datetimeoffset
ALTER TABLE Usuarios
ALTER COLUMN FechaRegistro DATETIMEOFFSET NOT NULL;
GO

-- Cambiar UltimaConexion a datetimeoffset
ALTER TABLE Usuarios
ALTER COLUMN UltimaConexion DATETIMEOFFSET NULL;
GO

-- Agregar nuevo default para FechaRegistro
ALTER TABLE Usuarios
ADD CONSTRAINT DF_Usuarios_FechaRegistro DEFAULT (SYSDATETIMEOFFSET()) FOR FechaRegistro;
GO

PRINT '✅ Columnas actualizadas exitosamente a datetimeoffset';
PRINT 'Reinicia la aplicación NestJS para que los cambios surtan efecto';
GO

