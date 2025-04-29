-- 3308. Find Top Performing Driver

-- Main Solution
WITH rank_drivers AS (
    SELECT v.fuel_type, d.driver_id, 
           ROUND(AVG(t.rating), 2) AS rating, 
           SUM(t.distance) AS distance,
           RANK() OVER (PARTITION BY v.fuel_type 
                        ORDER BY AVG(t.rating) DESC, 
                                 SUM(t.distance) DESC, 
                                 MAX(d.accidents)) AS rnk
    FROM Drivers d
    JOIN Vehicles v
    ON d.driver_id = v.driver_id
    JOIN Trips t
    ON v.vehicle_id = t.vehicle_id
    GROUP BY v.fuel_type, d.driver_id
)
SELECT fuel_type, driver_id, rating, distance
FROM rank_drivers
WHERE rnk = 1;

