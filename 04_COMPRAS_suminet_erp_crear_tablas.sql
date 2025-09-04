-- ==============================================================================
-- MÓDULO COMPRAS - SUMINET ERP - GONZALO MARTINEZ ROMAN - CREACIÓN DE TABLAS
-- ==============================================================================

-- 16-Estados_Orden
CREATE TABLE Estados_Orden (
    id_estado INT PRIMARY KEY,
    descripcion_estado VARCHAR(50) NOT NULL
);

-- 17-Ordenes_Compra
CREATE TABLE Ordenes_Compra (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    numero_orden VARCHAR(20) UNIQUE NOT NULL,
    id_proveedor INT NOT NULL,
    fecha_orden DATE NOT NULL,
    fecha_entrega_solicitada DATE,
    id_estado INT NOT NULL DEFAULT 1,
    total DECIMAL(15,2) DEFAULT 0.00,
    observaciones TEXT,
    solicitante VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor),
    FOREIGN KEY (id_estado) REFERENCES Estados_Orden(id_estado),
    
    INDEX idx_numero_orden (numero_orden),
    INDEX idx_proveedor (id_proveedor),
    INDEX idx_fecha_orden (fecha_orden)
);

-- 18-Detalle_Orden_Compra
CREATE TABLE Detalle_Orden_Compra (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_material INT NOT NULL,
    cantidad_solicitada DECIMAL(10,2) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(15,2) GENERATED ALWAYS AS (cantidad_solicitada * precio_unitario) STORED,
    cantidad_recibida DECIMAL(10,2) DEFAULT 0.00,
    fecha_recepcion DATE NULL,
    observaciones TEXT,
    
    FOREIGN KEY (id_orden) REFERENCES Ordenes_Compra(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_material) REFERENCES Materiales(id_material),
    
    CONSTRAINT chk_cantidad_positiva CHECK (cantidad_solicitada > 0),
    CONSTRAINT chk_precio_positivo CHECK (precio_unitario >= 0),
    CONSTRAINT chk_cantidad_recibida_valida CHECK (cantidad_recibida >= 0 AND cantidad_recibida <= cantidad_solicitada),
    
    INDEX idx_orden (id_orden),
    INDEX idx_material (id_material)
);
