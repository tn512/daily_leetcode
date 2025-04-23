-- 3230. Customer Purchasing Behavior Analysis

-- Main Solution
WITH amount_temp AS (
    SELECT t.customer_id, 
        ROUND(SUM(amount), 2) AS total_amount, 
        COUNT(*) AS transaction_count,
        COUNT(DISTINCT p.category) AS unique_categories,
        ROUND(AVG(amount), 2)  AS avg_transaction_amount,
        ROUND(COUNT(*) * 10 + (SUM(amount) / 100), 2) AS loyalty_score
    FROM Transactions t
    JOIN Products p
    ON p.product_id = t.product_id
    GROUP BY t.customer_id
), rank_category AS (
    SELECT t.customer_id, p.category,
           RANK() OVER (PARTITION BY t.customer_id 
                        ORDER BY COUNT(*) DESC, MAX(transaction_date) DESC) AS rnk
    FROM Transactions t
    JOIN Products p
    ON p.product_id = t.product_id
    GROUP BY t.customer_id, p.category
)
SELECT a.customer_id, a.total_amount, a.transaction_count, a.unique_categories, 
       a.avg_transaction_amount, r.category AS top_category, a.loyalty_score
FROM amount_temp a
JOIN rank_category r
ON a.customer_id = r.customer_id
AND r.rnk = 1
ORDER BY a.loyalty_score DESC, a.customer_id;

