-- 574. Winning Candidate

-- Main Solution
WITH vote_count AS (
    SELECT candidateId, COUNT(id) AS cnt
    FROM Vote
    GROUP BY candidateId
    ORDER BY cnt DESC
)
SELECT c.name
FROM vote_count v, Candidate c
WHERE cnt = (SELECT MAX(cnt) FROM vote_count)
AND v.candidateId = c.id;

