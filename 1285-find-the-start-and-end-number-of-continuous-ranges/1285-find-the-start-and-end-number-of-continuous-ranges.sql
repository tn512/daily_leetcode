-- 1285. Find the Start and End Number of Continuous Ranges

-- Main Solution
WITH islands AS (
    SELECT log_id,
           log_id - ROW_NUMBER() OVER (ORDER BY log_id) AS gap
    FROM Logs
)
SELECT MIN(log_id) AS start_id, MAX(log_id) AS end_id
FROM islands
GROUP BY gap
ORDER BY start_id;

