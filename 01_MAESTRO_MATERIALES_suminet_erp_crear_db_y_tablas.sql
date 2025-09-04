-- =====================================================================================================
-- MÓDULO MAESTRO MATERIALES - SUMINET ERP - GONZALO MARTINEZ ROMAN - CREACIÓN DE BASE DE DATOS Y TABLAS
-- =====================================================================================================

-- 0-Crear base de datos
CREATE DATABASE IF NOT EXISTS suminet_erp;
USE suminet_erp;

-- 1-Materiales
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

-- 2-Categorias_Materiales
CREATE TABLE IF NOT EXISTS Categorias_Materiales (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50),
    descripcion TEXT,
    CONSTRAINT chk_id_categoria CHECK (id_categoria % 1000 = 0) -- Asegura múltiplos de 1000
);

-- 3-Unidades_Medida
CREATE TABLE IF NOT EXISTS Unidades_Medida (
    id_unidad VARCHAR(10) PRIMARY KEY,
    descripcion VARCHAR(50)
);

