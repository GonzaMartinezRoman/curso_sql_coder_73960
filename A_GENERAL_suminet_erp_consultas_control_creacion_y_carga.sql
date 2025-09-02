-- Módulo Catálogo Maestro de Materiales
select * from Materiales;
select * from Categorias_Materiales;
select * from Unidades_Medida;	

-- Módulo Inventario
select * from Stock;
select * from Ubicaciones;
select * from Movimientos;
select * from Tipos_Movimiento;
select * from Log_Stock;

-- Módulo Catálogo Maestro de Proveedores  
select * from Registro_Proveedores;
select * from Contactos_Proveedor;
select * from Certificaciones_Proveedor;
select * from Alcance_Actividad;
select * from Auditoria_Proveedores;
select * from Desempeno_Proveedores;
select * from Actividad_Categoria;

-- Módulo Compras
select * from Estados_Orden;
select * from Ordenes_Compra;
select * from Detalle_Orden_Compra;

