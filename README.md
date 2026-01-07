# 📊 Ventas de Supermercado (SQL)

Este proyecto consiste en el diseño e implementación de una base de datos relacional en SQL para la gestión y análisis de ventas en un supermercado. Incluye una estructura con validaciones automáticas mediante Triggers y reportes optimizados a través de Vistas.

## 🏗️ Modelo de Datos
La base de datos está compuesta por las siguientes tablas principales:

* Ventas: Tabla de hechos que registra cada transacción.

* Sucursal: Ubicaciones físicas de los puntos de venta.

* Ciudad: Localización geográfica de las sucursales.

* Cliente: Información sobre el tipo de clientes.

* Linea_de_Producto: Categorización de los productos vendidos.

* Genero: Información demográfica asociada a la venta.

* Metodo_de_Pago: Diferentes formas de pago aceptadas.

## 🚀 Funcionalidades Avanzadas
### 🛡️ Triggers (Automatización y Seguridad)
Se implementaron triggers para garantizar la integridad de los datos y prevenir errores operativos:

* Validación de Inserción: Verifica que los IDs de métodos de pago y otros campos críticos existan antes de permitir el registro.

* Mensajes de Precaución: Alerta al usuario sobre la importancia de la precisión de los datos antes de cada inserción.

* Restricción de Borrado: Impide la eliminación de facturas para mantener el historial contable, lanzando un error personalizado: "El factura_id no puede eliminarse".

### 📈 Vistas (Business Intelligence)
Para facilitar la toma de decisiones, se crearon vistas que procesan la información de manera estratégica:

* Total_Tax_Por_Metodo_Pago: Análisis de carga impositiva según la forma de pago.

* Promedio_Calificacion_Por_Sucursal: Métrica de satisfacción del cliente por ubicación.

* Cantidad_Facturas_Por_Ciudad: Volumen de transacciones geográficas.

* Top_Lineas_Producto_Mas_Vendidas: Ranking de popularidad de productos por cantidad.

* Ganancias_Por_Genero_Linea_Producto: Cruce de datos demográficos y rentabilidad.

## 🛠️ Tecnologías Utilizadas
Motor de Base de Datos: MySQL 

Herramienta de Diseño: MySQL Workbench

Lenguaje: SQL (DDL, DML)

