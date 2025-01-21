-- 1651. Hopper Company Queries III

-- Main Solution
WITH base_month AS (
    SELECT LEVEL AS month
    FROM DUAL
    CONNECT BY LEVEL <= 12
), temp AS (
    SELECT DISTINCT b.month,
           SUM(ride_distance) OVER (ORDER BY b.month
                                    RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING) AS ride_distance,
           SUM(ride_duration) OVER (ORDER BY b.month
                                    RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING) AS ride_duration
    FROM base_month b
    LEFT JOIN Rides r
    ON EXTRACT(YEAR FROM r.requested_at) = 2020
    AND EXTRACT(MONTH FROM r.requested_at) = b.month
    LEFT JOIN AcceptedRides a
    ON a.ride_id = r.ride_id
    ORDER BY b.month
)
SELECT month, 
       NVL(ROUND(ride_distance / 3, 2), 0) AS average_ride_distance, 
       NVL(ROUND(ride_duration / 3, 2), 0) AS average_ride_duration
FROM temp
WHERE month < 11;

