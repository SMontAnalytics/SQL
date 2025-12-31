
DROP DATABASE IF EXISTS supermarket_sales;
CREATE DATABASE supermarket_sales;
USE supermarket_sales;

-- Creacion de tablas

-- Tabla Sucursal
CREATE TABLE sucursal(
sucursal_id INT NOT NULL AUTO_INCREMENT,
nombre_sucursal CHAR,
PRIMARY KEY (sucursal_id)
);

-- Tabla Genero
CREATE TABLE genero(
genero_id INT NOT NULL AUTO_INCREMENT,
tipo_de_genero CHAR(10),
PRIMARY KEY (genero_id)
);

-- Tabla Ciudad
CREATE TABLE ciudad(
ciudad_id INT NOT NULL AUTO_INCREMENT,
nombre_ciudad CHAR(10),
PRIMARY KEY (ciudad_id)
);

-- Tabla Cliente
CREATE TABLE cliente(
cliente_id INT NOT NULL AUTO_INCREMENT,
tipo_de_cliente CHAR(7),
PRIMARY KEY (cliente_id)
);

-- Tabla Linea de Producto

CREATE TABLE linea_de_producto(
linea_de_producto_id INT NOT NULL AUTO_INCREMENT,
nombre_de_linea CHAR(25),
PRIMARY KEY (linea_de_producto_id)
);

-- Tabla Metodo de Pago

CREATE TABLE metodo_de_pago(
metodo_de_pago_id INT NOT NULL AUTO_INCREMENT,
tipo_de_metodo CHAR(18),
PRIMARY KEY (metodo_de_pago_id)
);

-- Tabla ventas

CREATE TABLE ventas(
factura_id VARCHAR(11) NOT NULL,
sucursal_id INT,
ciudad_id INT,
cliente_id INT,
genero_id INT,
linea_de_producto_id INT,
metodo_de_pago_id INT,
precio_unitario DECIMAL(10,2),
cantidad INT,
tax DECIMAL(10,3),
total DECIMAL(10,3),
fechas DATETIME,
costos_directos DECIMAL (10,2),
ingreso_bruto DECIMAL(10,3),
calificacion DECIMAL(10,1),
PRIMARY KEY(factura_id),
FOREIGN KEY(sucursal_id) REFERENCES sucursal (sucursal_id),
FOREIGN KEY(ciudad_id) REFERENCES ciudad (ciudad_id),
FOREIGN KEY(cliente_id) REFERENCES cliente (cliente_id),
FOREIGN KEY(genero_id) REFERENCES genero (genero_id),
FOREIGN KEY(linea_de_producto_id) REFERENCES linea_de_producto (linea_de_producto_id),
FOREIGN KEY(metodo_de_pago_id) REFERENCES metodo_de_pago (metodo_de_pago_id)
);





