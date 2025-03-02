-- 2701. Consecutive Transactions with Increasing Amounts

-- Main Solution
WITH base_date AS (
    SELECT (SELECT MIN(transaction_date) FROM Transactions) + LEVEL - 1 AS dt,
           LEVEL AS rnk
    FROM DUAL
    CONNECT BY LEVEL <= (SELECT MAX(transaction_date) - MIN(transaction_date) FROM Transactions) + 1
), increasing_amt AS (
    SELECT c1.*
    FROM Transactions c1
    JOIN Transactions c2
    ON c1.customer_id = c2.customer_id
    AND c1.transaction_date = c2.transaction_date - 1
    AND c1.amount < c2.amount
), consecutive_trans AS (
    SELECT i.customer_id, i.transaction_date,
           b.rnk - RANK() OVER (PARTITION BY i.customer_id 
                                      ORDER BY i.transaction_date) AS gap_date
    FROM increasing_amt i
    JOIN base_date b
    ON b.dt = i.transaction_date
)
SELECT customer_id, 
       TO_CHAR(MIN(transaction_date), 'YYYY-MM-DD') AS consecutive_start,
       TO_CHAR(MAX(transaction_date) + 1, 'YYYY-MM-DD') AS consecutive_end
FROM consecutive_trans
GROUP BY customer_id, gap_date
HAVING COUNT(*) > 1
ORDER BY customer_id, consecutive_start, consecutive_end;

-- Alternative Solution
WITH increasing_amt AS (
    SELECT c1.customer_id, c1.transaction_date
    FROM Transactions c1
    JOIN Transactions c2
    ON c1.customer_id = c2.customer_id
    AND c1.transaction_date = c2.transaction_date - 1
    AND c1.amount < c2.amount
), rnk_trans AS (
    SELECT customer_id, transaction_date,
           transaction_date 
           - ROW_NUMBER() OVER (PARTITION BY customer_id 
                              ORDER BY transaction_date) AS group_id
    FROM increasing_amt
)
SELECT customer_id, 
       TO_CHAR(MIN(transaction_date), 'YYYY-MM-DD') AS consecutive_start,
       TO_CHAR(MAX(transaction_date) + 1, 'YYYY-MM-DD') AS consecutive_end
FROM rnk_trans
GROUP BY customer_id, group_id
HAVING COUNT(*) > 1
ORDER BY customer_id, consecutive_start, consecutive_end;
