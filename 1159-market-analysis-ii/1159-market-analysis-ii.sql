-- 1159. Market Analysis II

-- Main Solution
WITH Orders_rnk AS (
    SELECT o.*, ROW_NUMBER() OVER (PARTITION BY seller_id ORDER BY order_date) rnk
    FROM Orders o
)
SELECT u.user_id AS seller_id,
       CASE WHEN u.favorite_brand = i.item_brand THEN 'yes'
            ELSE 'no'
       END AS "2nd_item_fav_brand"
FROM Users u
LEFT JOIN Orders_rnk o
ON u.user_id = o.seller_id
AND rnk = 2
LEFT JOIN Items i
ON o.item_id = i.item_id;

-- Alternative Solution
WITH Orders_2nd AS (
    SELECT o1.order_id, o1.seller_id, o1.item_id
    FROM Orders o1
    JOIN Orders o2
    ON o1.seller_id = o2.seller_id
    AND o1.order_date > o2.order_date
    GROUP BY o1.order_id, o1.seller_id, o1.item_id
    HAVING COUNT(o2.order_id) = 1
)
SELECT u.user_id AS seller_id,
       CASE WHEN u.favorite_brand = i.item_brand THEN 'yes'
            ELSE 'no'
       END AS "2nd_item_fav_brand"
FROM Users u
LEFT JOIN Orders_2nd o
ON u.user_id = o.seller_id
LEFT JOIN Items i
ON o.item_id = i.item_id
ORDER BY u.user_id;
