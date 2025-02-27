-- 2292. Products With Three or More Orders in Two Consecutive Years

-- Main Solution
WITH temp AS (
    SELECT product_id, EXTRACT(YEAR FROM purchase_date) AS year
    FROM Orders
    GROUP BY product_id, EXTRACT(YEAR FROM purchase_date)
    HAVING COUNT(order_id) > 2
)
SELECT DISTINCT t1.product_id
FROM temp t1
JOIN temp t2
ON t1.product_id = t2.product_id
AND t1.year = t2.year - 1;

