-- 2153. The Number of Passengers in Each Bus II

-- Main Solution
WITH cleaned_bus AS (
    SELECT bus_id, arrival_time, capacity,
           NVL(LAG(arrival_time) OVER (ORDER BY arrival_time), 0) AS last_bus
    FROM Buses
), temp AS (
    SELECT b.bus_id, b.arrival_time, b.capacity, b.last_bus,
           COUNT(p.passenger_id) AS passenger_cnt,
           ROW_NUMBER() OVER (ORDER BY b.arrival_time) AS rn
    FROM cleaned_bus b
    LEFT JOIN Passengers p
    ON p.arrival_time <= b.arrival_time
    AND p.arrival_time > b.last_bus
    GROUP BY b.bus_id, b.arrival_time, b.capacity, b.last_bus
), recursive_cte (rn, bus_id, boarded, remaining) AS (
    -- Base case: first bus
    SELECT rn, bus_id,
           LEAST(capacity, passenger_cnt) AS boarded,
           passenger_cnt - LEAST(capacity, passenger_cnt) AS remaining
    FROM temp
    WHERE rn = 1
    UNION ALL
    -- Recursive case: next bus depending on previous remaining
    SELECT t.rn, t.bus_id,
           LEAST(t.capacity, t.passenger_cnt + rec.remaining) AS boarded,
           (t.passenger_cnt + rec.remaining) -  LEAST(t.capacity, t.passenger_cnt + rec.remaining) AS remaining
    FROM recursive_cte rec
    JOIN temp t
    ON t.rn = rec.rn + 1 
)
SELECT bus_id, boarded AS passengers_cnt
FROM recursive_cte
ORDER BY bus_id;

