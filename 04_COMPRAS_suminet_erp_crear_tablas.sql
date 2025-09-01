-- ==============================================================================
-- MÓDULO COMPRAS - SUMINET ERP - GONZALO MARTINEZ ROMAN - CREACIÓN DE TABLAS
-- ==============================================================================

-- Tabla: Estados_Orden
-- Catálogo de estados para el workflow de órdenes de compra
CREATE TABLE IF NOT EXISTS Estados_Orden (
    id_estado INT PRIMARY KEY,
    descripcion_estado VARCHAR(50) NOT NULL,
    permite_modificacion BOOLEAN DEFAULT FALSE,
    siguiente_estado_posible TEXT COMMENT 'Estados válidos para transición'
);

-- Tabla: Ordenes_Compra
-- Registro maestro de las órdenes de compra
CREATE TABLE IF NOT EXISTS Ordenes_Compra (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    numero_orden VARCHAR(20) UNIQUE NOT NULL,
    id_proveedor INT NOT NULL,
    fecha_orden DATE NOT NULL,
    fecha_entrega_requerida DATE,
    id_estado INT NOT NULL,
    moneda ENUM('ARS', 'USD', 'EUR') DEFAULT 'ARS',
    tipo_cambio DECIMAL(10,4) DEFAULT 1.0000,
    subtotal DECIMAL(15,2) DEFAULT 0.00,
    impuestos DECIMAL(15,2) DEFAULT 0.00,
    total DECIMAL(15,2) DEFAULT 0.00,
    observaciones TEXT,
    -- Información del solicitante
    solicitante VARCHAR(100),
    centro_costo VARCHAR(20),
    proyecto VARCHAR(50),
    -- Control de cambios
    version INT DEFAULT 1,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion VARCHAR(50),
    
    -- Constraints
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor),
    FOREIGN KEY (id_estado) REFERENCES Estados_Orden(id_estado),
    CONSTRAINT chk_fechas_orden CHECK (fecha_entrega_requerida >= fecha_orden),
    CONSTRAINT chk_totales CHECK (total >= 0 AND subtotal >= 0),
    
    -- Índices
    INDEX idx_numero_orden (numero_orden),
    INDEX idx_proveedor_orden (id_proveedor),
    INDEX idx_fecha_orden (fecha_orden),
    INDEX idx_estado_orden (id_estado),
    INDEX idx_fecha_entrega (fecha_entrega_requerida)
);

-- Tabla: Lineas_Orden_Compra
-- Detalle de materiales en cada orden de compra
CREATE TABLE IF NOT EXISTS Lineas_Orden_Compra (
    id_linea INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    numero_linea INT NOT NULL,
    id_material INT NOT NULL,
    cantidad_solicitada DECIMAL(10,3) NOT NULL,
    precio_unitario DECIMAL(12,4) NOT NULL,
    descuento_porcentaje DECIMAL(5,2) DEFAULT 0.00,
    precio_neto DECIMAL(12,4) GENERATED ALWAYS AS (
        precio_unitario * (1 - descuento_porcentaje/100)
    ) STORED,
    importe_linea DECIMAL(15,2) GENERATED ALWAYS AS (
        cantidad_solicitada * precio_neto
    ) STORED,
    fecha_entrega_linea DATE,
    observaciones_linea TEXT,
    -- Control de recepciones
    cantidad_recibida DECIMAL(10,3) DEFAULT 0.000,
    cantidad_pendiente DECIMAL(10,3) GENERATED ALWAYS AS (
        cantidad_solicitada - cantidad_recibida
    ) STORED,
    
    -- Constraints
    FOREIGN KEY (id_orden) REFERENCES Ordenes_Compra(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_material) REFERENCES Materiales(id_material),
    CONSTRAINT chk_cantidad_positiva CHECK (cantidad_solicitada > 0),
    CONSTRAINT chk_precio_positivo CHECK (precio_unitario >= 0),
    CONSTRAINT chk_descuento_valido CHECK (descuento_porcentaje BETWEEN 0 AND 100),
    CONSTRAINT chk_cantidad_recibida CHECK (cantidad_recibida >= 0 AND cantidad_recibida <= cantidad_solicitada),
    
    -- Clave única por orden
    UNIQUE KEY uk_orden_linea (id_orden, numero_linea),
    
    -- Índices
    INDEX idx_orden_linea (id_orden),
    INDEX idx_material_linea (id_material),
    INDEX idx_fecha_entrega_linea (fecha_entrega_linea)
);

-- Tabla: Recepciones_Compra
-- Registro de las recepciones físicas de materiales
CREATE TABLE IF NOT EXISTS Recepciones_Compra (
    id_recepcion INT AUTO_INCREMENT PRIMARY KEY,
    numero_recepcion VARCHAR(20) UNIQUE NOT NULL,
    id_orden INT NOT NULL,
    fecha_recepcion DATE NOT NULL,
    id_ubicacion INT NOT NULL, -- Dónde se almacena
    receptor VARCHAR(100) NOT NULL, -- Quién recibió
    estado_recepcion ENUM('Completa', 'Parcial', 'Con Observaciones', 'Rechazada') DEFAULT 'Completa',
    observaciones_recepcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    
    -- Constraints
    FOREIGN KEY (id_orden) REFERENCES Ordenes_Compra(id_orden),
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion),
    
    -- Índices
    INDEX idx_numero_recepcion (numero_recepcion),
    INDEX idx_orden_recepcion (id_orden),
    INDEX idx_fecha_recepcion (fecha_recepcion),
    INDEX idx_ubicacion_recepcion (id_ubicacion)
);

-- Tabla: Detalle_Recepciones
-- Detalle de materiales recibidos por línea de orden
CREATE TABLE IF NOT EXISTS Detalle_Recepciones (
    id_detalle_recepcion INT AUTO_INCREMENT PRIMARY KEY,
    id_recepcion INT NOT NULL,
    id_linea_orden INT NOT NULL,
    cantidad_recibida DECIMAL(10,3) NOT NULL,
    cantidad_aceptada DECIMAL(10,3) NOT NULL,
    cantidad_rechazada DECIMAL(10,3) GENERATED ALWAYS AS (
        cantidad_recibida - cantidad_aceptada
    ) STORED,
    motivo_rechazo TEXT,
    numero_lote VARCHAR(50),
    fecha_vencimiento DATE,
    observaciones_detalle TEXT,
    
    -- Constraints
    FOREIGN KEY (id_recepcion) REFERENCES Recepciones_Compra(id_recepcion) ON DELETE CASCADE,
    FOREIGN KEY (id_linea_orden) REFERENCES Lineas_Orden_Compra(id_linea) ON DELETE CASCADE,
    CONSTRAINT chk_cantidades_recepcion CHECK (cantidad_aceptada <= cantidad_recibida),
    CONSTRAINT chk_cantidad_recibida_positiva CHECK (cantidad_recibida > 0),
    
    -- Índices
    INDEX idx_recepcion_detalle (id_recepcion),
    INDEX idx_linea_orden_detalle (id_linea_orden)
);
