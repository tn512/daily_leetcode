-- 1327. List the Products Ordered in a Period

-- Main Solution
SELECT p.product_name, SUM(unit) AS unit
FROM Products p, Orders o
WHERE p.product_id = o.product_id
AND TO_CHAR(o.order_date, 'YYYY-MM') = '2020-02'
GROUP BY p.product_name
HAVING SUM(unit) >= 100;

