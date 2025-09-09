-- CREACION DE BASE DE DATOS --

CREATE DATABASE IF NOT EXISTS m5_portafolio_02;
USE m5_portafolio_02;

-- CREACION DE TABLAS --

CREATE TABLE IF NOT EXISTS cliente(
    id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS articulo(
    id_articulo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_articulo VARCHAR(50) NOT NULL,
    precio INT NOT NULL,
    stock INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pedido(
    id_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    id_articulo INT NOT NULL,
    cantidad INT NOT NULL,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_articulo
        FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- INSERCION DE DATOS --

INSERT INTO cliente (nombre_cliente, telefono, direccion, correo) VALUES
('Juan Perez', 923456789, 'Los Olmos 123', 'juanperez@gmail.com'),
('Maria Gomez', 987654321, 'Los Olivos 456', 'mariagomez@gmail'),
('Pedro Garcia', 955756789, 'Las Dalias 789', 'pedrogarcia@gmail'),
('Ana Lopez', 987654721, 'Av. Prat 123', 'analopez@gmail'),
('Luis Martinez', 923776789, 'Av. Carrera 456', 'luismartinez@gmail'),
('Sofia Rodriguez', 987654323, 'Av. Libertad 789', 'sofiarodriguez@gmail'),
('Miguel Sanchez', 923756789, 'Las Montañas 123', 'miguelsanchez@gmail'),
('Carolina Fernandez', 987657321, 'Av. Los Libertadores 456', 'carolinafernandez@gmail'),
('Diego Gutierrez', 933456789, 'Las Torres 789', 'diegogutierrez@gmail'),
('Valentina Hernandez', 977654321, 'Las Acacias 123', 'valentinahernandez@gmail');

INSERT INTO articulo (nombre_articulo, precio, stock) VALUES
('Camisa', 49990, 50),
('Pantalon', 39990, 50),
('Zapatos', 54990, 50),
('Polera', 29990, 50),
('Chaqueta', 59990, 50),
('Poleron', 34990, 50),
('Corbata', 24990, 50),
('Vestido', 59990, 50);

INSERT INTO pedido (fecha, id_articulo, cantidad, id_cliente) VALUES
('2025-09-01', 1, 1, 1),
('2025-09-01', 4, 1, 2),
('2025-09-01', 3, 1, 3),
('2025-09-02', 1, 1, 1),
('2025-09-02', 2, 2, 2),
('2025-09-02', 3, 1, 3),
('2025-09-03', 6, 3, 1),
('2025-09-03', 2, 2, 2),
('2025-09-03', 3, 1, 3),
('2025-09-04', 1, 1, 1),
('2025-09-04', 2, 2, 2),
('2025-09-04', 3, 1, 3),
('2025-09-05', 1, 1, 1),
('2025-09-05', 2, 2, 2),
('2025-09-05', 3, 1, 3),
('2025-09-06', 1, 1, 1),
('2025-09-06', 8, 2, 2),
('2025-09-06', 3, 1, 3),
('2025-09-07', 6, 1, 1),
('2025-09-07', 2, 2, 2),
('2025-09-07', 3, 1, 3),
('2025-09-08', 1, 2, 1),
('2025-09-08', 2, 2, 2),
('2025-09-08', 5, 2, 3),
('2025-09-08', 1, 1, 4),
('2025-09-08', 2, 1, 5);

-- CONSULTAS --

-- Crear una consulta que obtenga todos los pedidos realizados por un cliente específico. --
SELECT 
    p.id_pedido, 
    p.fecha, 
    a.nombre_articulo, 
    p.cantidad,
    SUM(a.precio * p.cantidad) AS total
FROM pedido p
INNER JOIN articulo a ON p.id_articulo = a.id_articulo
WHERE p.id_cliente = 1
GROUP BY p.id_pedido, p.fecha, a.nombre_articulo
ORDER BY p.id_pedido ASC;

-- Crear una consulta que obtenga el total de ventas de un producto durante el mes atual. --
SELECT p.id_articulo, a.nombre_articulo, SUM(a.precio * p.cantidad) AS total_ventas
FROM pedido p
INNER JOIN articulo a ON p.id_articulo = a.id_articulo
WHERE MONTH(p.fecha) = MONTH(CURRENT_DATE()) AND p.id_articulo = 1;

-- Crear una consulta que identifique el artículo que no haya sido vendido  la semana anterior. --
SELECT a.id_articulo, a.nombre_articulo, a.stock
FROM articulo a
WHERE a.id_articulo NOT IN (
    SELECT p.id_articulo
    FROM pedido p
    WHERE DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) <= p.fecha
);


DROP TABLE pedido;
DROP TABLE articulo;
DROP TABLE cliente;