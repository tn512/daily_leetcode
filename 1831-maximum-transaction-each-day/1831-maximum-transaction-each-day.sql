-- 1831. Maximum Transaction Each Day

-- Main Solution
WITH temp AS (
    SELECT transaction_id,
           RANK() OVER (PARTITION BY TO_CHAR(day, 'YYYY-MM-DD') 
                        ORDER BY amount DESC) rnk
    FROM Transactions
)
SELECT transaction_id
FROM temp
WHERE rnk = 1
ORDER BY transaction_id;

