-- 1843. Suspicious Bank Accounts

-- Main Solution
WITH temp AS (
    SELECT t.account_id, TRUNC(t.day, 'MM') AS month
    FROM Transactions t
    JOIN Accounts a
    ON t.account_id = a.account_id
    WHERE t.type = 'Creditor'
    GROUP BY t.account_id, TRUNC(t.day, 'MM'), a.max_income
    HAVING SUM(t.amount) > a.max_income
)
SELECT DISTINCT t1.account_id
FROM temp t1
JOIN temp t2
ON t1.month = ADD_MONTHS(t2.month, 1)
AND t1.account_id = t2.account_id
WHERE t2.account_id IS NOT NULL;

