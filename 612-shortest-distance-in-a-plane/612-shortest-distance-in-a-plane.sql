-- 612. Shortest Distance in a Plane

-- Main Solution
SELECT MIN(
        ROUND(
            SQRT(POWER(p2.x - p1.x, 2) + POWER(p2.y - p1.y, 2))
            , 2)
       ) AS shortest 
FROM Point2D p1
JOIN Point2D p2
ON p1.x <> p2.x OR p1.y <> p2.y;

