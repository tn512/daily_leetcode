-- 1398. Customers Who Bought Products A and B but Not C

-- Main Solution
WITH temp AS (
    SELECT customer_id
    FROM Orders
    WHERE product_name = 'A'
    INTERSECT
    SELECT customer_id
    FROM Orders
    WHERE product_name= 'B'
    MINUS
    SELECT customer_id
    FROM Orders
    WHERE product_name = 'C'
)
SELECT *
FROM Customers
WHERE customer_id IN (SELECT customer_id FROM temp);

-- Alternative Solution
SELECT c.customer_id, c.customer_name
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(CASE WHEN o.product_name = 'A' THEN o.order_id END) > 0
AND COUNT(CASE WHEN o.product_name = 'B' THEN o.order_id END) > 0
AND COUNT(CASE WHEN o.product_name = 'C' THEN o.order_id END) = 0
ORDER BY c.customer_id;
