-- 2324. Product Sales Analysis IV

-- Main Solution
WITH temp AS (
    SELECT s.user_id, s.product_id, SUM(s.quantity * p.price) AS spent,
           RANK() OVER (PARTITION BY s.user_id 
                        ORDER BY SUM(s.quantity * p.price) DESC) AS rnk
    FROM Sales s
    JOIN Product p
    ON s.product_id = p.product_id
    GROUP BY s.user_id, s.product_id
)
SELECT user_id, product_id
FROM temp
WHERE rnk = 1;

