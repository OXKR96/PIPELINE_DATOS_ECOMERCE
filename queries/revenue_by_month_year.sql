-- TODO: Esta consulta devolverá una tabla con los ingresos por mes y año.
-- Tendrá varias columnas: month_no, con los números de mes del 01 al 12;
-- month, con las primeras 3 letras de cada mes (ej. Ene, Feb);
-- Year2016, con los ingresos por mes de 2016 (0.00 si no existe);
-- Year2017, con los ingresos por mes de 2017 (0.00 si no existe); y
-- Year2018, con los ingresos por mes de 2018 (0.00 si no existe).


-- Consulta para obtener ingresos por mes y año
WITH RevenueData AS (
    SELECT 
        CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) AS month_no,
        CASE 
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 1 THEN 'Jan'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 2 THEN 'Feb'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 3 THEN 'Mar'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 4 THEN 'Apr'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 5 THEN 'May'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 6 THEN 'Jun'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 7 THEN 'Jul'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 8 THEN 'Aug'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 9 THEN 'Sep'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 10 THEN 'Oct'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 11 THEN 'Nov'
            WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) = 12 THEN 'Dec'
        END AS month,
        strftime('%Y', o.order_purchase_timestamp) AS year,
        SUM(op.payment_value) AS revenue
    FROM 
        olist_orders o
    JOIN 
        olist_order_payments op ON o.order_id = op.order_id
    WHERE 
        o.order_status = 'delivered'
    GROUP BY 
        month_no, year
)

SELECT 
    month_no,
    month,
    ROUND(MAX(CASE WHEN year = '2016' THEN revenue END), 2) AS Year2016,
    ROUND(MAX(CASE WHEN year = '2017' THEN revenue END), 2) AS Year2017,
    ROUND(MAX(CASE WHEN year = '2018' THEN revenue END), 2) AS Year2018
FROM 
    RevenueData
GROUP BY 
    month_no, month
ORDER BY 
    month_no;