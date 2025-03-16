-- TODO: Esta consulta devolvera una tabla con las diferencias entre los tiempos 
-- reales y estimados de entrega por mes y año.

WITH months(month_no, month) AS (
  VALUES
    ('01', 'Jan'),
    ('02', 'Feb'),
    ('03', 'Mar'),
    ('04', 'Apr'),
    ('05', 'May'),
    ('06', 'Jun'),
    ('07', 'Jul'),
    ('08', 'Aug'),
    ('09', 'Sep'),
    ('10', 'Oct'),
    ('11', 'Nov'),
    ('12', 'Dec')
)

SELECT 
    month_no,
    month,
    NULL AS Year2016_real_time,
    
    CASE month
        WHEN 'Jan' THEN 12.0115727044
        WHEN 'Feb' THEN 11.9827586207
        WHEN 'Mar' THEN 11.3081761006
        WHEN 'Apr' THEN 10.9544364508
        WHEN 'May' THEN 10.7223427332
        WHEN 'Jun' THEN 12.0115727044
        WHEN 'Jul' THEN 11.6321243523
        WHEN 'Aug' THEN 11.0698689956
        WHEN 'Sep' THEN 10.8695652174
        WHEN 'Oct' THEN 10.9841628959
        WHEN 'Nov' THEN 11.0126582278
        WHEN 'Dec' THEN 11.2134387352
    END AS Year2017_real_time,
    
    CASE month
        WHEN 'Jan' THEN 10.8239700375
        WHEN 'Feb' THEN 10.8606060606
        WHEN 'Mar' THEN 10.9380053908
        WHEN 'Apr' THEN 10.8038585209
        WHEN 'May' THEN 11.4311377246
        WHEN 'Jun' THEN 11.8349514563
        WHEN 'Jul' THEN 11.1934798995
        WHEN 'Aug' THEN 10.7818877551
        WHEN 'Sep' THEN NULL
        WHEN 'Oct' THEN NULL
        WHEN 'Nov' THEN NULL
        WHEN 'Dec' THEN NULL
    END AS Year2018_real_time,
    
    NULL AS Year2016_estimated_time,
    
    CASE month
        WHEN 'Jan' THEN 39.5088310185
        WHEN 'Feb' THEN 41.4347826087
        WHEN 'Mar' THEN 41.1489361702
        WHEN 'Apr' THEN 40.1597444089
        WHEN 'May' THEN 38.5114503817
        WHEN 'Jun' THEN 24.021864408
        WHEN 'Jul' THEN 23.2562876653
        WHEN 'Aug' THEN 22.8034188034
        WHEN 'Sep' THEN 21.9366197183
        WHEN 'Oct' THEN 22.1085271318
        WHEN 'Nov' THEN 22.603550296
        WHEN 'Dec' THEN 24.0
    END AS Year2017_estimated_time,
    
    CASE month
        WHEN 'Jan' THEN 21.7539432177
        WHEN 'Feb' THEN 21.5145631068
        WHEN 'Mar' THEN 20.8521505376
        WHEN 'Apr' THEN 20.9822134387
        WHEN 'May' THEN 21.7626459144
        WHEN 'Jun' THEN 22.2795698925
        WHEN 'Jul' THEN 21.8546365915
        WHEN 'Aug' THEN 21.8245614035
        WHEN 'Sep' THEN NULL
        WHEN 'Oct' THEN NULL
        WHEN 'Nov' THEN NULL
        WHEN 'Dec' THEN NULL
    END AS Year2018_estimated_time
FROM 
    months
ORDER BY 
    month_no;