
-- ===============================================
-- Script: suminet_erp_crear_tablas_modulo_proveedores.sql
-- Descripción: Crea las tablas del módulo de proveedores para Suminet ERP
-- ===============================================

-- Tabla: Registro_Proveedores
CREATE TABLE Registro_Proveedores (
    id_proveedor INT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    cuit VARCHAR(15) UNIQUE NOT NULL,
    direccion VARCHAR(150),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    pais VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(100),
    sitio_web VARCHAR(100),
    estado VARCHAR(20),
    fecha_alta DATE,
    fecha_baja DATE
);

-- Tabla: Alcance_Actividad
CREATE TABLE Alcance_Actividad (
    id_actividad INT PRIMARY KEY,
    nombre_actividad VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla: Proveedor_Actividad
CREATE TABLE Proveedor_Actividad (
    id_proveedor INT,
    id_actividad INT,
    PRIMARY KEY (id_proveedor, id_actividad),
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor),
    FOREIGN KEY (id_actividad) REFERENCES Alcance_Actividad(id_actividad)
);

-- Tabla: Actividad_Categoria
CREATE TABLE Actividad_Categoria (
    id_actividad INT,
    id_categoria INT,
    fecha_asociacion DATE,
    estado VARCHAR(20),
    PRIMARY KEY (id_actividad, id_categoria),
    FOREIGN KEY (id_actividad) REFERENCES Alcance_Actividad(id_actividad),
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Materiales(id_categoria)
);

-- Tabla: Contactos_Proveedor
CREATE TABLE Contactos_Proveedor (
    id_contacto INT PRIMARY KEY,
    id_proveedor INT,
    nombre_contacto VARCHAR(100),
    cargo VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(100),
    estado ENUM('Activo', 'Obsoleto') DEFAULT 'Activo',
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor)
);

-- Tabla: Evaluaciones_Desempeno
CREATE TABLE Evaluaciones_Desempeno (
    id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    puntaje DECIMAL(5,2) CHECK (puntaje BETWEEN 0 AND 100),
    resultado ENUM('Apto', 'No Apto', 'Condicionado') NOT NULL,
    evaluador VARCHAR(100) NOT NULL,
    comentarios TEXT,
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor) ON DELETE CASCADE
);

-- Tabla: Proveedor_Categoria_Aprobada 
CREATE TABLE Proveedor_Categoria_Aprobada (
    id_proveedor INT NOT NULL,
    id_categoria INT NOT NULL,
    fecha_aprobacion DATE NOT NULL,
    fecha_vencimiento DATE,
    id_evaluacion INT, -- Evaluación que generó esta aprobación
    estado ENUM('Apto', 'No Apto', 'En Revisión') DEFAULT 'En Revisión',
    PRIMARY KEY (id_proveedor, id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Materiales(id_categoria),
    FOREIGN KEY (id_evaluacion) REFERENCES Evaluaciones_Desempeno(id_evaluacion)
);
