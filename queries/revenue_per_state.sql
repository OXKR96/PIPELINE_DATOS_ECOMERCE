-- TODO: Esta consulta devolverá una tabla con dos columnas; customer_state y Revenue.
-- La primera contendrá las abreviaturas que identifican a los 10 estados con mayores ingresos,
-- y la segunda mostrará el ingreso total de cada uno.
-- PISTA: Todos los pedidos deben tener un estado "delivered" y la fecha real de entrega no debe ser nula.


-- Consulta para obtener ingresos por estado
SELECT 
    c.customer_state,
    ROUND(SUM(op.payment_value), 2) AS Revenue
FROM 
    olist_orders o
JOIN 
    olist_customers c ON o.customer_id = c.customer_id
JOIN 
    olist_order_payments op ON o.order_id = op.order_id
WHERE 
    o.order_status = 'delivered' 
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    c.customer_state
ORDER BY 
    Revenue DESC
LIMIT 10;