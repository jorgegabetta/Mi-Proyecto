-- Pre-entrega: Consultas con JOINs para el proyecto

-- Título: Cruzando tablas para enriquecer el análisis

-- Descripción: Las consultas de M4 trabajaban sobre tablas individuales. Ahora vas a cruzarlas para obtener la vista enriquecida que necesita Power BI: ventas con nombre de cliente, nombre de producto, categoría y región en una sola consulta. Esta vista es la materia prima del dashboard que vas a construir en M7.

-- Contexto

-- El equipo de análisis de RetailPro necesita una vista única que cruce toda la información del negocio. Además, el área de CRM quiere saber qué clientes nunca compraron y el área de producto quiere identificar qué artículos del catálogo no tienen movimiento. Tu tarea es responder las tres preguntas con JOINs.

-- Instrucciones

-- Creá un archivo m5_consultas_joins.sql en tu repositorio con las siguientes consultas:

-- ============================================================
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- ============================================================
SELECT 
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS ciudad_cliente,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM dbo.ventas v
INNER JOIN dbo.clientes c ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos p ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias cat ON p.id_categoria = cat.id_categoria;

-- ============================================================
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- ============================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM dbo.clientes c
LEFT JOIN dbo.ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- ============================================================
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- ============================================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM dbo.productos p
INNER JOIN dbo.categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN dbo.ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- ============================================================
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- ============================================================

SELECT canal, SUM(total) AS total_canal
FROM (
    -- Primer SELECT: Ventas de canales o periodos A (ej: primer trimestre o ventas menores/iguales a un monto)
    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Online' AS canal
    FROM dbo.ventas 
    WHERE fecha_venta < '2024-03-01'
    
    UNION ALL
    
    -- Segundo SELECT: Ventas de canales o periodos B (ej: a partir de marzo)
    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Presencial' AS canal
    FROM dbo.ventas 
    WHERE fecha_venta >= '2024-03-01'
) AS consolidado
GROUP BY canal;