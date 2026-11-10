# RetailPro - Modelo Relacional y Análisis de Datos SQL

## Descripción del Proyecto
Este proyecto implementa el diseño, creación y carga de la base de datos relacional para **RetailPro**, un negocio de retail enfocado en el análisis semestral de ventas, rentabilidad y rendimiento por categorías y regiones.

El modelo se encuentra normalizado en **Tercera Forma Normal (3NF)** y sigue un esquema analítico tipo estrella compuesto por 4 tablas principales:
- `categorias`: Dimensión de categorías de productos.
- `clientes`: Dimensión de clientes registrados con su ubicación.
- `productos`: Dimensión de catálogo de productos con precios y stock.
- `ventas`: Tabla de hechos que registra cada transacción realizada.

---

## Requisitos y Entorno de Ejecución
- **Motor de Base de Datos:** SQL Server (Azure SQL / T-SQL)
- **Herramientas de Gestión:** SQL Server Management Studio (SSMS), Azure Data Studio o DBeaver.
- **Herramientas de BI:** Power BI Desktop (para la carga del modelo de datos y validación de medidas DAX).

---

## Estructura del Script Principal (`script_ventas_tech.sql`)
El script ejecutable se divide en 4 secciones secuenciales:

1. **Sección 1 (DROP):** Elimina las tablas preexistentes si ya fueron creadas, permitiendo reiniciar el entorno limpio sin conflictos de claves foráneas.
2. **Sección 2 (CREATE TABLE - DDL):** Define la estructura de las 4 tablas principales con sus claves primarias (`PK`), claves foráneas (`FK`) y restricciones (`UNIQUE`, `DEFAULT`, `NOT NULL`).
3. **Sección 3 (INSERT INTO - DML):** Puebla las tablas con información de prueba para clientes, productos, categorías y transacciones de venta.
4. **Sección 4 (VALIDACIÓN - DQL):** Realiza consultas de verificación (`SELECT *`) para corroborar la correcta persistencia de la información.

---

## Instrucciones para Ejecutar el Proyecto

1. Abrí tu herramienta de gestión de bases de datos (SSMS o Azure Data Studio) y conectate a tu servidor de SQL Server.
2. Creá y seleccioná la base de datos del proyecto:
   ```sql
   CREATE DATABASE Ventas_Tech_DB;
   GO
   USE Ventas_Tech_DB;
   GO
Ejecutá el script de creación y carga inicial de datos (script_ventas_tech.sql).

Para correr las consultas avanzadas de análisis y reporte comercial, ejecutá el archivo de joins:

SQL
m5_consultas_joins.sql
Abrí Power BI Desktop, seleccioná la opción Obtener datos > SQL Server e importá las tablas para iniciar el modelado y la construcción de medidas en DAX.
