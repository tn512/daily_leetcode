-- 1783. Grand Slam Titles

-- Main Solution
WITH temp AS (
    SELECT *
    FROM Championships
    UNPIVOT (
        player_id
        FOR tournament IN (
            Wimbledon AS 'Wimbledon',
            Fr_open AS 'Fr_open',
            US_open AS 'US_open',
            Au_open AS 'Au_open'
        )
    )
)
SELECT p.player_id, p.player_name, 
       COUNT(t.tournament) AS grand_slams_count
FROM temp t
JOIN Players p
ON t.player_id = p.player_id
GROUP BY p.player_id, p.player_name;

-- Alternative Solution
SELECT p.player_id, p.player_name,
       SUM(CASE WHEN c.Wimbledon = p.player_id THEN 1 ELSE 0 END
       + CASE WHEN c.Fr_open = p.player_id THEN 1 ELSE 0 END
       + CASE WHEN c.US_open = p.player_id THEN 1 ELSE 0 END
       + CASE WHEN c.Au_open = p.player_id THEN 1 ELSE 0 END) AS grand_slams_count
FROM Championships c
JOIN Players p
ON p.player_id IN (c.Wimbledon, c.Fr_open, c.US_open, c.Au_open)
GROUP BY p.player_id, p.player_name;
