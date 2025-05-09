-- 3401. Find Circular Gift Exchange Chains

-- Main Solution
WITH cte (giver_id, receiver_id, len, gift_value) AS (
    -- Base Case: Start with each giver_id
    SELECT 
        giver_id, 
        receiver_id, 
        1 AS len, 
        gift_value
    FROM SecretSanta

    UNION ALL

    -- Recursive Case: Traverse the chain
    SELECT 
        a.giver_id, 
        b.receiver_id, 
        a.len + 1 AS len, 
        a.gift_value + b.gift_value AS gift_value
    FROM cte a
    JOIN SecretSanta b ON a.receiver_id = b.giver_id
    WHERE a.giver_id <> a.receiver_id
),
-- Select the closed chains and rank them
FinalResult AS (
    SELECT DISTINCT 
        len AS chain_length, 
        gift_value AS total_gift_value
    FROM cte
    WHERE giver_id = receiver_id
)
SELECT 
    RANK() OVER (ORDER BY chain_length DESC, total_gift_value DESC) AS chain_id, 
    chain_length, 
    total_gift_value
FROM FinalResult;

