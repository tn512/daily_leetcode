-- 3118. Friday Purchase III 

-- Main Solution
WITH base_date AS (
    SELECT dt, TO_CHAR(dt, 'WW') - TO_CHAR(TO_DATE('2023-11-01'), 'WW') + 1 AS week_of_month
    FROM (
        SELECT TO_DATE('2023-10-31') + LEVEL AS dt
        FROM DUAL
        CONNECT BY LEVEL < 31
    )
    WHERE TO_CHAR(dt, 'D') = '6'
), base AS (
    SELECT *
    FROM base_date
    CROSS JOIN (SELECT 'Premium' AS membership FROM DUAL
                UNION 
                SELECT 'VIP' FROM DUAL)
)
SELECT b.week_of_month,
       b.membership, 
       NVL(SUM(p.amount_spend), 0) AS total_amount
FROM Purchases p
JOIN Users u
ON u.user_id = p.user_id
RIGHT JOIN base b
ON b.dt = p.purchase_date
AND u.membership = b.membership
GROUP BY b.week_of_month, b.membership
ORDER BY b.week_of_month;

