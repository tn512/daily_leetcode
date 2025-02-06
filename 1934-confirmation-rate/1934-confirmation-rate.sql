-- 1934. Confirmation Rate

-- Main Solution
SELECT s.user_id,
       CASE WHEN COUNT(*) = 0 THEN 0
            ELSE ROUND(COUNT(CASE WHEN c.action = 'confirmed' THEN c.time_stamp END) / COUNT(*), 2)
       END AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id;

