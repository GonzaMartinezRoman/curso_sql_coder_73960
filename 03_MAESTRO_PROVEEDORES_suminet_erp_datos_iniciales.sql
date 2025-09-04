-- ==============================================================================
-- MÓDULO PROVEEDORES - SUMINET ERP - GONZALO MARTINEZ ROMAN - INSERCIÓN DE DATOS
-- ==============================================================================

-- 9-Registro_Proveedores
-- Carga proveedores de ejemplo
INSERT INTO Registro_Proveedores (razon_social, cuit, direccion, ciudad, provincia, telefono, email, estado) VALUES
('Electrotécnica Industrial S.A.', '30-12345678-9', 'Av. Corrientes 1234', 'CABA', 'CABA', '011-4567-8900', 'ventas@electrotecnica.com.ar', 'Activo'),
('Válvulas y Accesorios del Norte', '30-87654321-0', 'Ruta 22 Km 15', 'Neuquén', 'Neuquén', '0299-456-7890', 'comercial@valvulasnorte.com.ar', 'Activo'),
('Distribuidora de Materiales S.R.L.', '30-11223344-5', 'Parque Industrial Oeste', 'Mendoza', 'Mendoza', '0261-789-0123', 'compras@dismateriales.com.ar', 'Activo'),
('Instrumentos de Precisión Ltda.', '30-55667788-9', 'Zona Franca Área 2', 'Bahía Blanca', 'Buenos Aires', '0291-234-5678', 'info@instrumentos.com.ar', 'Activo'),
('Química Industrial del Sur', '30-99887766-3', 'Polo Petroquímico', 'Comodoro Rivadavia', 'Chubut', '0297-345-6789', 'ventas@quimicasur.com.ar', 'Activo');

-- 10-Alcance_Actividad
-- Define las actividades especializadas de la industria con su criticidad y certificaciones requeridas
INSERT INTO Alcance_Actividad (nombre_actividad, descripcion, tipo_actividad, nivel_especialización, criticidad, certificaciones_requeridas, estado) VALUES
-- MANUFACTURA - Actividades de fabricación especializada
('Fabricación de Válvulas API', 'Manufactura de válvulas según normas API 6A, API 598, API 600 para aplicaciones críticas en Oil & Gas', 'Manufactura', 'Crítico', 'Alta', 'API 6A, API 598, ISO 9001, ATEX (si aplica)', 'Activo'),
('Fabricación de Recipientes a Presión ASME', 'Manufactura de equipos a presión certificados ASME VIII Div.1 y Div.2', 'Manufactura', 'Crítico', 'Alta', 'ASME U, ASME U2, ISO 9001, ATEX', 'Activo'),
('Fabricación de Instrumentación Ex', 'Manufactura de instrumentos para áreas clasificadas con certificación ATEX/IECEx', 'Manufactura', 'Especializado', 'Alta', 'ATEX, IECEx, ISO 9001, SIL', 'Activo'),
('Fabricación de Estructuras Metálicas', 'Soldadura y fabricación de estructuras según AWS D1.1', 'Manufactura', 'Commodities', 'Media', 'AWS D1.1, ISO 9001', 'Activo'),
('Fabricación de Tableros Eléctricos', 'Manufactura de tableros según normas IEC 61439', 'Manufactura', 'Especializado', 'Alta', 'IEC 61439, ISO 9001, Certificación electricista', 'Activo'),

-- COMERCIALIZACIÓN - Distribuidores especializados
('Distribución de Materiales Eléctricos', 'Comercialización de componentes eléctricos industriales', 'Comercialización', 'Commodities', 'Baja', 'Representación de marcas reconocidas', 'Activo'),
('Distribución de Instrumentación Industrial', 'Comercialización de instrumentos de medición y control', 'Comercialización', 'Especializado', 'Media', 'Certificación técnica del fabricante, Representación autorizada', 'Activo'),
('Distribución de Válvulas Industriales', 'Comercialización de válvulas para procesos industriales', 'Comercialización', 'Especializado', 'Media', 'Representación autorizada, Conocimiento técnico', 'Activo'),
('Distribución de Químicos Industriales', 'Comercialización de productos químicos para procesos', 'Comercialización', 'Crítico', 'Alta', 'Habilitación ANMAT, Transporte de cargas peligrosas', 'Activo'),
('Distribución de Cañerías y Accesorios', 'Comercialización de tuberías y fitting industriales', 'Comercialización', 'Commodities', 'Baja', 'Stock permanente, Servicio de corte', 'Activo'),

