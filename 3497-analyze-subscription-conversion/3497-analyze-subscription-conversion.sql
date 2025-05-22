-- 3497. Analyze Subscription Conversion 

-- Main Solution
WITH temp AS (
    SELECT DISTINCT user_id, activity_type,
        ROUND(AVG(activity_duration) OVER (PARTITION BY user_id, activity_type), 2) AS av
    FROM UserActivity
    WHERE activity_type IN ('paid', 'free_trial')
)
SELECT t1.user_id, 
       t1.av AS trial_avg_duration,
       t2.av AS paid_avg_duration
FROM temp t1
JOIN temp t2
ON t1.user_id = t2.user_id
AND t1.activity_type = 'free_trial'
AND t2.activity_type = 'paid'
ORDER BY t1.user_id;

