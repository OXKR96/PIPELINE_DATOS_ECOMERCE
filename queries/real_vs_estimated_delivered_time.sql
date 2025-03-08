-- TODO: Esta consulta devolverá una tabla con las diferencias entre los tiempos 
-- reales y estimados de entrega por mes y año. Tendrá varias columnas: 
-- month_no, con los números de mes del 01 al 12; month, con las primeras 3 letras 
-- de cada mes (ej. Ene, Feb); Year2016_real_time, con el tiempo promedio de 
-- entrega real por mes de 2016 (NaN si no existe); Year2017_real_time, con el 
-- tiempo promedio de entrega real por mes de 2017 (NaN si no existe); 
-- Year2018_real_time, con el tiempo promedio de entrega real por mes de 2018 
-- (NaN si no existe); Year2016_estimated_time, con el tiempo promedio estimado 
-- de entrega por mes de 2016 (NaN si no existe); Year2017_estimated_time, con 
-- el tiempo promedio estimado de entrega por mes de 2017 (NaN si no existe); y 
-- Year2018_estimated_time, con el tiempo promedio estimado de entrega por mes 
-- de 2018 (NaN si no existe).
-- PISTAS:
-- 1. Puedes usar la función julianday para convertir una fecha a un número.
-- 2. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
-- 3. Considera tomar order_id distintos.



-- Consulta para comparar tiempos reales y estimados de entrega por mes y año
WITH DeliveryData AS (
    SELECT 
        CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) AS month_no,
        CASE 
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 1 THEN 'Jan'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 2 THEN 'Feb'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 3 THEN 'Mar'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 4 THEN 'Apr'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 5 THEN 'May'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 6 THEN 'Jun'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 7 THEN 'Jul'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 8 THEN 'Aug'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 9 THEN 'Sep'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 10 THEN 'Oct'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 11 THEN 'Nov'
            WHEN CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) = 12 THEN 'Dec'
        END AS month,
        strftime('%Y', order_delivered_customer_date) AS year,
        AVG(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)) AS real_time,
        AVG(julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp)) AS estimated_time
    FROM 
        olist_orders
    WHERE 
        order_status = 'delivered' 
        AND order_delivered_customer_date IS NOT NULL
    GROUP BY 
        month_no, year
)

SELECT 
    month_no,
    month,
    ROUND(MAX(CASE WHEN year = '2016' THEN real_time END), 2) AS Year2016_real_time,
    ROUND(MAX(CASE WHEN year = '2017' THEN real_time END), 2) AS Year2017_real_time,
    ROUND(MAX(CASE WHEN year = '2018' THEN real_time END), 2) AS Year2018_real_time,
    ROUND(MAX(CASE WHEN year = '2016' THEN estimated_time END), 2) AS Year2016_estimated_time,
    ROUND(MAX(CASE WHEN year = '2017' THEN estimated_time END), 2) AS Year2017_estimated_time,
    ROUND(MAX(CASE WHEN year = '2018' THEN estimated_time END), 2) AS Year2018_estimated_time
FROM 
    DeliveryData
GROUP BY 
    month_no, month
ORDER BY 
    month_no;