-- SERVICIOS - Servicios especializados
('Calibración de Instrumentos', 'Servicios de calibración trazable de instrumentos de medición', 'Servicios', 'Crítico', 'Alta', 'ISO 17025, OAA, Trazabilidad INTI', 'Activo'),
('Reparación de Válvulas en Sitio', 'Servicios de mantenimiento y reparación in-situ', 'Servicios', 'Especializado', 'Media', 'Personal certificado, Herramientas especializadas', 'Activo'),
('Pruebas Hidrostáticas', 'Servicios de testing de presión según ASME y API', 'Servicios', 'Especializado', 'Alta', 'Procedimientos certificados, Personal calificado', 'Activo'),
('Tratamiento Térmico', 'Servicios de stress relief y tratamientos térmicos PWHT', 'Servicios', 'Crítico', 'Alta', 'ASME IX, AWS, Procedimientos calificados', 'Activo'),
('Análisis de Fluidos', 'Servicios de análisis químico de aceites y fluidos industriales', 'Servicios', 'Especializado', 'Media', 'Laboratorio acreditado, ISO 17025', 'Activo'),

-- INGENIERÍA - Servicios de ingeniería especializada
('Ingeniería de Procesos', 'Diseño y optimización de procesos industriales', 'Ingeniería', 'Crítico', 'Alta', 'Matrícula profesional, Experiencia en industria', 'Activo'),
('Ingeniería de Instrumentación', 'Diseño de sistemas de control y automatización', 'Ingeniería', 'Crítico', 'Alta', 'ISA, Certificación en sistemas de control', 'Activo'),
('Ingeniería Eléctrica Industrial', 'Diseño de instalaciones eléctricas industriales', 'Ingeniería', 'Especializado', 'Alta', 'Matrícula profesional, IEC 61511', 'Activo'),
('Estudios de Seguridad Funcional', 'Análisis SIL y estudios HAZOP', 'Ingeniería', 'Crítico', 'Alta', 'IEC 61508, IEC 61511, Certificación SIL', 'Activo');

-- 11-Actividad_Categoria
-- Relaciona las actividades con las categorías de materiales del maestro
INSERT INTO Actividad_Categoria (id_actividad, id_categoria, estado) VALUES
-- Válvulas Industriales (Categoría 1000)
(1, 1000, 'Activo'),  -- Fabricación de Válvulas API
(8, 1000, 'Activo'),  -- Distribución de Válvulas Industriales
(12, 1000, 'Activo'), -- Reparación de Válvulas en Sitio

-- Cañería de conducción (Categoría 2000)
(2, 2000, 'Activo'),  -- Fabricación de Recipientes a Presión ASME
(10, 2000, 'Activo'), -- Distribución de Cañerías y Accesorios
(13, 2000, 'Activo'), -- Pruebas Hidrostáticas

-- Accesorios de cañería (Categoría 3000)
(2, 3000, 'Activo'),  -- Fabricación de Recipientes a Presión ASME
(10, 3000, 'Activo'), -- Distribución de Cañerías y Accesorios
(14, 3000, 'Activo'), -- Tratamiento Térmico

-- Tubos y perfiles (Categoría 4000)
(4, 4000, 'Activo'),  -- Fabricación de Estructuras Metálicas
(10, 4000, 'Activo'), -- Distribución de Cañerías y Accesorios

-- Materiales Eléctricos (Categoría 5000)
(5, 5000, 'Activo'),  -- Fabricación de Tableros Eléctricos
(6, 5000, 'Activo'),  -- Distribución de Materiales Eléctricos
(18, 5000, 'Activo'), -- Ingeniería Eléctrica Industrial

-- Instrumentación (Categoría 6000)
(3, 6000, 'Activo'),  -- Fabricación de Instrumentación Ex
(7, 6000, 'Activo'),  -- Distribución de Instrumentación Industrial
(11, 6000, 'Activo'), -- Calibración de Instrumentos
(17, 6000, 'Activo'), -- Ingeniería de Instrumentación

-- Lubricantes y Fluidos (Categoría 7000)
(15, 7000, 'Activo'), -- Análisis de Fluidos

-- Químicos (Categoría 8000)
(9, 8000, 'Activo'),  -- Distribución de Químicos Industriales

