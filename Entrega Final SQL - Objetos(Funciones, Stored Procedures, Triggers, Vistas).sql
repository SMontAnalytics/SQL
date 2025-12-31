USE supermarket_sales;

-- Funciones, Stored Procedures, Triggers y Vistas.


-- Funciones


-- 1) Funcion para venta maxima y minima por linea de producto.
DELIMITER $$
DROP FUNCTION IF EXISTS Obtener_Ventas_Max_Min;
CREATE FUNCTION Obtener_Ventas_Max_Min()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE resultado TEXT;
    
    SELECT GROUP_CONCAT(
        CONCAT(
            'Línea: ', nombre_de_linea, 
            ' | Venta Máxima: ', venta_maxima, 
            ' | Venta Mínima: ', venta_minima
        ) SEPARATOR '\n'
    ) 
    INTO resultado
    FROM (
        SELECT 
            lp.nombre_de_linea, 
            MAX(v.total) AS venta_maxima, 
            MIN(v.total) AS venta_minima
        FROM ventas v
        JOIN linea_de_producto lp ON v.linea_de_producto_id = lp.linea_de_producto_id
        GROUP BY lp.nombre_de_linea
    ) AS subquery;
    
    RETURN resultado;
END $$

DELIMITER ;


-- 2) Funcion para obtener el promedio de ventas por ciudad.
DELIMITER $$
DROP FUNCTION IF EXISTS Obtener_Promedio_Ventas_Por_Ciudad;
CREATE FUNCTION Obtener_Promedio_Ventas_Por_Ciudad()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE resultado TEXT DEFAULT '';

    
    SELECT GROUP_CONCAT(
        CONCAT(
            'Ciudad: ', nombre_ciudad, 
            ' | Promedio de Ventas: ', promedio_ventas
        ) SEPARATOR '\n'
    ) 
    INTO resultado
    FROM (
        SELECT 
            c.nombre_ciudad, 
            ROUND(AVG(v.total), 2) AS promedio_ventas
        FROM ventas v
        JOIN ciudad c ON v.ciudad_id = c.ciudad_id
        GROUP BY c.nombre_ciudad
    ) AS subquery;

    RETURN resultado;
END $$

DELIMITER ;


-- Stored Procedures


-- 1) Stored Procedure para actualizar la calificaion asignada.
DELIMITER $$
DROP PROCEDURE IF EXISTS Actualizar_Calificacion_Venta;
CREATE PROCEDURE Actualizar_Calificacion_Venta (
    IN p_factura_id VARCHAR(255),
    IN p_nueva_calificacion INT
)
BEGIN
    DECLARE factura_existe INT;

    SELECT COUNT(*) INTO factura_existe
    FROM Ventas
    WHERE Factura_id = p_factura_id;

    IF factura_existe > 0 THEN
        UPDATE Ventas
        SET Calificacion = p_nueva_calificacion
        WHERE Factura_id = p_factura_id;
        SELECT 'Calificación actualizada.' AS Mensaje;
    ELSE
        SELECT 'Factura no encontrada.' AS Mensaje;
    END IF;
END $$

DELIMITER ;



-- 2) Stored procedure para obtener el total de ingresos brutos y costos directos por clientes.
DELIMITER $$
DROP PROCEDURE IF EXISTS Calcular_Ingresos_Costos_Clientes;
CREATE PROCEDURE Calcular_Ingresos_Costos_Clientes (
    IN p_cliente_id INT
)
BEGIN
    SELECT
        c.tipo_de_cliente,
        SUM(v.Ingreso_Bruto) AS Total_Ingresos_Brutos,
        SUM(v.Costos_Directos) AS Total_Costos_Directos
    FROM
        Ventas v
    JOIN
        Cliente c ON v.Cliente_id = c.Cliente_id
    WHERE
        v.Cliente_id = p_cliente_id
    GROUP BY
        c.tipo_de_cliente;
END $$

DELIMITER ;



-- Triggers


