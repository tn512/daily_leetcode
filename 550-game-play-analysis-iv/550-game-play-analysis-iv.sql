-- 550. Game Play Analysis IV

-- Main Solution
SELECT ROUND(COUNT(DISTINCT a2.player_id) / COUNT(DISTINCT a1.player_id), 2) AS "fraction"
FROM Activity a1
LEFT JOIN Activity a2
ON a1.player_id = a2.player_id
AND a1.event_date = a2.event_date - 1
WHERE (a1.player_id, a1.event_date) IN (SELECT player_id, MIN(event_date) 
                                        FROM Activity GROUP BY player_id);

