-- 1097. Game Play Analysis V

-- Main Solution
WITH install_date AS (
    SELECT player_id, MIN(event_date) AS install_dt
    FROM Activity
    GROUP BY player_id
), retention_date AS (
    SELECT player_id, event_date AS retention_dt
    FROM Activity
    WHERE (player_id, event_date) IN (SELECT player_id, install_dt + 1 FROM install_date)
)
SELECT TO_CHAR(i.install_dt, 'YYYY-MM-DD') AS install_dt, 
       COUNT(i.player_id) AS installs, 
       ROUND(COUNT(r.player_id) / COUNT(i.player_id), 2) AS Day1_retention 
FROM install_date i
LEFT JOIN retention_date r
ON i.player_id = r.player_id
GROUP BY i.install_dt;

