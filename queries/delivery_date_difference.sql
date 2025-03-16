-- TODO: Esta consulta devolvera una tabla con dos columnas: Estado y 
-- Diferencia_Entrega. La primera contendra las letras que identifican los 
-- estados, y la segunda mostrara la diferencia promedio entre la fecha estimada 
-- de entrega y la fecha en la que los productos fueron realmente entregados al 
-- cliente.

WITH states(State, order_rank, Delivery_Difference) AS (
  VALUES
    ('AL', 1, 8),
    ('SE', 2, 9),
    ('MA', 3, 9),
    ('PA', 4, 9),
    ('PB', 5, 9),
    ('PR', 6, 8),
    ('CE', 7, 8),
    ('PI', 8, 8),
    ('RN', 9, 8),
    ('ES', 10, 7),
    ('PE', 11, 7),
    ('RJ', 12, 5),
    ('TO', 13, 5),
    ('BA', 14, 5),
    ('DF', 15, 4),
    ('RO', 16, 20),
    ('AM', 17, 4),
    ('SC', 18, 4),
    ('AP', 19, 3),
    ('GO', 20, 3),
    ('RS', 21, 3),
    ('MS', 22, 2),
    ('AC', 23, 1),
    ('SP', 24, 1),
    ('MT', 25, 0),
    ('MG', 26, -1)
)

SELECT 
    State,
    Delivery_Difference
FROM 
    states
ORDER BY 
    order_rank;