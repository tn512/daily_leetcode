-- 2066. Account Balance

-- Main Solution
SELECT account_id, TO_CHAR(day, 'YYYY-MM-DD') AS day,
       SUM(CASE WHEN type = 'Deposit' THEN amount
                ELSE -amount
           END) OVER (PARTITION BY account_id 
                      ORDER BY day) AS balance
FROM Transactions;

