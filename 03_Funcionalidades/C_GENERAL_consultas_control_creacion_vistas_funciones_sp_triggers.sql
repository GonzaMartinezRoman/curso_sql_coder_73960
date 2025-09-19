-- ========================================================================
-- SUMINET ERP - GONZALO MARTINEZ ROMAN - CONSULTAS DE FUNCIONALIDADES
-- Consultas para verificar creación y funcionamiento de Vistas, Funciones, 
-- Procedimientos Almacenados y Triggers.
-- ========================================================================

-- Vistas
SELECT *
FROM Consulta_Materiales;
SELECT *
FROM Stock_Materiales;
SELECT *
FROM Stock_Materiales_Resumen;
SELECT *
FROM Reporte_Ordenes_Compra;
SELECT *
FROM Vendor_Pool_List;

-- Procedimientos almacenados
CALL crear_material(
	'Válvula Esférica flotante 2" A351CF8M RPTFE', 
	'Válvula esferica, esfera flotante, cuerpo y esfera en acero inoxidable ASTM A351 CF8M, asiento de RPTFE', 
	'UN', 
	3000
);
CALL registrar_nuevo_proveedor(
	'Nuevos Suministros S.A.', 
    '30-12350078-9', 
    'Av. Santa Fe 1023', 
    'Buenos Aires', 
    'CABA',
    'Nacional',
    '011-1234-5678', 
    'ventas@nuevossuministros.com.ar',
    'www.nuevossuministros.com.ar'
);
SELECT * FROM Registro_Proveedores;

-- Funciones
SELECT calcular_stock_disponible(101) AS StockTotal;
SELECT calcular_rotacion_material(2,24) AS Rotacion;
-- Consultas para verificación
-- SELECT * FROM Movimientos
-- WHERE tipo_movimiento = 102
-- AND id_material = 2;
-- SELECT calcular_stock_disponible(2);

-- Triggers
-- Trigger 1
UPDATE Stock
SET cantidad_actual = cantidad_actual + 4
WHERE id_material = 145 AND id_ubicacion = 3;

SELECT *
FROM Log_Stock;

-- Trigger 2
INSERT INTO Movimientos (fecha_movimiento, tipo_movimiento, cantidad, id_material, id_ubicacion, observaciones)
VALUES (CURDATE(), 101, 50, 1, 1, 'Entrada inicial de stock para prueba');

SELECT * FROM Movimientos;
SELECT * FROM Stock WHERE id_material = 1 AND id_ubicacion = 1;

