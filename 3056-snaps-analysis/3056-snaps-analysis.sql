-- 3056. Snaps Analysis

-- Main Solution
SELECT a.age_bucket,
       ROUND(100 * NVL(SUM(CASE WHEN act.activity_type = 'send' THEN act.time_spent END), 0) 
             / SUM(act.time_spent), 2) AS send_perc,
       ROUND(100 * NVL(SUM(CASE WHEN act.activity_type = 'open' THEN act.time_spent END), 0) 
             / SUM(act.time_spent), 2) AS open_perc
FROM Activities act
JOIN Age a
ON a.user_id = act.user_id
GROUP BY a.age_bucket;

