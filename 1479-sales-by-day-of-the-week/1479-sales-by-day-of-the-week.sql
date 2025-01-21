-- 1479. Sales by Day of the Week

-- Main Solution
WITH orders_cleaned AS (
    SELECT i.item_category AS Category, 
           TRIM(TO_CHAR(o.order_date, 'Day')) day_of_week,
           SUM(o.quantity) AS total_quantity
    FROM Items i
    LEFT JOIN Orders o
    ON o.item_id = i.item_id
    GROUP BY i.item_category, TO_CHAR(o.order_date, 'Day')
), pivot_temp AS (
    SELECT *
    FROM orders_cleaned
    PIVOT (
        MAX(total_quantity)
        FOR day_of_week IN ('Monday' AS Monday, 'Tuesday' AS Tuesday, 
                            'Wednesday' AS Wednesday, 'Thursday' AS Thursday, 
                            'Friday' AS Friday, 'Saturday' AS Saturday, 
                            'Sunday' AS Sunday)
    )
)
SELECT Category, NVL(Monday, 0) AS Monday, 
       NVL(Tuesday, 0) AS Tuesday, NVL(Wednesday, 0) AS Wednesday,
       NVL(Thursday, 0) AS Thursday, NVL(Friday, 0) AS Friday, 
       NVL(Saturday, 0) AS Saturday, NVL(Sunday, 0) AS Sunday
FROM pivot_temp
ORDER BY Category;

-- Alternative Solution
WITH orders_cleaned AS (
    SELECT i.item_category, 
           TRIM(TO_CHAR(o.order_date, 'Day')) day_of_week,
           o.quantity
    FROM Items i
    LEFT JOIN Orders o
    ON o.item_id = i.item_id
)
SELECT item_category AS Category,
       NVL(SUM(CASE WHEN day_of_week = 'Monday' THEN quantity END), 0) AS Monday,
       NVL(SUM(CASE WHEN day_of_week = 'Tuesday' THEN quantity END), 0) AS Tuesday,
       NVL(SUM(CASE WHEN day_of_week = 'Wednesday' THEN quantity END), 0) AS Wednesday,
       NVL(SUM(CASE WHEN day_of_week = 'Thursday' THEN quantity END), 0) AS Thursday,
       NVL(SUM(CASE WHEN day_of_week = 'Friday' THEN quantity END), 0) AS Friday,
       NVL(SUM(CASE WHEN day_of_week = 'Saturday' THEN quantity END), 0) AS Saturday,
       NVL(SUM(CASE WHEN day_of_week = 'Sunday' THEN quantity END), 0) AS Sunday
FROM orders_cleaned
GROUP BY item_category
ORDER BY item_category;
