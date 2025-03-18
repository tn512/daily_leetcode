-- 2820. Election Results

-- Main Solution
WITH vote_value AS (
    SELECT voter, candidate,
           1 / COUNT(*) OVER (PARTITION BY voter) AS val
    FROM Votes
), vote_rnk AS (
    SELECT candidate,
           RANK() OVER (ORDER BY SUM(val) DESC) AS rnk
    FROM vote_value
    GROUP BY candidate
)
SELECT candidate
FROM vote_rnk
WHERE rnk = 1
ORDER BY candidate;

