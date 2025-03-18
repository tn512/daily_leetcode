-- 2994. Friday Purchases II 

-- Main Solution
WITH base_date AS (
    SELECT dt, TO_CHAR(dt, 'WW') - TO_CHAR(TO_DATE('2023-11-01'), 'WW') + 1 AS week_of_month
    FROM (
        SELECT TO_DATE('2023-10-31') + LEVEL AS dt
        FROM DUAL
        CONNECT BY LEVEL < 31
    )
    WHERE TO_CHAR(dt, 'D') = '6'
)
SELECT b.week_of_month,
       TO_CHAR(b.dt, 'YYYY-MM-DD') AS purchase_date, 
       NVL(SUM(p.amount_spend), 0) AS total_amount
FROM base_date b
LEFT JOIN Purchases p
ON b.dt = p.purchase_date
GROUP BY b.dt, b.week_of_month
ORDER BY b.week_of_month;

