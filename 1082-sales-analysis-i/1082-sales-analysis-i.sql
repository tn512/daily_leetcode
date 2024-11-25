-- 1082. Sales Analysis I

-- Main Solution
WITH temp AS (
    SELECT seller_id, SUM(price) AS sm
    FROM Sales
    GROUP BY seller_id
)
SELECT seller_id
FROM temp
WHERE sm = (SELECT MAX(sm) FROM temp);

