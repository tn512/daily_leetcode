-- 1084. Sales Analysis III

-- Main Solution
WITH temp AS (
    SELECT s.*, p.product_name
    FROM Sales s, Product p
    WHERE s.product_id = p.product_id
)
SELECT DISTINCT product_id, product_name
FROM temp
WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31'
MINUS
SELECT DISTINCT product_id, product_name
FROM temp
WHERE NOT(sale_date BETWEEN '2019-01-01' AND '2019-03-31');

-- Alternative Solution
SELECT p.product_id, p.product_name
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING MIN(sale_date) >= '2019-01-01' 
AND MAX(sale_date) <= '2019-03-31';
