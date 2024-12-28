-- 1205. Monthly Transactions II

-- Main Solution
WITH temp AS (
    SELECT t.*, TO_CHAR(t.trans_date, 'YYYY-MM') AS month, 'trans' AS cat
    FROM Transactions t
    WHERE t.state = 'approved'
    UNION ALL
    SELECT c.trans_id, t.country, t.state, t.amount, 
           c.trans_date, TO_CHAR(c.trans_date, 'YYYY-MM') AS month, 'chaba' AS cat
    FROM Chargebacks c, Transactions t
    WHERE c.trans_id = t.id
)
SELECT month, country,
       COUNT(CASE WHEN cat = 'trans' THEN id END) AS approved_count,
       SUM(CASE WHEN cat = 'trans' THEN amount ELSE 0 END) AS approved_amount,
       COUNT(CASE WHEN cat = 'chaba' THEN id END) AS chargeback_count,
       SUM(CASE WHEN cat = 'chaba' THEN amount ELSE 0 END) AS chargeback_amount
FROM temp
GROUP BY month, country;

