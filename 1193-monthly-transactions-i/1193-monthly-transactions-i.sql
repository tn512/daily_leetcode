-- 1193. Monthly Transactions I

-- Main Solution
WITH temp AS (
    SELECT t.*, TO_CHAR(t.trans_date, 'YYYY-MM') AS trans_month
    FROM Transactions t
)
SELECT trans_month AS month, country,
       COUNT(id) AS trans_count,
       COUNT(CASE WHEN state = 'approved' THEN id END) AS approved_count,
       NVL(SUM(amount), 0) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM temp
GROUP BY country, trans_month;

