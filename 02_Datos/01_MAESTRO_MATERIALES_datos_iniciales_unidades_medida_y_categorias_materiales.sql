-- ========================================================================================
-- MÓDULO MAESTRO MATERIALES - SUMINET ERP - GONZALO MARTINEZ ROMAN - INSERCIÓN DE DATOS(2)
-- ========================================================================================

-- 2-Categoria_Materiales
-- Categorías de clasificación de materiales.
INSERT INTO Categorias_Materiales (id_categoria, nombre_categoria, descripcion) VALUES
(1000, 'Válvulas Industriales', 'Válvulas de control, seguridad y corte para instalaciones industriales.'),
(2000, 'Cañería de conducción', 'Tuberías metálicas y no metálicas para conducción de fluidos'),
(3000, 'Accesorios de cañería', 'Accesorios de unión para cañerías: tees, codos, uniones.'),
(4000, 'Tubos y perfiles', 'Tubos de uso mecánico: redondo, cuadrado, rectangular, chapa, planchuelas, flejes, perfiles estructurales'),
(5000, 'Materiales Eléctricos', 'Conductores eléctricos, accesorios de conexionado, cajas, gabinetes, conduit, protecciones y elementos de maniobra'),
(6000, 'Instrumentación', 'Sensores, transmisores, medidores y otros instrumentos.'),
(7000, 'Lubricantes y Fluidos', 'Aceites, grasas y líquidos industriales.'),
(8000, 'Químicos', 'Productos químicos');

-- 3-Unidades_Medida
-- Unidades de medida para contabilizar materiales.
INSERT INTO Unidades_Medida (id_unidad, descripcion) VALUES
('UN', 'Unidad'),
('M', 'Metro lineal'),
('KG', 'Kilogramo'),
('LT', 'Litro'),
('PZA', 'Pieza'),
('M3', 'Metro cúbico');