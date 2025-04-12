-- 3061. Calculate Trapping Rain Water

-- Main Solution
WITH temp AS (
    SELECT h1.id AS id_1, h1.height AS height_1, 
           h2.id AS id_2, h2.height AS height_2,
           h3.id AS id_3, h3.height AS height_3,
           COUNT(h3.id) OVER (PARTITION BY h1.id, h2.id) AS cnt
    FROM Heights h1
    JOIN Heights h2
    ON h1.id < h2.id - 1
    JOIN Heights h3
    ON h1.id < h3.id
    AND h2.id > h3.id
    AND h3.height < h2.height
    AND h3.height < h1.height
)
SELECT NVL(SUM(LEAST(height_1, height_2) - height_3), 0) AS total_trapped_water
FROM temp
WHERE cnt = id_2 - id_1 - 1
AND id_1 NOT IN (SELECT id_3 FROM temp)
AND id_2 NOT IN (SELECT id_3 FROM temp)
ORDER BY id_1, id_3;

-- Alternative Solution
WITH temp AS (
    SELECT h.*,
           MAX(height) OVER (ORDER BY id ASC) AS left_highest_bar,
           MAX(height) OVER (ORDER BY id DESC) AS right_highest_bar
    FROM Heights h
)
SELECT SUM(LEAST(left_highest_bar, right_highest_bar) - height) AS total_trapped_water
FROM temp;
