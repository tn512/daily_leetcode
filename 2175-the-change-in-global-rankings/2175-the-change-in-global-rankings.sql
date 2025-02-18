-- 2175. The Change in Global Rankings

-- Main Solution
SELECT t.team_id, t.name,
       RANK() OVER (ORDER BY t.points DESC, name)
       - RANK() OVER (ORDER BY t.points + p.points_change DESC, name) AS rank_diff
FROM TeamPoints t
JOIN PointsChange p
ON t.team_id = p.team_id;

