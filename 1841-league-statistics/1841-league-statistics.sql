-- 1841. League Statistics

-- Main Solution
SELECT t.team_name, 
       COUNT(m.home_team_id) AS matches_played,
       SUM(CASE WHEN t.team_id = m.home_team_id AND home_team_goals > away_team_goals THEN 3
                WHEN t.team_id = m.away_team_id AND home_team_goals < away_team_goals THEN 3
                WHEN home_team_goals = away_team_goals THEN 1
                ELSE 0 END) AS points,
       SUM(CASE WHEN t.team_id = m.home_team_id THEN home_team_goals
                ELSE away_team_goals END) AS goal_for,
       SUM(CASE WHEN t.team_id = m.home_team_id THEN away_team_goals
                ELSE home_team_goals END) AS goal_against,
       SUM(CASE WHEN t.team_id = m.home_team_id THEN home_team_goals ELSE away_team_goals END) 
       - SUM(CASE WHEN t.team_id = m.home_team_id THEN away_team_goals
                ELSE home_team_goals END) AS goal_diff
FROM Matches m
JOIN Teams t
ON t.team_id IN (m.home_team_id, m.away_team_id)
GROUP BY t.team_id, t.team_name
ORDER BY points DESC, goal_diff DESC, team_name;

