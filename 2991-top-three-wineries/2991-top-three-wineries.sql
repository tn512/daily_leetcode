-- 2991. Top Three Wineries 

-- Main Solution
WITH sum_points AS (
    SELECT country, winery, SUM(points) AS points
    FROM Wineries
    GROUP BY country, winery
), top_three AS (
    SELECT country, points AS points, winery,
           RANK() OVER (PARTITION BY country ORDER BY points DESC, winery) AS rnk,
           LEAD(winery) OVER (PARTITION BY country ORDER BY points DESC, winery) AS sec_winery,
           LEAD(points) OVER (PARTITION BY country ORDER BY points DESC, winery) AS sec_points,
           LEAD(winery, 2) OVER (PARTITION BY country ORDER BY points DESC, winery) AS thrd_winery,
           LEAD(points, 2) OVER (PARTITION BY country ORDER BY points DESC, winery) AS thrd_points
    FROM sum_points
)
SELECT country, 
       winery || ' (' || points || ')' AS top_winery,
       CASE WHEN sec_winery IS NOT NULL THEN sec_winery || ' (' || sec_points || ')'
            ELSE 'No second winery'
       END AS second_winery,
       CASE WHEN thrd_winery IS NOT NULL THEN thrd_winery || ' (' || thrd_points || ')'
            ELSE 'No third winery'
       END AS third_winery
FROM top_three
WHERE rnk = 1
ORDER BY country;

-- Alternative Solution
WITH sum_points AS (
    SELECT country, winery, SUM(points) AS points
    FROM Wineries
    GROUP BY country, winery
), rnk_country AS (
    SELECT country, winery || ' (' || points || ')' AS winery,
           DENSE_RANK() OVER (PARTITION BY country ORDER BY points DESC, winery) AS rnk
    FROM sum_points
)
SELECT country,
       MAX(CASE WHEN rnk = 1 THEN winery ELSE NULL END) AS top_winery,
       COALESCE(MAX(CASE WHEN rnk = 2 THEN winery ELSE NULL END), 'No second winery') AS second_winery,
       COALESCE(MAX(CASE WHEN rnk = 3 THEN winery ELSE NULL END), 'No third winery') AS third_winery
FROM rnk_country
GROUP BY country
ORDER BY country;
