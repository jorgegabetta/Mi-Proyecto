 - # Ventas Tech DB - Modelo Relacional

## Descripción del Proyecto
Este proyecto implementa el diseño, creación y carga inicial de la base de datos relacional `Ventas_Tech_DB` para el caso de retail tecnológico TechStore.

El esquema se encuentra normalizado en Tercera Forma Normal (3NF) y está compuesto por cuatro tablas:
- `categorias` (Dimensión de categorías de productos)
- `clientes` (Dimensión de clientes y registro)
- `productos` (Dimensión de catálogo con precios y stock)
- `ventas` (Tabla de hechos con el registro de transacciones)

## Requisitos y Entorno
- Motor de Base de Datos: SQL Server 
- Herramienta de Gestión: SQL Server Management Studio (SSMS)

## Estructura del Script
El archivo `ventas_tech_db.sql` se divide en 4 partes principales:
1. Sección 1 (DROP): Borra las tablas si ya existen para poder reiniciar la base limpia sin errores de claves foráneas.
2. Sección 2 (CREATE TABLE): Crea la estructura de las 4 tablas con sus Primary Key, Foreign Key y restricciones como UNIQUE o DEFAULT.
3. Sección 3 (INSERT): Carga los datos de prueba en cada una de las tablas (categorías, clientes, productos y ventas).
4. Sección 4 (VALIDACIÓN): Ejecuta los SELECT * en todas las tablas para verificar que la información se guardó correctamente.

## Instrucciones de Ejecución
1. Abrir la herramienta de gestión y conectarse a la instancia de SQL Server.
2. Crear la base de datos `Ventas_Tech_DB` (si no existe) y seleccionarla:
   ` CREATE DATABASE Ventas_Tech_DB;
   GO
   USE Ventas_Tech_DB;
   GO`
3. Abrir el archivo `ventas_tech_db.sql`.
4. Ejecutar el script completo (tecla F5 o botón Execute).
5. Verificar en la pestaña de resultados que se muestren las 4 tablas con sus registros cargados.
