-- ===================================================================
-- SUMINET ERP - GONZALO MARTINEZ ROMAN - CONSULTAS DE FUNCIONALIDADES
-- ===================================================================
-- Creación de Vistas, Funciones, Procedimientos Almacenados y Triggers.

-- VISTAS
-- Vista 1 - Consulta_Materiales
-- Esta vista combina datos de las tablas Materiales y Categorias_Materiales 
-- mostrando una visualización resumida del maestro de materiales con las categorías correspondientes.
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
-- Esta vista integra la información básica de los materiales con el stock disponible y 
-- la ubicación física en la que se encuentra, proporcionando una visualización consolidada 
-- de inventario por material.
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
-- Esta vista muestra el stock total por material y consolida en una sola columna todas 
-- las ubicaciones físicas donde se encuentra, brindando una visión resumida y agregada 
-- del inventario.
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

-- Vista 4 - Reporte_Ordenes_Compra
-- Esta vista combina los datos de la tabla de ordenes de compra con la identificación 
-- de proveedores y el detalle de cada orden de compra. De esa combinación surge un reporte 
-- detallado de las ordenes de compras emitidas y su estado actual. 
CREATE OR REPLACE VIEW Reporte_Ordenes_Compra AS
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

-- Vista 5 - Vendor_Pool_List
-- Esta vista combina los datos de proveedores con las actividades estandarizadas, 
-- calificaciones y desempeño a fin de obtener la Vendor_Pool_list. Esta es una herramienta 
-- fundamental que utilizan los analista de compras para determinar la población de proveedores a invitar a una licitación.
CREATE OR REPLACE VIEW Vendor_Pool_List AS
SELECT DISTINCT
    aa.nombre_actividad AS 'Actividad',
    aa.tipo_actividad AS 'Tipo Actividad',
    aa.nivel_especialización AS 'Nivel Especialización',
    aa.criticidad AS 'Criticidad',
    cm.nombre_categoria AS 'Categoría Material',
    rp.id_proveedor AS 'ID Proveedor',
    rp.razon_social AS 'Proveedor',
    rp.ciudad AS 'Ciudad',
    rp.provincia AS 'Provincia',
        -- Estado de auditoría más reciente
    (SELECT ap.resultado 
     FROM Auditoria_Proveedores ap 
     WHERE ap.id_proveedor = rp.id_proveedor 
       AND ap.id_actividad = aa.id_actividad
     ORDER BY ap.fecha_auditoria DESC 
     LIMIT 1) AS 'Estado Auditoria',
    -- Fecha de vencimiento de auditoría
    (SELECT ap.fecha_vencimiento 
     FROM Auditoria_Proveedores ap 
     WHERE ap.id_proveedor = rp.id_proveedor 
       AND ap.id_actividad = aa.id_actividad
     ORDER BY ap.fecha_auditoria DESC 
     LIMIT 1) AS 'Vencimiento Auditoria',
    -- Puntaje promedio de desempeño
    (SELECT ROUND(AVG(dp.puntaje_general), 1)
     FROM Desempeno_Proveedores dp 
     WHERE dp.id_proveedor = rp.id_proveedor 
       AND dp.id_actividad = aa.id_actividad) AS 'Puntaje Promedio',
    -- Contacto principal
    (SELECT CONCAT(cp.nombre_contacto, ' - ', cp.telefono)
     FROM Contactos_Proveedor cp 
     WHERE cp.id_proveedor = rp.id_proveedor 
       AND cp.es_contacto_principal = TRUE 
     LIMIT 1) AS 'Contacto Principal',
    rp.estado AS 'Estado Proveedor'

FROM Registro_Proveedores rp
INNER JOIN Auditoria_Proveedores ap ON rp.id_proveedor = ap.id_proveedor
INNER JOIN Alcance_Actividad aa ON ap.id_actividad = aa.id_actividad
INNER JOIN Actividad_Categoria ac ON aa.id_actividad = ac.id_actividad
INNER JOIN Categorias_Materiales cm ON ac.id_categoria = cm.id_categoria

WHERE rp.estado = 'Activo'
  AND aa.estado = 'Activo'
  AND ac.estado = 'Activo'

ORDER BY 
    cm.nombre_categoria,
    aa.criticidad DESC,
    aa.nivel_especialización DESC,
    rp.razon_social;

-- FUNCIONES
-- Función 1 - calcular_stock_disponible
-- Esta función calcula el stock total disponible de un material específico sumando 
-- todas las cantidades registradas en el inventario, independientemente de la ubicación. 
-- Recibe como parámetro el id_material y devuelve un valor numérico con la cantidad total 
-- disponible en el sistema.
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



