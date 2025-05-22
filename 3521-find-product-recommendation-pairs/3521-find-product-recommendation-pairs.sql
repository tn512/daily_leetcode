-- 3521. Find Product Recommendation Pairs

-- Main Solution
WITH base_pairs AS (
    SELECT p1.product_id AS product1_id, p2.product_id AS product2_id, 
           p1.category AS product1_category, p2.category AS product2_category
    FROM ProductInfo p1
    JOIN ProductInfo p2
    ON p1.product_id < p2.product_id
)
SELECT b.product1_id, b.product2_id, 
       b.product1_category, b.product2_category, 
       COUNT(pu1.user_id) AS customer_count
FROM base_pairs b
JOIN ProductPurchases pu1
ON b.product1_id = pu1.product_id
JOIN ProductPurchases pu2
ON b.product2_id = pu2.product_id
AND pu1.user_id = pu2.user_id
GROUP BY b.product1_id, b.product2_id, b.product1_category, b.product2_category
HAVING COUNT(pu1.user_id) > 2
ORDER BY customer_count DESC, product1_id, product2_id;