-- Actividades transversales de ingeniería
(16, 1000, 'Activo'), -- Ingeniería de Procesos - Válvulas
(16, 2000, 'Activo'), -- Ingeniería de Procesos - Cañería
(16, 6000, 'Activo'), -- Ingeniería de Procesos - Instrumentación
(19, 6000, 'Activo'); -- Estudios de Seguridad Funcional - Instrumentación

-- 12-Certificaciones_Proveedor
-- Certificaciones de los proveedores existentes según su especialidad
INSERT INTO Certificaciones_Proveedor (id_proveedor, tipo_certificacion, numero_certificado, organismo_certificador, alcance, fecha_emision, fecha_vencimiento, estado) VALUES
-- Electrotécnica Industrial S.A. (id_proveedor = 1)
(1, 'ISO 9001', 'ISO-9001-2023-ETI-001', 'IRAM', 'Fabricación de tableros eléctricos industriales', '2023-01-15', '2026-01-15', 'Vigente'),
(1, 'IEC 61439', 'IEC-61439-ETI-2023', 'TÜV Rheinland', 'Tableros de distribución de baja tensión', '2023-03-20', '2025-03-20', 'Vigente'),
(1, 'Habilitación Electricista', 'DPEI-2024-1145', 'DPE CABA', 'Instalaciones eléctricas industriales', '2024-02-10', '2025-02-10', 'Vigente'),

-- Válvulas y Accesorios del Norte (id_proveedor = 2)
(2, 'API 6A', 'API-6A-2023-VAN-078', 'API', 'Válvulas para equipos de cabeza de pozo', '2023-06-15', '2026-06-15', 'Vigente'),
(2, 'API 598', 'API-598-VAN-2023', 'API', 'Inspección y testing de válvulas', '2023-07-20', '2026-07-20', 'Vigente'),
(2, 'ISO 9001', 'ISO-9001-2022-VAN', 'Bureau Veritas', 'Fabricación y distribución de válvulas industriales', '2022-11-10', '2025-11-10', 'Vigente'),

-- Distribuidora de Materiales S.R.L. (id_proveedor = 3)
(3, 'ISO 9001', 'ISO-9001-2023-DM-445', 'SGS', 'Distribución de materiales para construcción industrial', '2023-04-12', '2026-04-12', 'Vigente'),
(3, 'AWS D1.1', 'AWS-D1.1-DM-2024', 'AWS', 'Soldadura de estructuras de acero', '2024-01-25', '2025-01-25', 'Vigente'),

-- Instrumentos de Precisión Ltda. (id_proveedor = 4)
(4, 'ISO 17025', 'ISO-17025-2023-IPL', 'OAA', 'Calibración de instrumentos de medición industrial', '2023-08-15', '2026-08-15', 'Vigente'),
(4, 'ATEX', 'ATEX-IPL-2023-CE-789', 'TÜV SÜD', 'Equipos para atmósferas explosivas Zona 1', '2023-09-10', '2025-09-10', 'Vigente'),
(4, 'IECEx', 'IECEx-IPL-2023-456', 'IECEx', 'Instrumentos Ex ia para Zona 0', '2023-09-15', '2026-09-15', 'Vigente'),
(4, 'SIL 2', 'SIL2-IPL-2024-112', 'TÜV Rheinland', 'Instrumentos de seguridad funcional', '2024-03-05', '2027-03-05', 'Vigente'),

-- Química Industrial del Sur (id_proveedor = 5)
(5, 'ANMAT', 'ANMAT-QIS-2024-5567', 'ANMAT', 'Comercialización de productos químicos industriales', '2024-01-20', '2025-01-20', 'Vigente'),
(5, 'Transporte Cargas Peligrosas', 'TCP-QIS-2023-889', 'CNRT', 'Transporte de sustancias químicas clase 8', '2023-12-10', '2024-12-10', 'Vigente'),
(5, 'ISO 9001', 'ISO-9001-2023-QIS', 'IRAM', 'Distribución de productos químicos industriales', '2023-05-30', '2026-05-30', 'Vigente');

