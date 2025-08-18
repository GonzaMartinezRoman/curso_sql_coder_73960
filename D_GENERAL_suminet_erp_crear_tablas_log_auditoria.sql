-- Log de modificaciones de stock, impactada por trigger log_cambios_stock

CREATE TABLE Log_Stock (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_material INT NOT NULL,
    id_ubicacion INT NOT NULL,
    cantidad_anterior INT,
    cantidad_nueva INT,
    usuario VARCHAR(50),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);