-- ================================================================
-- MÓDULO PROVEEDORES - SUMINET ERP - CREACIÓN DE TABLAS
-- ================================================================

-- Tabla: Registro_Proveedores
CREATE TABLE IF NOT EXISTS Registro_Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    cuit VARCHAR(15) UNIQUE NOT NULL,
    direccion VARCHAR(150),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    tipo_pais ENUM ('Nacional', 'Extranjero') DEFAULT 'Nacional',
    telefono VARCHAR(20),
    email VARCHAR(100),
    sitio_web VARCHAR(100),
    estado ENUM('Activo', 'Inactivo', 'Bloqueado') DEFAULT 'Activo',
    fecha_alta DATE DEFAULT (CURRENT_DATE),
    fecha_baja DATE,
    
    -- Validaciones
    CONSTRAINT chk_email_formato CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_cuit_formato CHECK (cuit REGEXP '^[0-9]{2}-[0-9]{8}-[0-9]{1}$')
);

-- Tabla: Contactos_Proveedor
-- Registra los contactos comerciales relacionados a un proveedor
CREATE TABLE IF NOT EXISTS Contactos_Proveedor (
    id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    nombre_contacto VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(100),
    area_responsabilidad ENUM('Ventas', 'Técnico', 'Administración', 'Gerencia') DEFAULT 'Ventas',
    es_contacto_principal BOOLEAN DEFAULT FALSE,
    estado ENUM('Activo', 'Obsoleto') DEFAULT 'Activo',
    fecha_alta DATE DEFAULT (CURRENT_DATE),
    
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor) ON DELETE CASCADE,
    
    -- Validaciones
    CONSTRAINT chk_contacto_email CHECK (email LIKE '%@%.%'),
    
    -- Índices
    INDEX idx_proveedor_contacto (id_proveedor),
    INDEX idx_contacto_principal (es_contacto_principal)
);

-- Tabla: Certificaciones_Proveedor
-- Registra las certificaciones que posee un proveedor y su estado.
CREATE TABLE IF NOT EXISTS Certificaciones_Proveedor (
    id_certificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    tipo_certificacion VARCHAR(50) NOT NULL, -- 'API 6A', 'ATEX', 'ISO9001', 'ASME U', 'ASME UM', etc.
    numero_certificado VARCHAR(50),
    organismo_certificador VARCHAR(100),
    alcance TEXT COMMENT 'Descripción del alcance de la certificación',
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado ENUM('Vigente', 'Vencido', 'Suspendido', 'En Trámite') DEFAULT 'En Trámite',
    
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor) ON DELETE CASCADE,
    
    -- Validaciones
    CONSTRAINT chk_fechas_cert CHECK (fecha_vencimiento >= fecha_emision),
    
    -- Índices
    INDEX idx_tipo_certificacion (tipo_certificacion),
    INDEX idx_fecha_vencimiento_cert (fecha_vencimiento),
    INDEX idx_estado_cert (estado),
    INDEX idx_proveedor_cert (id_proveedor)
);

-- Tabla: Alcance_Actividad
-- Estandariza las actividades en las cuales se clasifica y segmenta a los proveedores y establece el tipo, criticidad y requerimientos particulares.
CREATE TABLE IF NOT EXISTS Alcance_Actividad (
    id_actividad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_actividad VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tipo_actividad ENUM('Manufactura', 'Comercialización', 'Servicios', 'Ingeniería') NOT NULL,
    nivel_especialización ENUM('Commodities', 'Crítico', 'Especializado') DEFAULT 'Commodities',
	criticidad ENUM('Baja', 'Media', 'Alta') DEFAULT 'Alta',
    certificaciones_requeridas TEXT COMMENT 'API, ATEX, ISO9001, ASME U, ASME UM, etc.',
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    fecha_creacion DATE DEFAULT (CURRENT_DATE),
    
    -- Índices para performance
    INDEX idx_tipo_actividad (tipo_actividad),
    INDEX idx_nivel_especialización (nivel_especialización)
);

-- Tabla: Auditoria_Proveedores
-- Define el estado de la aptitud de un proveedor para suministrar productos relacionados a una actividad. 
CREATE TABLE IF NOT EXISTS Auditoria_Proveedores (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_actividad INT NOT NULL,
    fecha_auditoria DATE NOT NULL,
    resultado ENUM('Aceptado', 'No aceptado', 'Condicional') NOT NULL,
    auditor VARCHAR(100) NOT NULL,
    comentarios TEXT,
    tipo_auditoria ENUM('Inicial', 'Renovación', 'Extraordinaria') DEFAULT 'Inicial',
    vigencia_meses INT DEFAULT 12,
    fecha_vencimiento DATE GENERATED ALWAYS AS (DATE_ADD(fecha_auditoria, INTERVAL vigencia_meses MONTH)) STORED,
    
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor) ON DELETE CASCADE,
    FOREIGN KEY (id_actividad) REFERENCES Alcance_Actividad(id_actividad) ON DELETE CASCADE,
    
    INDEX idx_fecha_auditoria (fecha_auditoria),
    INDEX idx_resultado (resultado),
    INDEX idx_proveedor_actividad (id_proveedor, id_actividad),
    INDEX idx_fecha_vencimiento (fecha_vencimiento)
);

-- Tabla: Desempeno_Proveedores
-- Registra la evaluación de desempeño de un proveedor para una determinada actividad
CREATE TABLE IF NOT EXISTS Desempeno_Proveedores (
    id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_actividad INT NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    evaluador VARCHAR(100) NOT NULL,
    
    -- CAMPOS DE EVALUACIÓN
    competencia_tecnica DECIMAL(5,2) CHECK (competencia_tecnica BETWEEN 0 AND 100),
    cumplimiento_plazo_entrega DECIMAL(5,2) CHECK (cumplimiento_plazo_entrega BETWEEN 0 AND 100),
    servicio_post_venta DECIMAL(5,2) CHECK (servicio_post_venta BETWEEN 0 AND 100),
    calidad_de_producto DECIMAL(5,2) CHECK (calidad_de_producto BETWEEN 0 AND 100),
    
    -- PUNTAJE GENERAL COMO CAMPO CALCULADO
    puntaje_general DECIMAL(5,2) GENERATED ALWAYS AS (
        (competencia_tecnica + cumplimiento_plazo_entrega + servicio_post_venta + calidad_de_producto) / 4
    ) STORED,
    
    comentarios TEXT,
    
    FOREIGN KEY (id_proveedor) REFERENCES Registro_Proveedores(id_proveedor) ON DELETE CASCADE,
    FOREIGN KEY (id_actividad) REFERENCES Alcance_Actividad(id_actividad) ON DELETE CASCADE,
    
    INDEX idx_fecha_evaluacion (fecha_evaluacion),
    INDEX idx_puntaje_general (puntaje_general),
    INDEX idx_proveedor_actividad_eval (id_proveedor, id_actividad)
);

-- Tabla: Actividad_Categoria
-- Relaciona las categorías del maestro de materiales con las actividades que segmentan a los proveedores.
CREATE TABLE IF NOT EXISTS Actividad_Categoria (
    id_actividad INT,
    id_categoria INT,
    fecha_asociacion DATE DEFAULT (CURRENT_DATE),
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    
    PRIMARY KEY (id_actividad, id_categoria),
    FOREIGN KEY (id_actividad) REFERENCES Alcance_Actividad(id_actividad) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Materiales(id_categoria) ON DELETE CASCADE,
    
    INDEX idx_fecha_asociacion (fecha_asociacion),
    INDEX idx_estado_ac (estado)
);

