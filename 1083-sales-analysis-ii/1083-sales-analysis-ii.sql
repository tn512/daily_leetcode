-- 1083. Sales Analysis II

-- Main Solution
WITH temp AS (
    SELECT s.*, p.product_name
    FROM Sales s, Product p
    WHERE s.product_id = p.product_id
)
SELECT DISTINCT buyer_id
FROM temp
WHERE product_name = 'S8'
MINUS
SELECT DISTINCT buyer_id
FROM temp
WHERE product_name = 'iPhone';

