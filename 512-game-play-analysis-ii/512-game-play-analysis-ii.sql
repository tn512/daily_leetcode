-- 512. Game Play Analysis II

-- Main Solution
SELECT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN (SELECT player_id, TO_CHAR(MIN(event_date), 'YYYY-MM-DD')
                                  FROM Activity
                                  GROUP BY player_id);

-- Alternative Solution
SELECT DISTINCT player_id,
                FIRST_VALUE(device_id) OVER (PARTITION BY player_id 
                                             ORDER BY event_date) AS device_id
FROM Activity;
