-- 1596. The Most Frequently Ordered Products for Each Customer

-- Main Solution
WITH temp AS (
    SELECT customer_id, product_id, COUNT(order_id) AS cnt
    FROM Orders
    GROUP BY customer_id, product_id
)
SELECT t.customer_id, t.product_id, p.product_name
FROM temp t
JOIN Products p
ON p.product_id = t.product_id
WHERE (t.customer_id, t.cnt) IN (SELECT customer_id, MAX(cnt) 
                                 FROM temp 
                                 GROUP BY customer_id);

-- Alternative Solution
WITH rnk_temp AS (
    SELECT customer_id, product_id,
           RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(order_id) DESC) AS rnk
    FROM Orders
    GROUP BY customer_id, product_id
)
SELECT t.customer_id, t.product_id, p.product_name
FROM rnk_temp t
JOIN Products p
ON p.product_id = t.product_id
WHERE rnk = 1;
