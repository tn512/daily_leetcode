-- 3384. Team Dominance by Pass Success

-- Main Solution
WITH temp AS (
    SELECT tf.team_name,
           CASE WHEN p.time_stamp <= '45:00' THEN 1
                ELSE 2
           END AS half_number,
           CASE WHEN tf.team_name = tt.team_name THEN 1
                ELSE -1
           END AS points
    FROM Passes p
    JOIN Teams tf
    ON p.pass_from = tf.player_id
    JOIN Teams tt
    ON p.pass_to = tt.player_id
)
SELECT team_name, half_number,
       SUM(points) AS dominance
FROM temp
GROUP BY team_name, half_number
ORDER BY team_name, half_number;

