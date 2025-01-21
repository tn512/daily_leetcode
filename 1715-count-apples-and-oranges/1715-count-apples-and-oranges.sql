-- 1715. Count Apples and Oranges

-- Main Solution
SELECT SUM(b.apple_count) + NVL(SUM(c.apple_count), 0) AS apple_count,
       SUM(b.orange_count) + NVL(SUM(c.orange_count), 0) AS orange_count
FROM Boxes b
LEFT JOIN Chests c
ON b.chest_id = c.chest_id;

