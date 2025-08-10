-- Quiero actualizar los valores de id_movimiento en "Tipos_Movimiento" para que tengan 3 posiciones 101, 102, 103, etc.

-- 1. Deshabilitar temporalmente las restricciones de clave foránea
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Actualizar los registros en Tipos_Movimiento
UPDATE Tipos_Movimiento 
SET id_tipo_mov = id_tipo_mov + 100
WHERE id_tipo_mov BETWEEN 1 AND 5;

-- 3. Actualizar las referencias en Movimientos
UPDATE Movimientos
SET tipo_movimiento = tipo_movimiento + 100
WHERE tipo_movimiento BETWEEN 1 AND 5;

-- 4. Reactivar las restricciones de clave foránea
SET FOREIGN_KEY_CHECKS = 1;

-- 5. Actualizar el autoincremental (opcional)
ALTER TABLE Tipos_Movimiento AUTO_INCREMENT = 106;