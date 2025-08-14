CREATE OR REPLACE VIEW Materiales_con_Categorias AS
SELECT 
	m.id_material, 
	m.nombre_material, 
    cmat.nombre_categoria
FROM Materiales m
	INNER JOIN Categorias_Materiales cmat ON (m.id_categoria = cmat.id_categoria);
    
SELECT *
FROM Materiales_con_Categorias;