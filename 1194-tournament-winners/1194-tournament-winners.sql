-- 1194. Tournament Winners

-- Main Solution
WITH player_score AS (
    SELECT first_player AS player_id, first_score AS score
    FROM Matches
    UNION ALL
    SELECT second_player, second_score
    FROM Matches
), sum_score AS (
    SELECT p.group_id, p.player_id, SUM(score) AS score
    FROM player_score m
    JOIN Players p
    ON p.player_id = m.player_id
    GROUP BY p.group_id, p.player_id
)
SELECT s1.group_id, s1.player_id
FROM sum_score s1
LEFT JOIN sum_score s2
ON s1.score < s2.score
AND s1.group_id = s2.group_id
LEFT JOIN sum_score s3
ON s1.player_id > s3.player_id
AND s1.score = s3.score
AND s1.group_id = s3.group_id
WHERE s2.player_id IS NULL AND s3.player_id IS NULL;

-- Alternative Solution
WITH player_score AS (
    SELECT first_player AS player_id, first_score AS score
    FROM Matches
    UNION ALL
    SELECT second_player, second_score
    FROM Matches
), sum_score AS (
    SELECT p.group_id, p.player_id, SUM(score) AS score
    FROM player_score m
    JOIN Players p
    ON p.player_id = m.player_id
    GROUP BY p.group_id, p.player_id
), rank_score AS (
    SELECT group_id, player_id,
           RANK() OVER (PARTITION BY group_id 
                        ORDER BY score DESC, player_id ASC) AS rnk
    FROM sum_score
)
SELECT group_id, player_id
FROM rank_score
WHERE rnk = 1;
