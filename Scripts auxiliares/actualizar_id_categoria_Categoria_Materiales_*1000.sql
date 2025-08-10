-- Quiero actualizar los valores de id_categoria en "Categorias_Materiales" para que tengan 3 posiciones 1000, 2000, 3000, etc.

-- 1. Deshabilitar temporalmente las restricciones de clave foránea
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Actualizar los registros en Tipos_Movimiento
UPDATE Categorias_Materiales 
SET id_categoria = id_categoria * 1000
WHERE id_categoria BETWEEN 1 AND 8;

-- 3. Actualizar las referencias en Movimientos
UPDATE Materiales
SET id_categoria = id_categoria * 1000
WHERE id_categoria BETWEEN 1 AND 8;

-- 4. Reactivar las restricciones de clave foránea
SET FOREIGN_KEY_CHECKS = 1;

-- 5. Actualizar el autoincremental (opcional)
ALTER TABLE id_categoria AUTO_INCREMENT = 9000;