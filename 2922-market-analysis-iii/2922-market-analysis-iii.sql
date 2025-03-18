-- 2922. Market Analysis III

-- Main Solution
WITH temp AS (
    SELECT o.seller_id, COUNT(DISTINCT o.item_id) AS num_items,
           RANK() OVER (ORDER BY COUNT(DISTINCT o.item_id) DESC) AS rnk
    FROM Orders o
    JOIN Users u
    ON o.seller_id = u.seller_id
    JOIN Items i
    ON o.item_id = i.item_id
    WHERE u.favorite_brand <> i.item_brand
    GROUP BY o.seller_id
)
SELECT seller_id, num_items
FROM temp
WHERE rnk = 1
ORDER BY seller_id;

