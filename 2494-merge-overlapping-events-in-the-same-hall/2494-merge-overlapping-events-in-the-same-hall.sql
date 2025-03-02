-- 2494. Merge Overlapping Events in the Same Hall

-- Main Solution
WITH new_event_start AS (
  SELECT
    hall_id, start_day, end_day,
    CASE 
      WHEN start_day > MAX(end_day) OVER (
                      PARTITION BY hall_id 
                      ORDER BY start_day, end_day DESC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
      THEN 1 
      ELSE 0 
    END AS is_new_event_start
  FROM HallEvents
),
event_id AS (
  SELECT
    SUM(is_new_event_start) OVER (
      PARTITION BY hall_id 
      ORDER BY start_day, end_day DESC
    ) AS event_id,
    hall_id,
    start_day,
    end_day
  FROM new_event_start
)
SELECT
  hall_id,
  TO_CHAR(MIN(start_day), 'YYYY-MM-DD') AS start_day,
  TO_CHAR(MAX(end_day), 'YYYY-MM-DD') AS end_day
FROM event_id
GROUP BY hall_id, event_id
ORDER BY hall_id, start_day;

