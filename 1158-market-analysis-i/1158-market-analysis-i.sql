-- 1158. Market Analysis I

-- Main Solution
WITH orders_2019 AS (
    SELECT buyer_id, COUNT(order_id) AS cnt
    FROM Orders
    WHERE EXTRACT(YEAR FROM order_date) = '2019'
    GROUP BY buyer_id
)
SELECT u.user_id AS buyer_id, TO_CHAR(u.join_date, 'YYYY-MM-DD') AS join_date, NVL(o.cnt, 0) AS orders_in_2019
FROM Users u
LEFT JOIN orders_2019 o
ON u.user_id = o.buyer_id;

-- Alternative Solution
SELECT u.user_id AS buyer_id, 
       TO_CHAR(u.join_date, 'YYYY-MM-DD') AS join_date, 
       COUNT(o.order_id) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
ON u.user_id = o.buyer_id
AND EXTRACT(YEAR FROM o.order_date) = '2019'
GROUP BY u.user_id, u.join_date;
