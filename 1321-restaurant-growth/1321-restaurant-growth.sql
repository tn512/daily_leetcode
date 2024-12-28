-- 1321. Restaurant Growth

-- Main Solution
WITH base AS (
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
), temp AS (
    SELECT DISTINCT visited_on,
       SUM(amount) OVER (ORDER BY visited_on
                         RANGE BETWEEN INTERVAL '6' DAY PRECEDING 
                               AND CURRENT ROW) AS amount,
       ROUND(AVG(amount) OVER (ORDER BY visited_on
                               RANGE BETWEEN INTERVAL '6' DAY PRECEDING 
                                     AND CURRENT ROW), 2) AS average_amount                
    FROM base
)
SELECT TO_CHAR(t1.visited_on, 'YYYY-MM-DD') AS visited_on, t1.amount, t1.average_amount
FROM temp t1
LEFT JOIN temp t2
ON t1.visited_on = t2.visited_on + 6
WHERE t2.visited_on IS NOT NULL
ORDER BY t1.visited_on;

-- Alternative Solution
WITH temp AS (
    SELECT DISTINCT visited_on,
       SUM(amount) OVER (ORDER BY visited_on
                         RANGE BETWEEN INTERVAL '6' DAY PRECEDING 
                               AND CURRENT ROW) AS amount,
       ROUND(SUM(amount) OVER (ORDER BY visited_on
                               RANGE BETWEEN INTERVAL '6' DAY PRECEDING 
                                     AND CURRENT ROW) / 7, 2) AS average_amount                
    FROM Customer
)
SELECT TO_CHAR(t1.visited_on, 'YYYY-MM-DD') AS visited_on, t1.amount, t1.average_amount
FROM temp t1
LEFT JOIN temp t2
ON t1.visited_on = t2.visited_on + 6
WHERE t2.visited_on IS NOT NULL
ORDER BY t1.visited_on;
