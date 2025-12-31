-- Pruebas de Funciones, Stored Procedures, Triggers y Vistas.
USE supermarket_sales;

-- Funciones

SELECT Obtener_Ventas_Max_Min(); -- Se retornara el maximo y minimo de ventas por linea de productos.

SELECT Obtener_Promedio_Ventas_Por_Ciudad(); -- Se retornara el promedio de ventas por linea de productos

-- Stored Procedures

CALL Actualizar_Calificacion_Venta('357-85-5576', 5); -- El resultado retornara error como ejemplo.

CALL Calcular_Ingresos_Costos_Clientes(1); -- Se ingresa el id de cliente para hacer los calculos.

-- Triggers

INSERT INTO Ventas (Factura_id, Sucursal_id, Ciudad_id, Cliente_id, Genero_id, Linea_de_Producto_id, Metodo_de_Pago_id, Precio_Unitario, Cantidad, Tax, Fechas, Costos_Directos, Ingreso_Bruto, Calificacion)
VALUES ('985-57-99', 1, 1, 1, 1, 1, 999, 10.00, 1, 1.00, '2023-10-27', 5.00, 15.00, 5); -- Esta sentencia activara el trigger de validar antes de insertar.

DELETE FROM Ventas WHERE Factura_id = '101-17-6199'; -- El trigger impedira la eliminacion de la factura.

-- Vistas

SELECT * FROM Total_Tax_Por_Metodo_Pago; -- La vista mostrara el total de TAX por metodo de pago.

SELECT * FROM Promedio_Calificacion_Por_Sucursal; -- La vista muetra el promedio de calificaciones.

SELECT * FROM Cantidad_Facturas_Por_Ciudad; -- La vista mostrara el numero de facturas emitidas por ciudad.

SELECT * FROM Top_Lineas_Producto_Mas_Vendidas; -- La vista mostrara el TOP de lineas mas vendidas.

SELECT * FROM Ganancias_Por_Genero_Linea_Producto; -- La vista muestra el total de ganancias por genero y linea de productos.