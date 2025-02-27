-- 2314. The First Day of the Maximum Recorded Degree in Each City

-- Main Solution
WITH temp AS (
    SELECT city_id, day, degree, 
           RANK() OVER (PARTITION BY city_id 
                        ORDER BY degree DESC, day) AS rnk
    FROM Weather
)
SELECT city_id, TO_CHAR(day, 'YYYY-MM-DD') AS day, degree
FROM temp
WHERE rnk = 1
ORDER BY city_id;