-- 13-Auditoria_Proveedores
-- Auditorías realizadas para determinar aptitud por actividad
INSERT INTO Auditoria_Proveedores (id_proveedor, id_actividad, fecha_auditoria, resultado, auditor, comentarios, tipo_auditoria, vigencia_meses) VALUES
-- Electrotécnica Industrial S.A.
(1, 5, '2023-02-15', 'Aceptado', 'Ing. Roberto Martínez', 'Proveedor con amplia experiencia en tableros industriales. Instalaciones adecuadas y personal calificado.', 'Inicial', 18),
(1, 6, '2023-02-20', 'Aceptado', 'Ing. Roberto Martínez', 'Distribución autorizada de marcas reconocidas. Buen stock y tiempos de entrega.', 'Inicial', 12),

-- Válvulas y Accesorios del Norte
(2, 1, '2023-07-10', 'Aceptado', 'Ing. Patricia González', 'Fabricante certificado API. Excelente calidad y cumplimiento de especificaciones técnicas.', 'Inicial', 24),
(2, 8, '2023-07-15', 'Aceptado', 'Ing. Patricia González', 'Amplio catálogo de válvulas industriales. Servicio técnico competente.', 'Inicial', 18),
(2, 12, '2023-08-20', 'Condicional', 'Ing. Carlos Ruiz', 'Servicio técnico adecuado pero requiere mejorar tiempos de respuesta para emergencias.', 'Inicial', 12),

-- Distribuidora de Materiales S.R.L.
(3, 4, '2023-05-10', 'Aceptado', 'Ing. Ana López', 'Taller de soldadura bien equipado. Personal certificado AWS D1.1.', 'Inicial', 15),
(3, 10, '2023-05-15', 'Aceptado', 'Ing. Ana López', 'Buen stock de cañerías y accesorios. Servicio de corte disponible.', 'Inicial', 12),

-- Instrumentos de Precisión Ltda.
(4, 3, '2023-10-05', 'Aceptado', 'Ing. Miguel Torres', 'Fabricante especializado en instrumentos Ex. Certificaciones vigentes y control de calidad riguroso.', 'Inicial', 24),
(4, 7, '2023-10-10', 'Aceptado', 'Ing. Miguel Torres', 'Distribución autorizada de marcas premium. Excelente soporte técnico.', 'Inicial', 18),
(4, 11, '2023-10-15', 'Aceptado', 'Ing. Miguel Torres', 'Laboratorio acreditado ISO 17025. Trazabilidad completa y certificados válidos.', 'Inicial', 18),

-- Química Industrial del Sur
(5, 9, '2024-02-20', 'Aceptado', 'Ing. Laura Fernández', 'Distribución autorizada con todas las habilitaciones requeridas. Manejo seguro de productos.', 'Inicial', 12),

-- Auditorías de renovación
(1, 5, '2024-08-15', 'Aceptado', 'Ing. Roberto Martínez', 'Renovación satisfactoria. Mantiene estándares de calidad.', 'Renovación', 18);

-- 14. Desempeno_Proveedores
-- Evaluaciones de desempeño basadas en órdenes ejecutadas
INSERT INTO Desempeno_Proveedores (id_orden, id_proveedor, id_actividad, fecha_evaluacion, evaluador, competencia_tecnica, cumplimiento_plazo_entrega, servicio_post_venta, calidad_de_producto, comentarios) VALUES

-- Evaluaciones basadas en las órdenes de compra del módulo simplificado
(1, 1, 5, '2024-07-25', 'Juan Pérez', 95.00, 90.00, 88.00, 92.00, 'Excelente calidad de tableros. Entrega con 2 días de retraso por modificaciones solicitadas.'),
(1, 1, 6, '2024-07-25', 'Juan Pérez', 88.00, 95.00, 90.00, 90.00, 'Materiales eléctricos conformes a especificación. Entrega puntual.'),
(2, 2, 1, '2024-07-28', 'María González', 98.00, 85.00, 92.00, 96.00, 'Válvulas API de excelente calidad. Retraso de 5 días por pruebas adicionales solicitadas.'),
(2, 2, 8, '2024-07-28', 'María González', 90.00, 88.00, 85.00, 91.00, 'Válvulas según especificación. Documentación completa.'),
(3, 3, 10, '2024-07-20', 'Carlos Rodríguez', 85.00, 100.00, 80.00, 88.00, 'Entrega perfecta en tiempo. Calidad estándar cumplida. Servicio post-venta mejorable.'),
(4, 4, 3, '2024-08-02', 'Ana Martínez', 96.00, 92.00, 94.00, 95.00, 'Instrumentos de alta precisión. Certificaciones completas. Excelente soporte técnico.'),
(4, 4, 7, '2024-08-02', 'Ana Martínez', 92.00, 90.00, 91.00, 93.00, 'Instrumentos según especificación con documentación técnica completa.'),
(6, 1, 6, '2024-08-05', 'Roberto Silva', 90.00, 88.00, 92.00, 89.00, 'Materiales urgentes entregados según cronograma. Calidad consistente.'),

