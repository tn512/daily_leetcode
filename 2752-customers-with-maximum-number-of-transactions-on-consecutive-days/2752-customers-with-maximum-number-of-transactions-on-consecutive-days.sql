-- 2752. Customers with Maximum Number of Transactions on Consecutive Days

-- Main Solution
WITH consecutive_trans AS (
    SELECT customer_id, transaction_date,
           transaction_date 
           - ROW_NUMBER() OVER (PARTITION BY customer_id 
                                ORDER BY transaction_date) AS group_id
    FROM Transactions
), rnk_trans AS (
    SELECT customer_id, group_id, 
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM consecutive_trans
    GROUP BY customer_id, group_id
)
SELECT customer_id
FROM rnk_trans
WHERE rnk = 1
ORDER BY customer_id;