-- 1) Trigger que envia un mensaje error cuando falta una de las claves foraneas al insertar registros en la tabla ventas.
DELIMITER $$
DROP TRIGGER IF EXISTS Ventas_Antes_Insertar_Validacion;
CREATE TRIGGER Ventas_Antes_Insertar_Validacion
BEFORE INSERT ON Ventas
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sucursal WHERE Sucursal_id = NEW.Sucursal_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La Sucursal_id no existe.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Cliente WHERE Cliente_id = NEW.Cliente_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Cliente_id no existe.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Ciudad WHERE Ciudad_id = NEW.Ciudad_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Ciudad_id no existe.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Genero WHERE Genero_id = NEW.Genero_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Genero_id no existe.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Linea_de_Producto WHERE Linea_de_Producto_id = NEW.Linea_de_Producto_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Linea_de_Producto_id no existe.';
    ELSEIF NOT EXISTS (SELECT 1 FROM Metodo_de_Pago WHERE Metodo_de_Pago_id = NEW.Metodo_de_Pago_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Metodo_de_Pago_id no existe.';
    END IF;
END $$
DELIMITER ;
   
-- 2) Trigger que impide la eliminacion de registros de la tabla ventas.
DELIMITER $$
DROP TRIGGER IF EXISTS Ventas_Antes_Borrar_No_Permitido;
CREATE TRIGGER Ventas_Antes_Borrar_No_Permitido
BEFORE DELETE ON Ventas
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El factura_id no puede eliminarse.';
END $$
DELIMITER ;


-- Vistas

-- 1) Vista que muestra el total de impuestos TAX por metodos de pago.
DROP VIEW IF EXISTS Total_Tax_Por_Metodo_Pago;
CREATE VIEW Total_Tax_Por_Metodo_Pago AS
SELECT
    mp.tipo_de_metodo AS Metodo_Pago,
    SUM(v.Tax) AS Total_Tax
FROM
    Ventas v
JOIN
    Metodo_de_Pago mp ON v.Metodo_de_Pago_id = mp.Metodo_de_Pago_id
GROUP BY
    mp.tipo_de_metodo;
    
-- 2) Vista que muestra el promedio de calificacion por sucursal.    
DROP VIEW IF EXISTS Promedio_Calificacion_Por_Sucursal;    
CREATE VIEW Promedio_Calificacion_Por_Sucursal AS
SELECT
    s.nombre_sucursal AS Nombre_Sucursal,
    AVG(v.Calificacion) AS Promedio_Calificacion
FROM
    Ventas v
JOIN
    Sucursal s ON v.Sucursal_id = s.Sucursal_id
GROUP BY
    s.nombre_sucursal;
 
 
-- 3) Vista que muestra la cantidad de facturas emitidas por ciudad
DROP VIEW IF EXISTS Cantidad_Facturas_Por_Ciudad;
CREATE VIEW Cantidad_Facturas_Por_Ciudad AS
SELECT
    c.nombre_ciudad AS Ciudad,
    COUNT(v.Factura_id) AS Cantidad_Facturas
FROM
    Ventas v
JOIN
    Ciudad c ON v.Ciudad_id = c.Ciudad_id
GROUP BY
    c.nombre_ciudad;
    
-- 4) Vista que muestra el TOP de lineas de productos mas vendidas 
DROP VIEW IF EXISTS Top_Lineas_Producto_Mas_Vendidas;
CREATE VIEW Top_Lineas_Producto_Mas_Vendidas AS
SELECT
    lp.nombre_de_linea AS Linea_Producto,
    SUM(v.Cantidad) AS Cantidad_Total_Vendida
FROM
    Ventas v
JOIN
    Linea_de_Producto lp ON v.Linea_de_Producto_id = lp.Linea_de_Producto_id
GROUP BY
    lp.nombre_de_linea
ORDER BY
    Cantidad_Total_Vendida DESC;
    
-- 5) Vista que muestra el total de ganancias por genero y linea de producto.
DROP VIEW IF EXISTS Ganancias_Por_Genero_Linea_Producto;
CREATE VIEW Ganancias_Por_Genero_Linea_Producto AS
SELECT
    g.tipo_de_genero AS Genero,
    lp.nombre_de_linea AS Linea_Producto,
    SUM(v.Total) AS Total_Ganancias
FROM
    Ventas v
JOIN
    Genero g ON v.Genero_id = g.Genero_id
JOIN
    Linea_de_Producto lp ON v.Linea_de_Producto_id = lp.Linea_de_Producto_id
GROUP BY
    g.tipo_de_genero, lp.nombre_de_linea;