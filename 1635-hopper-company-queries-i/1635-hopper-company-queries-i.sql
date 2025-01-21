-- 1635. Hopper Company Queries I

-- Main Solution
WITH base_month AS (
    SELECT TO_DATE('2020-' || LEVEL || '-01') f_day,
           LAST_DAY(TO_DATE('2020-' || LEVEL || '-01')) AS l_day
    FROM DUAL
    CONNECT BY LEVEL <= 12
)
SELECT EXTRACT(MONTH FROM b.l_day) AS month, 
       COUNT(DISTINCT d.driver_id) AS active_drivers, 
       COUNT(DISTINCT a.ride_id) AS accepted_rides
FROM base_month b
LEFT JOIN Drivers d
ON b.l_day >= d.join_date
LEFT JOIN Rides r
ON r.requested_at BETWEEN b.f_day AND b.l_day
LEFT JOIN AcceptedRides a
ON a.ride_id = r.ride_id
GROUP BY b.l_day
ORDER BY b.l_day;

