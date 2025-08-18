-- Creacción tablas módulo de Inventario.

-- Tabla: Stock
CREATE TABLE IF NOT EXISTS Stock (
    id_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_material INT,
    id_ubicacion INT,
    cantidad_actual DECIMAL(10,2),
    stock_minimo DECIMAL(10,2),
    stock_maximo DECIMAL(10,2),
    fecha_actualizacion DATE,
    FOREIGN KEY (id_material) REFERENCES Materiales(id_material),
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion)
);

-- Tabla: Ubicaciones
CREATE TABLE IF NOT EXISTS Ubicaciones (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ubicacion VARCHAR(50),
    tipo_ubicacion VARCHAR(30),
    descripcion TEXT
);

-- Tabla: Tipos_Movimiento (con autoinicio en 101)
CREATE TABLE IF NOT EXISTS Tipos_Movimiento (
    id_tipo_mov INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_tipo VARCHAR(50),
    CONSTRAINT chk_id_length CHECK (id_tipo_mov BETWEEN 101 AND 999)
) AUTO_INCREMENT = 101;

-- Tabla: Movimientos
CREATE TABLE IF NOT EXISTS Movimientos (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    fecha_movimiento DATE,
    tipo_movimiento INT,
    cantidad DECIMAL(10,2),
    id_material INT,
    id_ubicacion INT,
    observaciones TEXT,
    FOREIGN KEY (tipo_movimiento) REFERENCES Tipos_Movimiento(id_tipo_mov),
    FOREIGN KEY (id_material) REFERENCES Materiales(id_material),
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion)
);