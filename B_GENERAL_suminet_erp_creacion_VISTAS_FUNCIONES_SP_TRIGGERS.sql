-- Creación de Vistas, Funciones, Procedimientos Almacenados y Triggers.

-- VISTAS
-- Vista 1 - Consulta_Materiales
CREATE OR REPLACE VIEW Consulta_Materiales AS
SELECT 
		cmat.nombre_categoria AS `Categoria`,
        m.id_material AS `Nro.Material`,
        m.nombre_material AS `Texto breve`,
        m.descripcion AS `Texto de compras`,
        m.unidad_base AS `Unidad de medida base` 
FROM Materiales m
	INNER JOIN Categorias_Materiales cmat ON (m.id_categoria = cmat.id_categoria);
    
-- Vista 2 - Stock_Materiales
CREATE OR REPLACE VIEW Stock_Materiales AS
SELECT
        m.id_material AS `Nro.Material`,
        m.nombre_material AS `Texto breve`,
        m.descripcion AS `Texto de compras`,
		s.cantidad_actual AS `Stock disponible`,
        m.unidad_base AS `Unidad de medida base`,
        u.tipo_ubicacion AS `Sector de guarda`,
        u.descripcion AS `Ubicación física`
FROM Materiales m
	INNER JOIN Stock s 
    ON (m.id_material = s.id_material)
    INNER JOIN Ubicaciones u
    ON (s.id_ubicacion = u.id_ubicacion)
ORDER BY m.id_material;

-- Vista 3 - Stock_Materiales_Resumen
CREATE OR REPLACE VIEW Stock_Materiales_Resumen AS
SELECT
    m.id_material AS `Nro.Material`,
    m.nombre_material AS `Texto breve`,
    m.descripcion AS `Texto de compras`,
    m.unidad_base AS `Unidad de medida base`,
    SUM(s.cantidad_actual) AS `Stock total`,
    GROUP_CONCAT(DISTINCT CONCAT(u.tipo_ubicacion, ' - ', u.descripcion) SEPARATOR '; ') AS `Ubicaciones`
FROM Materiales m
INNER JOIN Stock s 
    ON m.id_material = s.id_material
INNER JOIN Ubicaciones u
    ON s.id_ubicacion = u.id_ubicacion
GROUP BY m.id_material, m.nombre_material, m.descripcion, m.unidad_base
ORDER BY m.id_material;

-- FUNCIONES
-- Función 1 - calcular_stock_disponible
DELIMITER //

