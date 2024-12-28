-- 1336. Number of Transactions per Visit

-- Main Solution
WITH v_transactions_count AS (
    SELECT v.user_id, v.visit_date, COUNT(t.user_id) AS transactions_count
    FROM Visits v
    LEFT JOIN Transactions t
    ON v.user_id = t.user_id
    AND v.visit_date = t.transaction_date
    GROUP BY v.user_id, v.visit_date
), base AS (
    SELECT LEVEL - 1 AS transactions_count
    FROM DUAL
    CONNECT BY LEVEL <= (SELECT MAX(transactions_count) + 1 FROM v_transactions_count)
)
SELECT b.transactions_count, COUNT(v.user_id) AS visits_count
FROM base b
LEFT JOIN v_transactions_count v
ON b.transactions_count = v.transactions_count
GROUP BY b.transactions_count
ORDER BY b.transactions_count;

