-- 2041. Accepted Candidates From the Interviews

-- Main Solution
SELECT c.candidate_id
FROM Candidates c
JOIN Rounds r
ON c.years_of_exp > 1
AND c.interview_id = r.interview_id
GROUP BY r.interview_id, c.candidate_id
HAVING SUM(score) > 15;

