-- 1532. The Most Recent Three Orders

-- Main Solution
WITH temp AS (
    SELECT c.name AS customer_name, c.customer_id, o.order_id, o.order_date,
           ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
    FROM Orders o 
    JOIN Customers c
    ON o.customer_id = c.customer_id
)
SELECT customer_name, customer_id, order_id, TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date
FROM temp
WHERE rn BETWEEN 1 AND 3
ORDER BY customer_name ASC, customer_id ASC, order_date DESC;

-- Alternative Solution
SELECT c.name AS customer_name, o1.customer_id, o1.order_id, TO_CHAR(o1.order_date, 'YYYY-MM-DD') AS order_date
FROM Orders o1
LEFT JOIN Orders o2
ON o1.customer_id = o2.customer_id
AND o1.order_date < o2.order_date
JOIN Customers c
ON o1.customer_id = c.customer_id
GROUP BY o1.order_id, o1.customer_id, c.name, o1.order_date
HAVING COUNT(o2.order_id) < 3
ORDER BY customer_name ASC, o1.customer_id ASC, order_date DESC;
