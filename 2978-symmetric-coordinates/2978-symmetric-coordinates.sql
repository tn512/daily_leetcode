-- 2978. Symmetric Coordinates

-- Main Solution
WITH rn_coordinates AS (
    SELECT x, y, ROW_NUMBER() OVER (ORDER BY x, y) AS rn
    FROM Coordinates
)
SELECT DISTINCT c1.x, c1.y
FROM rn_coordinates c1
JOIN rn_coordinates c2
ON c1.x = c2.y
AND c1.y = c2.x
AND c1.rn <> c2.rn
WHERE c1.x <= c1.y
ORDER BY c1.x, c1.y;

