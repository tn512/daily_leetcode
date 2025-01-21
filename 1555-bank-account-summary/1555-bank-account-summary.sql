-- 1555. Bank Account Summary

-- Main Solution
WITH temp AS (
    SELECT paid_by AS user_id, amount * -1 AS amount
    FROM Transactions
    UNION ALL
    SELECT paid_to, amount
    FROM Transactions
    UNION ALL
    SELECT user_id, credit
    FROM Users u
)
SELECT u.user_id, u.user_name, SUM(amount) AS credit,
       CASE WHEN SUM(amount) < 0 THEN 'Yes' ELSE 'No' END AS credit_limit_breached
FROM Users u
LEFT JOIN temp t
ON u.user_id = t.user_id
GROUP BY u.user_id, u.user_name;

