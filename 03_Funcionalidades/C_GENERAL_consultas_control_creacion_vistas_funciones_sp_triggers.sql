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
CALL crear_material('Válvula Esférica flotante 2" A351CF8M RPTFE', 'Válvula esferica, esfera flotante, cuerpo y esfera en acero inoxidable ASTM A351 CF8M, asiento de RPTFE', 'UN', 3000);

-- Funciones
SELECT calcular_stock_disponible(101) AS StockTotal;
SELECT calcular_rotacion_material(2,24) AS Rotacion;
-- Consultas para verificación
-- SELECT * FROM Movimientos
-- WHERE tipo_movimiento = 102
-- AND id_material = 2;
-- SELECT calcular_stock_disponible(2);

-- Triggers
UPDATE Stock
SET cantidad_actual = cantidad_actual + 4
WHERE id_material = 145 AND id_ubicacion = 3;

SELECT *
FROM Log_Stock;
