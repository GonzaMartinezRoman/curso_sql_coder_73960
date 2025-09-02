-- ==============================================================================
-- MÓDULO PROVEEDORES - SUMINET ERP - GONZALO MARTINEZ ROMAN - INSERCIÓN DE DATOS
-- ==============================================================================

-- Carga proveedores de ejemplo
INSERT INTO Registro_Proveedores (razon_social, cuit, direccion, ciudad, provincia, telefono, email, estado) VALUES
('Electrotécnica Industrial S.A.', '30-12345678-9', 'Av. Corrientes 1234', 'CABA', 'CABA', '011-4567-8900', 'ventas@electrotecnica.com.ar', 'Activo'),
('Válvulas y Accesorios del Norte', '30-87654321-0', 'Ruta 22 Km 15', 'Neuquén', 'Neuquén', '0299-456-7890', 'comercial@valvulasnorte.com.ar', 'Activo'),
('Distribuidora de Materiales S.R.L.', '30-11223344-5', 'Parque Industrial Oeste', 'Mendoza', 'Mendoza', '0261-789-0123', 'compras@dismateriales.com.ar', 'Activo'),
('Instrumentos de Precisión Ltda.', '30-55667788-9', 'Zona Franca Área 2', 'Bahía Blanca', 'Buenos Aires', '0291-234-5678', 'info@instrumentos.com.ar', 'Activo'),
('Química Industrial del Sur', '30-99887766-3', 'Polo Petroquímico', 'Comodoro Rivadavia', 'Chubut', '0297-345-6789', 'ventas@quimicasur.com.ar', 'Activo');