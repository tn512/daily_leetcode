-- 3322. Premier League Table Ranking III

-- Main Solution
SELECT season_id, team_id, team_name, 
       wins * 3 + draws AS points,
       goals_for - goals_against AS goal_difference,
       RANK() OVER (PARTITION BY season_id 
                    ORDER BY wins * 3 + draws DESC,
                             goals_for - goals_against DESC,
                             team_name) AS position
FROM SeasonStats;

