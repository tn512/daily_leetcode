-- 1212. Team Scores in Football Tournament

-- Main Solution
WITH temp AS (
    SELECT host_team AS team_id,
       CASE WHEN host_goals > guest_goals THEN 3
            WHEN host_goals < guest_goals THEN 0
            ELSE 1 END AS points
    FROM Matches
    UNION ALL
    SELECT guest_team AS team_id,
        CASE WHEN host_goals > guest_goals THEN 0
                WHEN host_goals < guest_goals THEN 3
                ELSE 1 END AS points
    FROM Matches
)
SELECT t.team_id, t.team_name, NVL(SUM(p.points), 0) AS num_points
FROM Teams t
LEFT JOIN temp p
ON p.team_id = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id ASC;

-- Alternative Solution
SELECT t.team_id, t.team_name,
       SUM(CASE WHEN t.team_id = m.host_team AND m.host_goals > m.guest_goals THEN 3
                WHEN t.team_id = m.guest_team AND m.host_goals < m.guest_goals THEN 3
                WHEN m.host_goals = m.guest_goals THEN 1
                ELSE 0
           END) AS num_points
FROM Teams t
LEFT JOIN Matches m
ON m.host_team = t.team_id OR m.guest_team = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id ASC;
