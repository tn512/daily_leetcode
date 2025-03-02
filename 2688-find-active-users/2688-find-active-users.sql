-- 2688. Find Active Users

-- Main Solution
SELECT DISTINCT u1.user_id
FROM Users u1
JOIN Users u2
ON u1.user_id = u2.user_id
AND u1.created_at < u2.created_at
AND u1.created_at >= u2.created_at - 7
UNION
SELECT user_id
FROM Users
GROUP BY user_id, created_at
HAVING COUNT(*) > 1;

-- Alternative Solution
WITH temp AS (
    SELECT user_id,
           COUNT(*) OVER (PARTITION BY user_id 
                          ORDER BY created_at
                          RANGE BETWEEN INTERVAL '7' DAY PRECEDING AND CURRENT ROW) AS cnt
    FROM Users
)
SELECT DISTINCT user_id
FROM temp
WHERE cnt > 1;
