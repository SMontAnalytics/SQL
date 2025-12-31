USE supermarket_sales;

-- Tabla Sucursal
INSERT INTO sucursal (nombre_sucursal)  
VALUES  
('A'),  
('B'),  
('C');  

-- Tabla Genero
INSERT INTO genero (tipo_de_genero)
VALUES    
('Masculino'),
('Femenino');

-- Tabla Cliente

INSERT INTO cliente (tipo_de_cliente)
VALUES
('Miembro'),
('Normal');

-- Tabla Ciudad 

INSERT INTO ciudad (nombre_ciudad)
VALUES
('Mandalay'),
('Naypyitaw'),
('Yangon');

-- Tabla Linea de Productos

INSERT INTO linea_de_producto (nombre_de_linea)
VALUES
('Accesorios Electronicos'),
('Accesorios de Moda'),
('Alimentos y Bebidas'),
('Salud y Belleza'),
('Hogar y Estilo de Vida'),
('Deportes y viajes');

-- Tabla Metodos de Pago

INSERT INTO metodo_de_pago (tipo_de_metodo)
VALUES
('Efectivo'),
('Targeta de Credito'),
('E-wallet');

SELECT * FROM ventas

