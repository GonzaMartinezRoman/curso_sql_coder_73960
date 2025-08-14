-- Creación de Vistas, Funciones, Procedimientos Almacenados y Triggers.

-- VISTAS
-- Vista 1 - Materiales_con_categorias
CREATE OR REPLACE VIEW Materiales_con_Categorias AS
SELECT 
	m.id_material, 
	m.nombre_material, 
    cmat.nombre_categoria
FROM Materiales m
	INNER JOIN Categorias_Materiales cmat ON (m.id_categoria = cmat.id_categoria);
    
-- Vista 2 - Materiales_con_categorias

-- FUNCIONES
-- Función 1 -

-- PROCEDIMIENTOS ALMACENADOS
-- Procedimientos almacenado 1 - 

-- TRIGGERS
-- Trigger 1 - 


