-- CREACION DE BASE DE DATOS --

CREATE DATABASE IF NOT EXISTS m5_portafolio_01;
USE m5_portafolio_01;

-- CREACION DE TABLAS --

CREATE TABLE IF NOT EXISTS cliente(
    id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pedido(
    id_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    articulo VARCHAR(50) NOT NULL,
    total INT NOT NULL,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- INSERCION DE DATOS --

INSERT INTO cliente (nombre, apellido, telefono, direccion, correo) VALUES
('Juan', 'Perez', 923456789, 'Los Olmos 123', 'juanperez@gmail.com'),
('Maria', 'Gomez', 987654321, 'Los Olivos 456', 'mariagomez@gmail'),
('Pedro', 'Garcia', 923756789, 'Las Dalias 789', 'pedrogarcia@gmail'),
('Ana', 'Lopez', 987654721, 'Av. Prat 123', 'analopez@gmail'),
('Luis', 'Martinez', 923776789, 'Av. Carrera 456', 'luismartinez@gmail');

INSERT INTO pedido (fecha, articulo, total, id_cliente) VALUES
('2025-09-08', 'Camisa', 49990, 1),
('2025-09-08', 'Pantalon', 39990, 2),
('2025-09-08', 'Zapatos', 54990, 3),
('2025-09-08', 'Camisa', 49990, 4),
('2025-09-08', 'Pantalon', 39990, 5);