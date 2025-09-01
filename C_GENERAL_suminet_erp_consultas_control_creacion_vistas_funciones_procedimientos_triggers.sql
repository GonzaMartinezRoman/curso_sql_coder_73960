-- Consultas para verificar creación y funcionamiento de Vistas, Funciones, Procedimientos Almacenados y Triggers.

-- Vistas
SELECT *
FROM Consulta_Materiales;
SELECT *
FROM Stock_Materiales;
SELECT *
FROM Stock_Materiales_Resumen;

-- Procedimientos almacenados
CALL crear_material('Válvula Esférica flotante 2" A351CF8M RPTFE', 'Válvula esferica, esfera flotante, cuerpo y esfera en acero inoxidable ASTM A351 CF8M, asiento de RPTFE', 'UN', 3000);

-- Funciones
SELECT calcular_stock_disponible(101) AS StockTotal;

-- Triggers
UPDATE Stock
SET cantidad_actual = cantidad_actual + 4
WHERE id_material = 145 AND id_ubicacion = 3;

SELECT *
FROM Log_Stock;
