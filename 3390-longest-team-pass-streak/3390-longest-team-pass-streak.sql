-- 3390. Longest Team Pass Streak

-- Main Solution
WITH temp AS (
    SELECT tf.team_name, tt.team_name AS tt_name,
           ROW_NUMBER() OVER (PARTITION BY tf.team_name ORDER BY p.time_stamp) -
           ROW_NUMBER() OVER (PARTITION BY tf.team_name, tt.team_name ORDER BY p.time_stamp) AS gap
    FROM Passes p
    JOIN Teams tf
    ON p.pass_from = tf.player_id
    JOIN Teams tt
    ON p.pass_to = tt.player_id
), rank_streak AS (
    SELECT DISTINCT team_name, COUNT(*) AS streak,
           RANK() OVER (PARTITION BY team_name ORDER BY COUNT(*) DESC) AS rnk
    FROM temp
    WHERE team_name = tt_name
    GROUP BY team_name, gap
)
SELECT team_name, streak AS longest_streak
FROM rank_streak
WHERE rnk = 1
ORDER BY team_name;

