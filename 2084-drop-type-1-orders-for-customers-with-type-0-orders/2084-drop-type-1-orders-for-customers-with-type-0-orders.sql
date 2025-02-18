-- 2084. Drop Type 1 Orders for Customers With Type 0 Orders

-- Main Solution
SELECT *
FROM Orders
WHERE order_type = '0'
UNION
SELECT *
FROM Orders
WHERE customer_id NOT IN (SELECT DISTINCT customer_id
FROM Orders
WHERE order_type = '0')

-- Alternative Solution
SELECT *
FROM Orders
WHERE (customer_id, order_type) IN (SELECT customer_id, MIN(order_type)
                                         FROM Orders
                                         GROUP BY customer_id);
