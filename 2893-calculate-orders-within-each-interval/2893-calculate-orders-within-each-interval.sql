-- 2893. Calculate Orders Within Each Interval

-- Main Solution
SELECT CEIL(minute / 6) AS interval_no,
       SUM(order_count) AS total_orders
FROM Orders
GROUP BY CEIL(minute / 6)
ORDER BY CEIL(minute / 6);

