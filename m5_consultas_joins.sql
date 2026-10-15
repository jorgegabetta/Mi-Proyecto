-- Pre-entrega 5: Consultas con JOINs para el proyecto

-- Título: Cruzando tablas para enriquecer el análisis

-- Descripción: Las consultas de M4 trabajaban sobre tablas individuales. Ahora vas a cruzarlas para obtener la vista enriquecida que necesita Power BI: ventas con nombre de cliente, nombre de producto, categoría y región en una sola consulta. Esta vista es la materia prima del dashboard que vas a construir en M7.

-- Contexto

-- El equipo de análisis de RetailPro necesita una vista única que cruce toda la información del negocio. Además, el área de CRM quiere saber qué clientes nunca compraron y el área de producto quiere identificar qué artículos del catálogo no tienen movimiento. Tu tarea es responder las tres preguntas con JOINs.


-- ------------------------------------------------------------
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: unificar la tabla de hechos con las dimensiones para Power BI.
-- ------------------------------------------------------------
SELECT 
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS ciudad_cliente,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM dbo.ventas v
INNER JOIN dbo.clientes c ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos p ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias cat ON p.id_categoria = cat.id_categoria;

-- Hallazgo: Se consolidó toda la información transaccional y dimensional en una sola vista lista para ser consumida como fuente principal por el dashboard de Power BI.


-- ------------------------------------------------------------
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Propósito: identificar clientes registrados que no han realizado compras.
-- ------------------------------------------------------------
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM dbo.clientes c
LEFT JOIN dbo.ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Hallazgo: Actualmente 0 clientes de los registrados se encuentran sin compras (todos tienen al menos un pedido), lo que indica una tasa de conversión inicial del 100% para el equipo de CRM.


-- ------------------------------------------------------------
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Propósito: detectar artículos del catálogo que no registran movimiento.
-- ------------------------------------------------------------
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM dbo.productos p
INNER JOIN dbo.categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN dbo.ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Hallazgo: Todos los productos del catálogo actual presentan al menos una venta registrada, lo que muestra un buen nivel de rotación de inventario para el área de productos.


-- ------------------------------------------------------------
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Propósito: segmentar y sumarizar las ventas totales separándolas por canal de origen.
-- ------------------------------------------------------------
SELECT canal, SUM(total) AS total_canal
FROM (
    -- Primer SELECT: Ventas de período A (Online)
    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Online' AS canal
    FROM dbo.ventas 
    WHERE fecha_venta < '2024-03-01'
    
    UNION ALL
    
    -- Segundo SELECT: Ventas de período B (Presencial)
    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Presencial' AS canal
    FROM dbo.ventas 
    WHERE fecha_venta >= '2024-03-01'
) AS consolidado
GROUP BY canal;

-- Hallazgo: El canal Presencial acumula la mayor parte de la facturación en comparación con el período inicial Online, permitiendo evaluar la distribución de ingresos por canal.