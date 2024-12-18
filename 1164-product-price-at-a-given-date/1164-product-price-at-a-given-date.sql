-- 1164. Product Price at a Given Date

-- Main Solution
WITH max_change_date AS (
    SELECT product_id, new_price
    FROM Products
    WHERE (product_id, change_date) IN (SELECT product_id, MAX(change_date) AS change_date
                                        FROM Products
                                        WHERE change_date <= '2019-08-16'
                                        GROUP BY product_id)
), all_product AS (
    SELECT DISTINCT product_id
    FROM Products
)
SELECT a.product_id, NVL(m.new_price, 10) AS price
FROM all_product a
LEFT JOIN max_change_date m
ON a.product_id = m.product_id;

-- Alternative Solution
SELECT product_id, new_price AS price
FROM Products
WHERE (product_id, change_date) IN (SELECT product_id, MAX(change_date) AS change_date
                                    FROM Products
                                    WHERE change_date <= '2019-08-16'
                                    GROUP BY product_id)
UNION ALL
SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';
