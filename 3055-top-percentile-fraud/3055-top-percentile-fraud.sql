-- 3055. Top Percentile Fraud

-- Main Solution
WITH percentile_rnk AS (
    SELECT f.*, 
           PERCENT_RANK() OVER (PARTITION BY state 
                                ORDER BY fraud_score DESC) AS pct_rnk
    FROM Fraud f
)
SELECT policy_id, state, fraud_score
FROM percentile_rnk
WHERE pct_rnk <= 0.05
ORDER BY state, fraud_score DESC, policy_id;

