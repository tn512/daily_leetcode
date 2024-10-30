-- 534. Game Play Analysis III

-- Main Solution
SELECT player_id, TO_CHAR(event_date, 'YYYY-MM-DD') AS event_date,
       SUM(games_played) OVER (PARTITION BY player_id ORDER BY event_date) AS games_played_so_far
FROM Activity;

-- Alternative Solution
SELECT a2.player_id, TO_CHAR(a2.event_date, 'YYYY-MM-DD') AS event_date, 
       SUM(a1.games_played) AS games_played_so_far
FROM Activity a1, Activity a2
WHERE a1.player_id = a2.player_id
AND a1.event_date <= a2.event_date
GROUP BY a2.player_id, a2.event_date;
