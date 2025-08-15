-- 1. Deshabilitar temporalmente las restricciones de clave foránea
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Eliminar todos los datos de una tabla
TRUNCATE TABLE Movimientos;