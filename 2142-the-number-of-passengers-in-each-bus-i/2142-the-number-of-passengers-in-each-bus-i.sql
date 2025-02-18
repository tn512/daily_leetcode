-- 2142. The Number of Passengers in Each Bus I

-- Main Solution
WITH cleaned_bus AS (
    SELECT bus_id, arrival_time,
           NVL(LAG(arrival_time) OVER (ORDER BY arrival_time), 0) AS last_bus
    FROM Buses
)
SELECT b.bus_id, COUNT(p.passenger_id) AS passengers_cnt
FROM cleaned_bus b
LEFT JOIN Passengers p
ON p.arrival_time <= b.arrival_time
AND p.arrival_time > b.last_bus
GROUP BY b.bus_id
ORDER BY b.bus_id;

-- Alternative Solution
WITH used_bus AS (
    SELECT p.passenger_id, MIN(b.arrival_time) AS used_arrival_time
    FROM Passengers p
    JOIN Buses b
    ON p.arrival_time <= b.arrival_time
    GROUP BY p.passenger_id
)
SELECT b.bus_id, COUNT(u.passenger_id) AS passengers_cnt
FROM Buses b
LEFT JOIN used_bus u
ON b.arrival_time = u.used_arrival_time
GROUP BY b.bus_id
ORDER BY b.bus_id;
