-- 2228. Users With Two Purchases Within Seven Days

-- Main Solution
WITH temp AS (
    SELECT user_id, purchase_id, purchase_date,
           LEAD(purchase_date) OVER (PARTITION BY user_id 
                                     ORDER BY purchase_date) AS next_purchase_date
    FROM Purchases
)
SELECT DISTINCT user_id
FROM temp
WHERE next_purchase_date - purchase_date < 8
ORDER BY user_id;

