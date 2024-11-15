-- 603. Consecutive Available Seats

-- Main Solution
WITH temp AS (
    SELECT * 
    FROM Cinema
    WHERE free = 1
)
SELECT c1.seat_id 
FROM temp c1
LEFT JOIN temp c2
ON c1.seat_id = c2.seat_id - 1
LEFT JOIN temp c3
ON c1.seat_id = c3.seat_id + 1
WHERE NOT (c2.seat_id IS NULL
           AND c3.seat_id IS NULL)
ORDER BY c1.seat_id;

-- Alternative Solution
SELECT DISTINCT c1.seat_id 
FROM Cinema c1
JOIN Cinema c2
ON ABS(c1.seat_id - c2.seat_id) = 1
WHERE c1.free = 1
AND c2.free = 1
ORDER BY c1.seat_id;