-- Evaluaciones adicionales para completar historial
(3, 3, 4, '2024-06-15', 'Carlos Rodríguez', 92.00, 95.00, 87.00, 90.00, 'Trabajo de soldadura de estructuras según AWS D1.1. Excelente cumplimiento.'),
(2, 2, 12, '2024-05-20', 'María González', 88.00, 75.00, 82.00, 85.00, 'Servicio de reparación in-situ. Demora en respuesta pero trabajo final satisfactorio.'),
(4, 4, 11, '2024-04-10', 'Ana Martínez', 98.00, 100.00, 96.00, 97.00, 'Calibración de instrumentos con trazabilidad INTI. Servicio excepcional.'),
(5, 5, 9, '2024-03-25', 'Luis Fernández', 85.00, 90.00, 88.00, 87.00, 'Productos químicos según especificación. Documentación de seguridad completa.');

-- 15. Contactos_Proveedor
-- Contactos comerciales y técnicos de cada proveedor
INSERT INTO Contactos_Proveedor (id_proveedor, nombre_contacto, cargo, telefono, email, area_responsabilidad, es_contacto_principal, estado) VALUES
-- Electrotécnica Industrial S.A.
(1, 'Carlos Mendoza', 'Gerente Comercial', '011-4567-8901', 'cmendoza@electrotecnica.com.ar', 'Ventas', TRUE, 'Activo'),
(1, 'Ing. Sofia Ramírez', 'Jefe Técnico', '011-4567-8902', 'sramirez@electrotecnica.com.ar', 'Técnico', FALSE, 'Activo'),
(1, 'María Vega', 'Administración', '011-4567-8903', 'mvega@electrotecnica.com.ar', 'Administración', FALSE, 'Activo'),

-- Válvulas y Accesorios del Norte
(2, 'Ing. Ricardo Paz', 'Director General', '0299-456-7891', 'rpaz@valvulasnorte.com.ar', 'Gerencia', TRUE, 'Activo'),
(2, 'Laura Jiménez', 'Jefe de Ventas', '0299-456-7892', 'ljimenez@valvulasnorte.com.ar', 'Ventas', FALSE, 'Activo'),
(2, 'Ing. Pedro Morales', 'Servicio Técnico', '0299-456-7893', 'pmorales@valvulasnorte.com.ar', 'Técnico', FALSE, 'Activo'),

-- Distribuidora de Materiales S.R.L.
(3, 'Alejandro Castro', 'Gerente Comercial', '0261-789-0124', 'acastro@dismateriales.com.ar', 'Ventas', TRUE, 'Activo'),
(3, 'Ing. Claudia Torres', 'Responsable Técnico', '0261-789-0125', 'ctorres@dismateriales.com.ar', 'Técnico', FALSE, 'Activo'),

-- Instrumentos de Precisión Ltda.
(4, 'Ing. Fernando López', 'Gerente General', '0291-234-5679', 'flopez@instrumentos.com.ar', 'Gerencia', TRUE, 'Activo'),
(4, 'Gabriela Ruiz', 'Jefe Comercial', '0291-234-5680', 'gruiz@instrumentos.com.ar', 'Ventas', FALSE, 'Activo'),
(4, 'Ing. Daniel Herrera', 'Jefe de Calibraciones', '0291-234-5681', 'dherrera@instrumentos.com.ar', 'Técnico', FALSE, 'Activo'),

-- Química Industrial del Sur
(5, 'Patricia Sandoval', 'Gerente de Ventas', '0297-345-6790', 'psandoval@quimicasur.com.ar', 'Ventas', TRUE, 'Activo'),
(5, 'Ing. Martín Silva', 'Responsable Técnico', '0297-345-6791', 'msilva@quimicasur.com.ar', 'Técnico', FALSE, 'Activo'),
(5, 'Andrea Campos', 'Administración', '0297-345-6792', 'acampos@quimicasur.com.ar', 'Administración', FALSE, 'Activo');