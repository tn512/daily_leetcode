-- 1142. User Activity for the Past 30 Days II

-- Main Solution
SELECT CASE WHEN COUNT(DISTINCT user_id) = 0 THEN 0
            ELSE ROUND(COUNT(DISTINCT session_id) / COUNT(DISTINCT user_id), 2) 
       END AS average_sessions_per_user
FROM Activity
WHERE activity_date BETWEEN TO_DATE('2019-07-27', 'YYYY-MM-DD') - 29 
                    AND TO_DATE('2019-07-27', 'YYYY-MM-DD');

