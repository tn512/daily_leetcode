-- 1459. Rectangles Area

-- Main Solution
SELECT p_1.id AS p1, p_2.id AS p2,
       ABS((p_1.x_value - p_2.x_value) * (p_1.y_value - p_2.y_value)) AS area
FROM Points p_1
JOIN Points p_2
ON p_1.id < p_2.id
AND p_1.x_value <> p_2.x_value
AND p_1.y_value <> p_2.y_value
ORDER BY area DESC, p_1.id ASC, p_2.id ASC;

