-- 2995. Viewers Turned Streamers

-- Main Solution
WITH rnk_session AS (
    SELECT user_id, session_id, session_type,
           FIRST_VALUE(session_id) OVER (PARTITION BY user_id 
                                         ORDER BY session_start) AS frist_session_id,
           FIRST_VALUE(session_type) OVER (PARTITION BY user_id 
                                           ORDER BY session_start) AS frist_session_type
    FROM Sessions
)
SELECT user_id, COUNT(CASE WHEN session_type = 'Streamer' THEN session_id END) AS sessions_count
FROM rnk_session
WHERE frist_session_type = 'Viewer'
AND frist_session_id <> session_id
GROUP BY user_id
ORDER BY sessions_count DESC, user_id DESC;

