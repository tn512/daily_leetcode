-- 2118. Build the Equation

-- Main Solution
WITH temp AS (
    SELECT CASE WHEN factor < 0 THEN TO_CHAR(factor) 
                ELSE '+' || factor 
           END AS factor,
           CASE WHEN power = 0 THEN ''
                WHEN power = 1 THEN 'X'
                ELSE 'X^' || power
           END AS power,
           power AS power_base
    FROM Terms
)
SELECT LISTAGG(factor || power, '') WITHIN GROUP (ORDER BY power_base DESC) || '=0' AS equation
FROM temp;

