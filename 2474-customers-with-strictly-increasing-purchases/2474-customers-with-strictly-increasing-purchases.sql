-- 2474. Customers With Strictly Increasing Purchases

-- Main Solution
WITH temp_purchases AS (
    SELECT customer_id,
           EXTRACT(YEAR FROM order_date) AS year,
           SUM(price) AS total,
           MAX(EXTRACT(YEAR FROM order_date)) OVER (PARTITION BY customer_id) AS end_year,
           MIN(EXTRACT(YEAR FROM order_date)) OVER (PARTITION BY customer_id) AS start_year
    FROM Orders
    GROUP BY customer_id, EXTRACT(YEAR FROM order_date)
), base_year AS (
    SELECT customer_id, start_year + LEVEL - 1 AS year
    FROM (SELECT DISTINCT customer_id, start_year, end_year 
          FROM temp_purchases)
    CONNECT BY PRIOR customer_id = customer_id
    AND LEVEL <= end_year - start_year + 1
    AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
), total_purchases AS (
    SELECT b.customer_id, b.year, NVL(total, 0) AS total,
           DENSE_RANK() OVER (PARTITION BY b.customer_id ORDER BY b.year)
           - DENSE_RANK() OVER (PARTITION BY b.customer_id ORDER BY NVL(total, 0)) AS gap
    FROM base_year b
    LEFT JOIN temp_purchases t
    ON b.customer_id = t.customer_id
    AND b.year = t.year
)
SELECT customer_id
FROM total_purchases
GROUP BY customer_id
HAVING COUNT(CASE WHEN gap = 0 THEN gap END) = COUNT(year);

-- Alternative Solution
WITH total_purchases AS (
    SELECT customer_id,
           EXTRACT(YEAR FROM order_date) AS year,
           SUM(price) AS total
    FROM Orders
    GROUP BY customer_id, EXTRACT(YEAR FROM order_date)
)
SELECT t1.customer_id
FROM total_purchases t1
LEFT JOIN total_purchases t2
ON t1.year = t2.year - 1
AND t1.customer_id = t2.customer_id
AND t1.total < t2.total
GROUP BY t1.customer_id
HAVING COUNT(t1.customer_id) = COUNT(t2.customer_id) + 1;
