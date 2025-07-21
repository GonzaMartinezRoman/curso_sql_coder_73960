-- Crear base de datos
CREATE DATABASE IF NOT EXISTS suminet_erp;
USE suminet_erp;

-- Tabla: Unidades_Medida
CREATE TABLE IF NOT EXISTS Unidades_Medida (
    id_unidad VARCHAR(10) PRIMARY KEY,
    descripcion VARCHAR(50)
);

-- Tabla: Categorias_Materiales
CREATE TABLE IF NOT EXISTS Categorias_Materiales (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50),
    descripcion TEXT
);

-- Tabla: Materiales
CREATE TABLE IF NOT EXISTS Materiales (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre_material VARCHAR(100),
    descripcion TEXT,
    unidad_base VARCHAR(10),
    id_categoria INT,
    estado VARCHAR(20),
    FOREIGN KEY (unidad_base) REFERENCES Unidades_Medida(id_unidad),
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Materiales(id_categoria)
);

-- Tabla: Ubicaciones
CREATE TABLE IF NOT EXISTS Ubicaciones (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ubicacion VARCHAR(50),
    tipo_ubicacion VARCHAR(30),
    descripcion TEXT
);

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

-- Tabla: Tipos_Movimiento
CREATE TABLE IF NOT EXISTS Tipos_Movimiento (
    id_tipo_mov INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_tipo VARCHAR(50)
);

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
