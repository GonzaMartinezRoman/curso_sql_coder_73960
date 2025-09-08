-- ==============================================================================
-- 04-MÓDULO COMPRAS - SUMINET ERP - GONZALO MARTINEZ ROMAN - INSERCIÓN DE DATOS
-- ==============================================================================

-- 16-Estados_Orden
-- Valores posibles para el estado de una orden de compra
INSERT INTO Estados_Orden (id_estado, descripcion_estado) VALUES
(1, 'Borrador'),
(2, 'Enviada'),
(3, 'Recibida'),
(4, 'Cancelada');

-- 17-Ordenes_Compra
-- Órdenes de compra de ejemplo
INSERT INTO Ordenes_Compra (numero_orden, id_proveedor, fecha_orden, fecha_entrega_solicitada, id_estado, solicitante, observaciones) VALUES
('OC-2024-001', 1, '2024-07-01', '2024-07-15', 2, 'Juan Pérez', 'Materiales para mantenimiento preventivo'),
('OC-2024-002', 2, '2024-07-03', '2024-07-20', 2, 'María González', 'Válvulas para proyecto ampliación'),
('OC-2024-003', 3, '2024-07-05', '2024-07-12', 3, 'Carlos Rodríguez', 'Reposición stock cañerías'),
('OC-2024-004', 4, '2024-07-08', '2024-07-25', 2, 'Ana Martínez', 'Instrumentos para nueva línea'),
('OC-2024-005', 5, '2024-07-10', '2024-07-18', 1, 'Luis Fernández', 'Químicos para tratamiento agua'),
('OC-2024-006', 1, '2024-07-12', '2024-07-30', 2, 'Roberto Silva', 'Materiales eléctricos urgentes'),
('OC-2024-007', 2, '2024-07-15', '2024-08-01', 1, 'Elena Castro', 'Válvulas de seguridad'),
('OC-2024-008', 3, '2024-07-18', '2024-08-05', 2, 'Diego Morales', 'Tubos y accesorios');

-- 18-Detalle_Orden_Compra
-- Detalle de órdenes de compra con precios
INSERT INTO Detalle_Orden_Compra (id_orden, id_material, cantidad_solicitada, precio_unitario, observaciones) VALUES
-- OC-2024-001 (Electrotécnica Industrial)
(1, 1, 100.00, 85.50, 'Cable THHN para instalación principal'),
(1, 2, 5.00, 1250.00, 'Interruptores para tablero general'),
(1, 11, 10.00, 890.00, 'Breakers de respaldo'),

-- OC-2024-002 (Válvulas del Norte)  
(2, 116, 2.00, 45000.00, 'Válvulas para línea principal'),
(2, 117, 3.00, 32000.00, 'Válvulas mariposa sector B'),
(2, 120, 4.00, 18500.00, 'Válvulas de bola uso general'),

-- OC-2024-003 (Distribuidora Materiales) - RECIBIDA
(3, 61, 50.00, 1250.00, 'Tubería acero para reemplazo'),
(3, 81, 20.00, 450.00, 'Codos 90° para conexiones'),
(3, 82, 15.00, 680.00, 'Tees para derivaciones'),

-- OC-2024-004 (Instrumentos de Precisión)
(4, 36, 3.00, 28000.00, 'Transmisores de presión'),
(4, 38, 5.00, 15600.00, 'Termopares tipo K'),
(4, 39, 2.00, 8900.00, 'Manómetros industriales'),

-- OC-2024-005 (Química Industrial) - BORRADOR
(5, 141, 10.00, 2800.00, 'Ácido sulfúrico para proceso'),
(5, 142, 25.00, 1950.00, 'Hidróxido de sodio'),

-- OC-2024-006 (Electrotécnica Industrial)
(6, 21, 8.00, 12500.00, 'Luminarias LED exteriores'),
(6, 3, 75.00, 125.00, 'Canaletas metálicas'),

-- OC-2024-007 (Válvulas del Norte) - BORRADOR
(7, 123, 1.00, 95000.00, 'Válvula de seguridad alta presión'),

-- OC-2024-008 (Distribuidora Materiales)
(8, 102, 25.00, 850.00, 'Tubos cuadrados estructurales'),
(8, 103, 30.00, 650.00, 'Planchuelas de acero');

-- ==============================================================================
-- DATOS DE EJEMPLO PARA COMPLETAR EL MÓDULO
-- ==============================================================================

-- Actualizar recepciones para la orden completada (OC-2024-003)
UPDATE Detalle_Orden_Compra 
SET cantidad_recibida = cantidad_solicitada, fecha_recepcion = '2024-07-12'
WHERE id_orden = 3;

-- Recepción parcial para otra orden (OC-2024-001)
UPDATE Detalle_Orden_Compra 
SET cantidad_recibida = 80.00, fecha_recepcion = '2024-07-16'
WHERE id_orden = 1 AND id_material = 1;

UPDATE Detalle_Orden_Compra 
SET cantidad_recibida = 5.00, fecha_recepcion = '2024-07-16'
WHERE id_orden = 1 AND id_material = 2;