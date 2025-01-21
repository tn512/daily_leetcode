-- 1645. Hopper Company Queries II

-- Main Solution
WITH base_month AS (
    SELECT LAST_DAY(TO_DATE('2020-' || LEVEL || '-01')) AS l_day
    FROM DUAL
    CONNECT BY LEVEL <= 12
)
SELECT EXTRACT(MONTH FROM b.l_day) AS month, 
       CASE WHEN COUNT(DISTINCT d.driver_id) = 0 THEN 0
            ELSE ROUND((COUNT(DISTINCT a.driver_id) / COUNT(DISTINCT d.driver_id)) * 100, 2)
       END AS working_percentage
FROM base_month b
LEFT JOIN Drivers d
ON b.l_day >= d.join_date
LEFT JOIN Rides r
ON TO_CHAR(r.requested_at, 'YYYY-MM') = TO_CHAR(b.l_day, 'YYYY-MM')
LEFT JOIN AcceptedRides a
ON a.ride_id = r.ride_id
GROUP BY b.l_day
ORDER BY b.l_day;