-- Función 2 - calcular_rotacion_material
-- Calcula la rotación de inventario de un material en los últimos X meses
-- La rotación se calcula como: Total salidas / Stock promedio en el período
-- Un valor alto indica alta rotación (material de movimiento rápido)
DROP FUNCTION IF EXISTS calcular_rotacion_material;
DELIMITER //
CREATE FUNCTION calcular_rotacion_material(
    p_id_material INT, 
    p_meses INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_salidas DECIMAL(10,2) DEFAULT 0;
    DECLARE v_stock_promedio DECIMAL(10,2) DEFAULT 0;
    DECLARE v_rotacion DECIMAL(10,2) DEFAULT 0;
    DECLARE v_fecha_inicio DATE;
    
    -- Calcular fecha de inicio del período
    SET v_fecha_inicio = DATE_SUB(CURDATE(), INTERVAL p_meses MONTH);
    
    -- Calcular total de salidas en el período (tipo_movimiento = 2 es "Salida por consumo")
    SELECT COALESCE(SUM(cantidad), 0)
    INTO v_total_salidas
    FROM Movimientos
    WHERE id_material = p_id_material
      AND tipo_movimiento = 102
      AND fecha_movimiento >= v_fecha_inicio;
    
    -- Calcular stock promedio actual (suma de todas las ubicaciones)
    SELECT COALESCE(AVG(cantidad_actual), 0)
    INTO v_stock_promedio
    FROM Stock
    WHERE id_material = p_id_material
      AND cantidad_actual > 0;
    
    -- Si no hay stock promedio, evitar división por cero
    IF v_stock_promedio > 0 THEN
        SET v_rotacion = v_total_salidas / v_stock_promedio;
    ELSE
        SET v_rotacion = 0;
    END IF;
    
    RETURN v_rotacion;
END //

DELIMITER ;

-- PROCEDIMIENTOS ALMACENADOS
-- Procedimiento almacenado 1 - crear_material
-- Este procedimiento almacenado inserta un nuevo registro en el Maestro de Materiales, 
-- validando previamente que no exista un material con el mismo nombre. Recibe como parámetros el 
-- nombre, descripción, unidad base y la categoría del material. En caso de duplicidad, devuelve un 
-- error controlado.
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

-- Procedimiento almacenado 2 -registrar_nuevo_proveedor
-- Este procedimiento almacenado inserta un nuevo registro en el Maestro de Proveedores. 
DELIMITER //

CREATE PROCEDURE registrar_nuevo_proveedor (
    IN p_razon_social VARCHAR(100),
    IN p_cuit VARCHAR(15),
    IN p_direccion VARCHAR(150),
    IN p_ciudad VARCHAR(50),
    IN p_provincia VARCHAR(50),
    IN p_tipo_pais ENUM('Nacional','Extranjero'),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sitio_web VARCHAR(100)
)
BEGIN
    INSERT INTO Registro_Proveedores (
        razon_social, cuit, direccion, ciudad, provincia, 
        tipo_pais, telefono, email, sitio_web
    )
    VALUES (
        p_razon_social, p_cuit, p_direccion, p_ciudad, p_provincia,
        p_tipo_pais, p_telefono, p_email, p_sitio_web
    );
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

-- Trigger 2 - sincronizar_stock_movimiento
DELIMITER //

CREATE TRIGGER sincronizar_stock_movimiento
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
    DECLARE v_tipo VARCHAR(50);

    -- Obtener descripción del tipo de movimiento
    SELECT descripcion_tipo 
    INTO v_tipo
    FROM Tipos_Movimiento
    WHERE id_tipo_mov = NEW.tipo_movimiento;

    -- Solo sincronizamos stock para Entrada y Salida
    IF v_tipo = 'Entrada' THEN
        IF EXISTS (SELECT 1 FROM Stock WHERE id_material = NEW.id_material AND id_ubicacion = NEW.id_ubicacion) THEN
            UPDATE Stock
            SET cantidad_actual = cantidad_actual + NEW.cantidad,
                fecha_actualizacion = CURDATE()
            WHERE id_material = NEW.id_material AND id_ubicacion = NEW.id_ubicacion;
        ELSE
            INSERT INTO Stock (id_material, id_ubicacion, cantidad_actual, fecha_actualizacion)
            VALUES (NEW.id_material, NEW.id_ubicacion, NEW.cantidad, CURDATE());
        END IF;

    ELSEIF v_tipo = 'Salida' THEN
        UPDATE Stock
        SET cantidad_actual = cantidad_actual - NEW.cantidad,
            fecha_actualizacion = CURDATE()
        WHERE id_material = NEW.id_material AND id_ubicacion = NEW.id_ubicacion;
    END IF;
END 

//

DELIMITER ;




