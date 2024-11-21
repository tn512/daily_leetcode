-- 1045. Customers Who Bought All Products

-- Main Solution
WITH product_cnt AS (
    SELECT COUNT(1) AS p_cnt FROM Product
), cus_cnt AS (
    SELECT customer_id, COUNT(DISTINCT product_key) AS c_cnt
    FROM Customer
    GROUP BY customer_id
)
SELECT customer_id
FROM product_cnt, cus_cnt
WHERE p_cnt = c_cnt;

