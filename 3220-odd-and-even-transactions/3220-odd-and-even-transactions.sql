-- 3220. Odd and Even Transactions

-- Main Solution
SELECT TO_CHAR(transaction_date, 'YYYY-MM-DD') AS transaction_date,
       SUM(CASE WHEN MOD(amount, 2) = 1 THEN amount ELSE 0 END) AS odd_sum,
       SUM(CASE WHEN MOD(amount, 2) = 0 THEN amount ELSE 0 END) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;