CREATE FUNCTION calcular_stock_disponible(p_id_material INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_stock_total INT;

    SELECT COALESCE(SUM(cantidad_actual), 0)
    INTO v_stock_total
    FROM Stock
    WHERE id_material = p_id_material;

    RETURN v_stock_total;
END 

//

DELIMITER ;

-- PROCEDIMIENTOS ALMACENADOS
-- Procedimientos almacenado 1 - crear_material
DELIMITER //

CREATE PROCEDURE crear_material (
    IN p_nombre_material VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_unidad_base VARCHAR(20),
    IN p_categoria_id INT
)
BEGIN
    -- Validar si ya existe un material con el mismo nombre
    IF EXISTS (SELECT 1 FROM Materiales WHERE nombre_material = p_nombre_material) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El material ya existe en el maestro.';
    ELSE
        INSERT INTO Materiales (nombre_material, descripcion, unidad_base, id_categoria)
        VALUES (p_nombre_material, p_descripcion, p_unidad_base, p_categoria_id);
    END IF;
END 

//

DELIMITER ;

-- TRIGGERS
-- Trigger 1 - log_cambios_stock
DELIMITER //

CREATE TRIGGER log_cambios_stock
AFTER UPDATE ON Stock
FOR EACH ROW
BEGIN
    IF OLD.cantidad_actual <> NEW.cantidad_actual OR OLD.id_ubicacion <> NEW.id_ubicacion THEN
        INSERT INTO Log_Stock (id_material, id_ubicacion, cantidad_anterior, cantidad_nueva, usuario)
        VALUES (NEW.id_material, NEW.id_ubicacion, OLD.cantidad_actual, NEW.cantidad_actual, USER());
    END IF;
END

//

DELIMITER ;

-- MÓDULO COMPRAS
-- ==============================================================================
-- TRIGGER PARA ACTUALIZAR TOTALES AUTOMÁTICAMENTE
-- ==============================================================================

DELIMITER //

CREATE TRIGGER actualizar_total_orden
AFTER INSERT ON Detalle_Orden_Compra
FOR EACH ROW
BEGIN
    UPDATE Ordenes_Compra 
    SET total = (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM Detalle_Orden_Compra 
        WHERE id_orden = NEW.id_orden
    )
    WHERE id_orden = NEW.id_orden;
END//

CREATE TRIGGER actualizar_total_orden_update
AFTER UPDATE ON Detalle_Orden_Compra
FOR EACH ROW
BEGIN
    UPDATE Ordenes_Compra 
    SET total = (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM Detalle_Orden_Compra 
        WHERE id_orden = NEW.id_orden
    )
    WHERE id_orden = NEW.id_orden;
END//

CREATE TRIGGER actualizar_total_orden_delete
AFTER DELETE ON Detalle_Orden_Compra
FOR EACH ROW
BEGIN
    UPDATE Ordenes_Compra 
    SET total = (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM Detalle_Orden_Compra 
        WHERE id_orden = OLD.id_orden
    )
    WHERE id_orden = OLD.id_orden;
END//

DELIMITER ;

-- ==============================================================================
-- VISTAS PARA CONSULTAS FRECUENTES
-- ==============================================================================

-- Vista: Resumen de Órdenes de Compra
CREATE OR REPLACE VIEW Vista_Ordenes_Compra AS
SELECT 
    oc.numero_orden AS 'Número Orden',
    rp.razon_social AS 'Proveedor',
    oc.fecha_orden AS 'Fecha Orden',
    oc.fecha_entrega_solicitada AS 'Fecha Entrega',
    eo.descripcion_estado AS 'Estado',
    oc.total AS 'Total ($)',
    oc.solicitante AS 'Solicitante'
FROM Ordenes_Compra oc
INNER JOIN Registro_Proveedores rp ON oc.id_proveedor = rp.id_proveedor
INNER JOIN Estados_Orden eo ON oc.id_estado = eo.id_estado
ORDER BY oc.fecha_orden DESC;

-- Vista: Detalle Completo de Órdenes
CREATE OR REPLACE VIEW Vista_Detalle_Ordenes AS
SELECT 
    oc.numero_orden AS 'Número Orden',
    rp.razon_social AS 'Proveedor',
    m.nombre_material AS 'Material',
    doc.cantidad_solicitada AS 'Cant. Solicitada',
    doc.precio_unitario AS 'Precio Unit.',
    doc.subtotal AS 'Subtotal',
    doc.cantidad_recibida AS 'Cant. Recibida',
    CASE 
        WHEN doc.cantidad_recibida = 0 THEN 'Pendiente'
        WHEN doc.cantidad_recibida < doc.cantidad_solicitada THEN 'Parcial'
        ELSE 'Completo'
    END AS 'Estado Recepción',
    doc.fecha_recepcion AS 'Fecha Recepción'
FROM Detalle_Orden_Compra doc
INNER JOIN Ordenes_Compra oc ON doc.id_orden = oc.id_orden
INNER JOIN Registro_Proveedores rp ON oc.id_proveedor = rp.id_proveedor
INNER JOIN Materiales m ON doc.id_material = m.id_material
ORDER BY oc.fecha_orden DESC, doc.id_detalle;

-- Vista: Órdenes Pendientes de Recepción
CREATE OR REPLACE VIEW Vista_Pendientes_Recepcion AS
SELECT 
    oc.numero_orden AS 'Número Orden',
    rp.razon_social AS 'Proveedor',
    m.nombre_material AS 'Material',
    doc.cantidad_solicitada AS 'Cantidad Solicitada',
    doc.cantidad_recibida AS 'Cantidad Recibida',
    (doc.cantidad_solicitada - doc.cantidad_recibida) AS 'Cantidad Pendiente',
    oc.fecha_entrega_solicitada AS 'Fecha Entrega Solicitada',
    DATEDIFF(CURDATE(), oc.fecha_entrega_solicitada) AS 'Días de Atraso'
FROM Detalle_Orden_Compra doc
INNER JOIN Ordenes_Compra oc ON doc.id_orden = oc.id_orden
INNER JOIN Registro_Proveedores rp ON oc.id_proveedor = rp.id_proveedor  
INNER JOIN Materiales m ON doc.id_material = m.id_material
WHERE doc.cantidad_recibida < doc.cantidad_solicitada
AND oc.id_estado = 2  -- Solo órdenes enviadas
ORDER BY oc.fecha_entrega_solicitada;


