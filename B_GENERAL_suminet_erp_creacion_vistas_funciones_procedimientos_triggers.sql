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
-- Función 1 -

-- PROCEDIMIENTOS ALMACENADOS
-- Procedimientos almacenado 1 - 

-- TRIGGERS
-- Trigger 1 - 


