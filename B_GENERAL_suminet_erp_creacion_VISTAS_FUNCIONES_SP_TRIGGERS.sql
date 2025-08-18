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


