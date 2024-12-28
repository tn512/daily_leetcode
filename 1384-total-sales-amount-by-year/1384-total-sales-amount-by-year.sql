-- 1384. Total Sales Amount by Year

-- Main Solution
WITH temp AS (
    SELECT product_id, average_daily_sales,
           CASE WHEN LEVEL = 1 THEN period_start
                ELSE TO_DATE(TO_CHAR(EXTRACT(YEAR FROM period_start) + LEVEL - 1) || '-01-01', 'YYYY-MM-DD')
           END AS period_start,
           CASE WHEN EXTRACT(YEAR FROM period_end) - EXTRACT(YEAR FROM period_start) = LEVEL - 1 THEN period_end
                ELSE TO_DATE(TO_CHAR(EXTRACT(YEAR FROM period_start) + LEVEL - 1) || '-12-31', 'YYYY-MM-DD')
           END AS period_end
    FROM Sales
    CONNECT BY LEVEL <= EXTRACT(YEAR FROM period_end) - EXTRACT(YEAR FROM period_start) + 1
    AND PRIOR product_id = product_id
    AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
)
SELECT t.product_id, p.product_name, TO_CHAR(EXTRACT(YEAR FROM t.period_start)) AS report_year,
       t.average_daily_sales * (t.period_end - t.period_start + 1) AS total_amount
FROM temp t
JOIN Product p
ON t.product_id = p.product_id
ORDER BY t.product_id, report_year;

