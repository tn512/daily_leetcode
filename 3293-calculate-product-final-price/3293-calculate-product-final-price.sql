-- 3293. Calculate Product Final Price

-- Main Solution
SELECT p.product_id,
       p.price * (100 - NVL(discount, 0)) / 100 AS final_price,
       p.category
FROM Products p
LEFT JOIN Discounts d
ON p.category = d.category
ORDER BY p.product_id;

