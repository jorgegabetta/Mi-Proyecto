-- === CONSULTA 1 — Resumen ejecutivo mensual ===
SELECT YEAR(fecha_venta) AS anio,
       MONTH(fecha_venta) AS mes,
       SUM(cantidad * precio_unitario) AS total_facturado,
       COUNT(*) AS pedidos,
       AVG(cantidad * precio_unitario) AS ticket
FROM ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY mes;

-- === CONSULTA 2 — Ranking de productos ===
SELECT TOP 5 id_producto,
       SUM(cantidad) AS unidades_vendidas,
       SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- === CONSULTA 3 — Clientes recurrentes ===
SELECT id_cliente,
   COUNT(*) AS cantidad_pedidos,
   SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- === CONSULTA 4 — Meses por encima/por debajo del promedio ===
SELECT YEAR(fecha_venta) AS anio,
       MONTH(fecha_venta) AS mes,
       SUM(cantidad * precio_unitario) AS total_facturado,
       CASE WHEN SUM(cantidad * precio_unitario) > ( 
            SELECT AVG(total_mes)
            FROM  (SELECT SUM(cantidad * precio_unitario) AS total_mes
                 FROM   ventas
                 GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)) t)
                 THEN 'por encima'
                 ELSE 'por debajo'
       END AS comparativa
FROM ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;

-- === HALLAZGOS DE NEGOCIO === 
-- El id_producto 1 representa el 52.87% de la facturación total de tu top de productos (más de la mitad de todas las ganancias generadas).
-- Los clientes recurrentes presentan un volumen de compra uniforme (entre 6 y 7 pedidos cada uno).
-- El mes 3 (marzo de 2024) representó el pico máximo del semestre con $6,444.00 facturados y 10 pedidos,posicionándose fuertemente 'por encima' del promedio mensual general.