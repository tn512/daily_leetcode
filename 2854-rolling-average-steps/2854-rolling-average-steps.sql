-- 2854. Rolling Average Steps

-- Main Solution
WITH temp AS (
    SELECT user_id, steps_count, steps_date,
        CASE WHEN COUNT(steps_count) OVER (PARTITION BY user_id 
                                           ORDER BY steps_date
                                           RANGE BETWEEN INTERVAL '2' DAY PRECEDING 
                                                 AND CURRENT ROW) <> 3
                    THEN NULL
                ELSE AVG(steps_count) OVER (PARTITION BY user_id 
                                            ORDER BY steps_date
                                            RANGE BETWEEN INTERVAL '2' DAY PRECEDING 
                                                  AND CURRENT ROW)
        END AS rolling_average
    FROM Steps
)
SELECT user_id, TO_CHAR(steps_date, 'YYYY-MM-DD') AS steps_date, ROUND(rolling_average, 2) AS rolling_average
FROM temp
WHERE rolling_average IS NOT NULL;

