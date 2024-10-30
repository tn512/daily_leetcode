-- 511. Game Play Analysis I

-- Main Solution
SELECT player_id, TO_CHAR(MIN(event_date), 'YYYY-MM-DD') first_login
FROM Activity
GROUP BY player_id;

