-- 2173. Longest Winning Streak

-- Main Solution
WITH streaks AS (
    SELECT player_id, match_day, result,
           RANK() OVER (PARTITION BY player_id ORDER BY match_day) 
           - RANK() OVER (PARTITION BY player_id, result ORDER BY match_day) AS gap
    FROM Matches
)
SELECT DISTINCT player_id,
       MAX(COUNT(CASE WHEN result = 'Win' THEN match_day END)) 
        OVER (PARTITION BY player_id) AS longest_streak
FROM streaks
GROUP BY player_id, gap;

