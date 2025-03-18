-- 2984. Find Peak Calling Hours for Each City

-- Main Solution
WITH rnk_call AS (
    SELECT city, 
           EXTRACT(HOUR FROM TO_TIMESTAMP(call_time, 'YYYY-MM-DD HH24:MI:SS')) AS peak_calling_hour,
           COUNT(*) AS number_of_calls,
           RANK() OVER (PARTITION BY city ORDER BY COUNT(*) DESC) AS rnk
    FROM Calls
    GROUP BY city, EXTRACT(HOUR FROM TO_TIMESTAMP(call_time, 'YYYY-MM-DD HH24:MI:SS'))
)
SELECT city, peak_calling_hour, number_of_calls
FROM rnk_call
WHERE rnk = 1
ORDER BY peak_calling_hour DESC, city DESC;

