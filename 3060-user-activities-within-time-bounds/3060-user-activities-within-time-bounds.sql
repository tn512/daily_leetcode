-- 3060. User Activities within Time Bounds

-- Main Solution
WITH temp AS (
    SELECT user_id, session_end, session_type,
       LEAD(session_start) OVER (PARTITION BY user_id, session_type 
                                 ORDER BY session_start) AS next_session_start
    FROM Sessions
)
SELECT DISTINCT user_id
FROM temp
WHERE (next_session_start - session_end) * 24 <= 12
ORDER BY user_id;

