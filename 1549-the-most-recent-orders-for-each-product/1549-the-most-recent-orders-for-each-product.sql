-- 1549. The Most Recent Orders for Each Product

-- Main Solution
WITH temp AS (
    SELECT p.product_name, p.product_id, o.order_id, TO_CHAR(o.order_date, 'YYYY-MM-DD') AS order_date,
           DENSE_RANK() OVER (PARTITION BY p.product_id ORDER BY o.order_date DESC) AS rnk
    FROM Orders o
    JOIN Products p
    ON o.product_id = p.product_id
)
SELECT product_name, product_id, order_id, order_date
FROM temp
WHERE rnk = 1
ORDER BY product_name, product_id, order_id;

-- Alternative Solution
SELECT p.product_name, p.product_id, 
       o1.order_id, TO_CHAR(o1.order_date, 'YYYY-MM-DD') AS order_date
FROM Orders o1
LEFT JOIN Orders o2
ON o1.product_id = o2.product_id
AND o1.order_date < o2.order_date
JOIN Products p
ON o1.product_id = p.product_id
GROUP BY p.product_name, p.product_id, o1.order_id, o1.order_date
HAVING COUNT(o2.order_id) = 0
ORDER BY p.product_name, p.product_id, o1.order_id;
