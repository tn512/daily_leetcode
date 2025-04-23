-- 3252. Premier League Table Ranking II

-- Main Solution
WITH rnk_teams AS (
    SELECT team_name, 
           wins * 3 + draws AS points,
           RANK() OVER (ORDER BY wins * 3 + draws DESC) AS position
    FROM TeamStats
)
SELECT team_name, points, position,
       CASE WHEN position <= CEIL(COUNT(*) OVER () * 0.33) THEN 'Tier 1'
            WHEN position <= CEIL(COUNT(*) OVER () * 0.66) THEN 'Tier 2'
            ELSE 'Tier 3'
       END AS tier
FROM rnk_teams
ORDER BY points DESC, team_name;

