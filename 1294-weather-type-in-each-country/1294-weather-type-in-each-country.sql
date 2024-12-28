-- 1294. Weather Type in Each Country

-- Main Solution
WITH avg_weather AS (
    SELECT country_id, AVG(weather_state) AS avg_w
    FROM Weather
    WHERE TO_CHAR(day, 'YYYY-MM') = '2019-11'
    GROUP BY country_id
)
SELECT c.country_name,
       CASE WHEN avg_w <= 15 THEN 'Cold'
            WHEN avg_w >= 25 THEN 'Hot'
            ELSE 'Warm'
       END AS weather_type
FROM Countries c
JOIN avg_weather a
ON c.country_id = a.country_id;

