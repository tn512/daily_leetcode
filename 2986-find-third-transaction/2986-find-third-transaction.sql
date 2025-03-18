-- 2986. Find Third Transaction

-- Main Solution
WITH rn_trans AS (
    SELECT user_id, spend, transaction_date,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rn,
           MAX(spend) OVER (PARTITION BY user_id ORDER BY transaction_date
                            ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS sm
    FROM Transactions
)
SELECT user_id, spend AS third_transaction_spend,
       transaction_date AS third_transaction_date
FROM rn_trans
WHERE rn = 3
AND spend > sm;

